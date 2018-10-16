//
//  AMF3Coder.swift
//  AMFCoderTest
//
//  Created by Tony Henderson on 12/7/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation

class AMF3Constants{
    
    public static let  MaxU29:UInt = 0x1FFFFFFF;
    public static let  MaxInt29Range:Int = 268435456;
    
}

/// AMF3 Type values 0-16
public enum AMF3DataType : UInt8 {
    case undefinedType = 0x0
    case nullType = 0x1
    case falseType = 0x2
    case trueType = 0x3
    case integerType = 0x4
    case doubleType = 0x5
    case stringType = 0x6
    case xmlDocType = 0x7
    case dateType = 0x8
    case arrayType = 0x9
    case objectType = 0xA
    case xmlType = 0xB
    case byteArrayType = 0xC
    case vectorIntegerType = 0xD
    case vectorUnsignedIntegerType = 0xE
    case vectorNumberType = 0xF
    case vectorObjectType = 0x10
    case dictionaryType = 0x11
}


/////////////////////////////////
/// External methods
/// * Credit to Shogo
/////////////////////////////////
public let kASUndefinedType:ASUndefinedType = ASUndefinedType()
//public typealias ASObject = [String: Any?]

public final class ASUndefinedType: NSObject {
    public override var description:String {
        return "undefined"
    }
    fileprivate override init() {
        super.init()
    }
}

public enum AMFCoderError: Error {
    case featureNotSupported
    case decode
    case outOfIndex
}


open class AMF3Coder : AMFCoder{
    
    
    public static var verboseDebug:Bool = false
    
    override public init(){

         _referenceData = ReferenceData()
        
        super.init()
        
    }
    
    func registerClassNameAlias(_ value: BasicObject){
        
        let name:String = String(describing: type(of: value))
        let alias = value.remoteClassAlias
        
        if(alias == nil){
            if(AMF3Coder.verboseDebug){ print("Class type: [\(name)] not supported for registration.") }
            return
        }
        
        let classMap:ClassMap = ClassMap(className: name, classAlias: alias!)
        
        if(referenceData.indexOf(classMap, isFromClassName:true) == nil){
            
            referenceData.add(classMap)
            return
        }
        
        if(AMF3Coder.verboseDebug){ print("Warning: Class alias: [\(alias!)] already exists for registered type: [\(name)]") }
    }
    
    func registerClassNameAlias(_ value: AnyObject, alias:String){
        
        let name:String = String(describing: type(of: value))
        
        switch(value){
            
            case _ as BasicObject:
                
                let classMap:ClassMap = ClassMap(className: name, classAlias: alias)
                
                if(referenceData.indexOf(classMap, isFromClassName:true) == nil){
                    
                    referenceData.add(classMap)
                    break
                }
                
                if(AMF3Coder.verboseDebug){ print("Warning: Class alias: [\(alias)] already exists for registered type: [\(name)]") }
              
                
            break
            
//        case let asObj as ASObject:
//            
//            if(asObj.isTyped){
//                
//            }
//            
//            let classMap:ClassMap = ClassMap(className: name, classAlias: alias)
//            
//            if(referenceData.indexOf(classMap, isFromClassName:true) == nil){
//                
//                referenceData.add(classMap)
//                break
//            }
//            
//            print("Warning: Class alias: [\(alias)] already exists for registered type: [\(name)]")
//            
//            break

            
        default:
            if(AMF3Coder.verboseDebug){
                print("Class type: [\(name)] not supported for registration.")
            }
            
        }
    }
    
//    func getClassNameFromAlias(alias:String) -> String{
//        
//        let className = referenceData.getClassMapFromClassAlias(alias)
//        
//        if(  className != nil){
//            return className!
//        }
//        
//        return ""
//    }

    
    fileprivate var _referenceData:ReferenceData
    
    
    
    open var referenceData:ReferenceData{
        
        get { return _referenceData }
        //set { _referenceData = newValue }
    }
    
    override open func clear() -> Self {
        
        resetReferences()
         super.clear()
        
        return self
    }
    
    override open func removeAllClassMaps(){
        
        _referenceData.reset()
    }
    
    override public func decodeValue(_ bytes:[UInt8]?) throws -> Any? {
        resetReferences()
        return try super.decodeValue(bytes)
    }
    
    @discardableResult
    override public func encode(_ value:Any?) -> Self{
        
        switch value
        {
            
        case nil:
            encodeMarker(.nullType)
        case let uint as UInt:
            encodeUInt29(uint)
        case let int as Int:
            encodeInt( int )
        case let float as Float:
            encodeDouble( Double(float))
        case let double as Double:
            encodeDouble(double)
        case let string as String:
            encodeString(string)
        case let date as Date:
            encodeDate(date)
        case let bool as Bool:
            encodeBool(bool)
        case let array as [Any?]:
            encodeArray(array)
        case let array as [Any]:
            encodeArray(array)
        case let asArray as ASArray:
            encodeArray(asArray)
        case let value as BasicObject:
            encodeObject(value)
        case let value as [String:Any]:
            encodeDictionary(value)
        case let value as [String:Any?]:
            encodeDictionary(value)

       
        default:
            encodeMarker(.undefinedType)
        }
        
        return self
    }
    
    
    override public func decode() throws -> Any?
    {
        
        let markerByte:UInt8 = try decodeMarker()
        
        switch markerByte{
            
        case AMF3DataType.nullType.rawValue:
            return nil
        case AMF3DataType.integerType.rawValue:
            return try decodeInt()
        case AMF3DataType.doubleType.rawValue:
            return try decodeDouble()
        case AMF3DataType.stringType.rawValue:
            return try decodeString()
        case AMF3DataType.falseType.rawValue:
            return false
        case AMF3DataType.trueType.rawValue:
            return true
        case AMF3DataType.dateType.rawValue:
            return try decodeDate()
        case AMF3DataType.arrayType.rawValue:
            
            let asArray:ASArray = try decodeArray()
            return asArray.data
        case AMF3DataType.objectType.rawValue:
            return try decodeObject()
        case AMF3DataType.dictionaryType.rawValue:
            return try decodeDictionary()
        case AMF3DataType.undefinedType.rawValue:
            position += 1
            return kASUndefinedType
        case AMF3DataType.nullType.rawValue:
            position += 1
            return nil

        default:
            print("Type not supported")
            return nil
        }
    }
    

    fileprivate func printMarker(marker:AMF3DataType, isEncoding:Bool=true){
        
        let action:String = (isEncoding) ? "Encoding:": "Decoding:"
        
        
        if AMF3Coder.verboseDebug {
            switch marker{
                
            case AMF3DataType.nullType:
                print("\(action) AMF3DataType.nullType")
            case AMF3DataType.integerType:
                print("\(action) AMF3DataType.integerType")
            case AMF3DataType.doubleType:
                print("\(action) AMF3DataType.doubleType")
            case AMF3DataType.stringType:
                print("\(action) AMF3DataType.stringType")
            case AMF3DataType.falseType:
                print("\(action) AMF3DataType.falseType")
            case AMF3DataType.trueType:
                print("\(action) AMF3DataType.trueType")
            case AMF3DataType.dateType:
                print("\(action) AMF3DataType.dateType")
            case AMF3DataType.arrayType:
                print("\(action) AMF3DataType.arrayType")
            case AMF3DataType.objectType:
                print("\(action) objectType")
            case AMF3DataType.undefinedType:
                print("\(action) Type is undefined")
            default:
                print("\(action) Type not supported")
            }
        }
    }
    
   override func decodeMarker(  ) throws -> UInt8{
    
        guard let marker:AMF3DataType = AMF3DataType(rawValue: try decodeUInt8()) else {
            throw AMFCoderError.decode
        }
    
        printMarker(marker: marker, isEncoding: false)
    
        return marker.rawValue
    }

    @discardableResult
    func encodeMarker( _ marker:AMF3DataType ) -> Self {
        
        encodeBytes([marker.rawValue])
        
        printMarker(marker: marker)
        
        return self
    }
    
    
    /// <summary>
    /// Writes a 32-bit signed integer to the current position in the AMF stream.
    /// </summary>
    /// <param name="value">A 32-bit signed integer.</param>
    /// <remarks>Type marker is written in the AMF stream.</remarks>
    @discardableResult
    override public func encodeInt(_ value: Int, excludeMarker: Bool=false) -> Self {
        
        //check valid range for 29bits
        if( value <= Int(AMF3Constants.MaxU29) && value > 0){
            encodeUInt29( UInt(value), excludeMarker: excludeMarker )
        }
        else{
            encodeDouble(Double(value), excludeMarker: excludeMarker)
        }

        return self
    }
    
    override func decodeInt() throws -> Int
    {
        var byteLen:Int = 0
        var value:UInt = 0
        var byte:UInt8 = try decodeUInt8() // First byte
        
        while (((byte & 0x80) != 0) && (byteLen < 3))
        {
            value = (value << 7) | UInt(byte & 0x7F)
            byte = try decodeUInt8()
            byteLen += 1;
        }
        
        // Determine last byte
        if (byteLen < 3){
            value = (value << 7) | UInt(byte & 0x7F)
        }
        else{
            value = (value << 8) | UInt(byte & 0xFF)
        }
        
        return Int(value)
    }
    
    @discardableResult
    override  public func encodeBool(_ value: Bool) -> Self {
        
        encodeMarker( (value) ? .trueType : .falseType )
        super.encodeBool(value)
        
        return self
    }
    
    @discardableResult
    override public func encodeDouble(_ value: Double, excludeMarker:Bool=false) -> Self {
        
        if(!excludeMarker) { encodeMarker( .doubleType ) }
        super.encodeDouble(value)
        
        return self
    }
    
    @discardableResult
    override  public func encodeDate(_ value:Date) -> Self{
        
        encodeMarker( .dateType)
        
        // Check for reference
        if let referenceIndex:Int = referenceData.indexOf(value) {
            
            let action = "Encoding:"
            
            if(AMF3Coder.verboseDebug){
                print("\(action) Date (Ref) at index:\(referenceIndex)")
            }
            
            let zeroBasedIndex = referenceIndex // For zero based array
            return encodeReference(index: zeroBasedIndex)
        }

        // Add Reference
        referenceData.add(value)
        
        encodeAmfInlineHeader(0) // Denotes inline object //encodeUInt29((0 << 1) | 1, excludeMarker: true)

        encodeDouble(value.timeIntervalSince1970 * 1000, excludeMarker: true)
        
        return self
    }

    func decodeDate() throws -> Date
    {
        let header  = try decodeHeader()
        
        // Return reference
        if (header.isReference){
            let action = "Decoding:"
            
            if(AMF3Coder.verboseDebug){
               print("\(action) Date (Ref) at index:\(header.value)")
            }
            
            
            let zeroBasedIndex = header.value
            
//            if(zeroBasedIndex < 0){
//                 return ""
//            }
            return try referenceData.getObject(zeroBasedIndex) as! Date
        }


//        let refs:Int = Int(try decodeInt()) // References for future
//                if (refs & 0x01) == 0 {
//                    guard let date:Date = try reference.getObject(refs >> 1) as? Date else {
//                        throw AMFSerializerError.deserialize
//                    }
//                    return date
//                }
        
        
        let value:Date = Date(timeIntervalSince1970: try decodeDouble() / 1000)
        
        // Add Reference
        referenceData.add(value)
        
        return value
    }


    @discardableResult
    func encodeString(_ value:String ) -> Self{
        
        encodeMarker(.stringType )

        encodeUTFBytes(value)
        
        return self
    }
    
    
    @discardableResult
    override public func encodeUTFBytes(_ value: String) -> Self {
        
        // If reference, write reference index in string table
        if (value.isEmpty) {
//            let action = "Encoding:"
//            print("\(action) AMF3DataType.stringType (Empty)")

            return encodeAmfInlineHeader(0) // Empty string are never returned by reference
        }

        if let referenceIndex:Int = referenceData.indexOf(value) {
            return encodeStringReference(referenceIndex)
        }
        
        referenceData.add(value)
        
        super.encodeUTFBytes(value)
        
        return self
    }
    
    
  
    override func decodeString() throws -> String
    {
        let header  = try decodeHeader()
        
        
        // Return reference
        if (header.isReference){
            
            if(AMF3Coder.verboseDebug){
                let action = "Decoding:"
                print("\(action) String (Ref) at index:\(header.value)")
            }
            
            let zeroBasedIndex = header.value
            
            if(zeroBasedIndex < 0){
                return ""
            }
            return try referenceData.getString(zeroBasedIndex)
        }
        
        let length = header.value
        
        if (length == 0){ return "" }
        
        let string = try decodeUTFBytes(length)
        
        referenceData.add(string)
        
        return string
        
    }

    
    fileprivate func decodeHeader() throws -> InlineHeader{
        let data = try decodeInt()
        
        let header = InlineHeader(isReference: (data & 1) == 0, value: Int(data >> 1))
//        let action = "Decoding:"
//        if(header.isReference){
//             print("\(action) Header isRef:\(header.isReference) value:\(header.value)")
//        }
       
        return header
    
    }
    
    struct InlineHeader
    {
        var isReference:Bool
        var value:Int
    }
    
    override open func decodeUTFBytes(_ length: Int) throws -> String {
       
//        if (length <= 0){
//            return ("")
//        }

        return try super.decodeUTFBytes(length)
    }

    @discardableResult
    func encodeUInt29( _ value:UInt, excludeMarker:Bool=false )  -> Self {
        
        //check valid range for 29bits
        if( value > Int(AMF3Constants.MaxU29) && value > 0){
            encodeDouble(Double(value), excludeMarker: excludeMarker)
            
            return self
        }
       
        
        var bytes:[UInt8] = [UInt8]()
        
        //uint &= 0x1fffffff;
        
        if (value < 0x80){
            bytes.append(UInt8(value))
        }
        else if (value < 0x4000){
            bytes.append(UInt8(((value >> 7) | 0x80)))
            bytes.append(UInt8((value & 0x7F)));
        }
        else if (value < 0x200000){
            bytes.append(UInt8(((value >> 14) | 0x80)))
            bytes.append(UInt8((((value >> 7) & 0x7F) | 0x80)))
            bytes.append(UInt8((value & 0x7F)))
        }
        else{
            bytes.append(UInt8(((value >> 22) | 0x80)))
            bytes.append(UInt8((((value >> 15) & 0x7F) | 0x80)))
            bytes.append(UInt8((((value >> 8) & 0x7F) | 0x80)))
            bytes.append(UInt8((value & 0xFF)))
        }
        
        // Marker not required for header
        if(!excludeMarker){ encodeMarker( .integerType ) }
        
        encodeBytes(bytes)
        
        return self
        
    }

    @discardableResult
    func encodeArray(_ value:[Any?]) -> Self{
        
        // 1. encode Marker
        // 2. Inline header of content len
        // 3. empty key signifies end of associative section of array
        encodeMarker( .arrayType )
        encodeAmfInlineHeader(value.count)
        encodeUTFBytes( "")
        
        let refPlaceHolder:BasicObject = BasicObject()
        refPlaceHolder.remoteClassAlias = UUID().uuidString
        referenceData.add(refPlaceHolder)
        
        return encodeDenseArray(value)
    }

    
    @discardableResult
    func encodeArray(_ value:[Any]) -> Self{
        
        // 1. encode Marker
        // 2. Inline header of content len
        // 3. empty key signifies end of associative section of array
        encodeMarker( .arrayType )
        encodeAmfInlineHeader(value.count)
        encodeUTFBytes( "")
        
        let refPlaceHolder:BasicObject = BasicObject()
        refPlaceHolder.remoteClassAlias = UUID().uuidString
        referenceData.add(refPlaceHolder)
        
        return encodeDenseArray(value)
    }
    
    func encodeArray(_ value:ASArray){
        
        encodeMarker( .arrayType )
        
        //print(" array value has address: \(unsafeAddressOf(value))")
        //print(" str value \(str) has address: \(unsafeAddressOf(value))")
        
        
        //        // Reference exists, return
        //        if(hasReferenceData(value)){
        //            return
        //        }
        //
        //
        //        // Add Reference
        //        addReferenceData(value)
        
       
        
        encodeAmfInlineHeader(value.length)
        
        encodeAssociativeArray(value.dict)
        
//        let refPlaceHolder:BasicObject = BasicObject()
//        refPlaceHolder.remoteClassAlias = UUID().uuidString
//        referenceData.add(refPlaceHolder)        // Inline header of content len
        
        encodeDenseArray(value.data)
    }
    
    @discardableResult
    func encodeDenseArray(_ value:[Any?]) -> Self{
        
        for item in value { encode(item) }

        return self
    }
    
    @discardableResult
    func encodeAssociativeArray(_ value:[String: Any?]) -> Self{
        
        for (key, value) in value { encodeUTFBytes(key).encode(value) }
        
        return encodeUTFBytes( "") // empty key signifies end of associative section of array
    }
    
    @discardableResult
    func encodeAssociativeArray(_ value:[String: Any]) -> Self{
        
        for (key, value) in value { encodeUTFBytes(key).encode(value) }
        
        return encodeUTFBytes( "") // empty key signifies end of associative section of array
    }
    
    
    func decodeArray() throws -> ASArray
    {
        
        let header  = try decodeHeader()
        
        // Check for reference
        if (header.isReference){
            return try referenceData.getObject(header.value) as! ASArray
        }

        let byteLen:Int = header.value
        
        //let header = Int(try decodeInt());
        //let byteLen:Int = Int(header >> 1)
        
        var asArr:ASArray = ASArray(count: byteLen)
        
//        var isAssociativeArray:Bool = false
        
        // Associative Array
        while (true) {
            
            // Get key
            let key = try decodeString()
            
            guard key != "" else {
                break
            }
            
//            if(isAssociativeArray != true){
//                isAssociativeArray = true
//            }
            
            let any:Any? = try decode()

            // Get value
            asArr[key] = any
        }
        
       
        // Add reference if not an Associative array
        if( asArr.dict.count == 0 ){
            referenceData.add(asArr)
        }
        
        // Strict Array
        for i in 0..<byteLen {
            asArr[i] = try decode()
        }
        
        
        return asArr
    }
    
    func decodeAssociativeArray() throws -> [String: Any?]{
        
        var value:[String: Any?] = [:]
        
        while (true) {
            
            // Get key
            let key = try decodeString()
            
            guard key != "" else {
                break
            }
            
            let any:Any? = try decode()
            
            // Get value
            value[key] = any
        }
        
        return value

    }
    
    func decodeDenseArray(byteLen:Int) throws -> [Any?]{
        
        var value:[Any?] = []
        
        // Strict Array
        for i in 0..<byteLen {
            value[i] = try decode()
        }
        
        return value
    }
    
    
    @discardableResult
    func encodeDictionary(_ value:[String: Any?]) -> Self{
        
        encodeMarker(.arrayType)
        
        // Inline header of content (0) for dictionary
        encodeAmfInlineHeader(0)
        
        return encodeAssociativeArray(value)
    }
    
    @discardableResult
    func encodeDictionary(_ value:[String: Any]) -> Self{
        
        encodeMarker(.arrayType)
        
        // Inline header of content (0) for dictionary
        encodeAmfInlineHeader(0)
        
        return encodeAssociativeArray(value)
    }

    
    func decodeDictionary() throws -> [String: Any?]{
        
        return try decodeAssociativeArray()
    }


    
    func encodeClassDefinition(_ value:BasicObject,
                               excludeMarker:Bool=false ) -> ClassDefinition? {
        
        // 1. Determine Class Mapping
        let clsName:String = String(describing: type(of: value))
        var clsMap:ClassMap? = nil
        var remoteAlias:String? = value.remoteClassAlias
        var isTyped:Bool = (remoteAlias != nil) ? true : false
        
        if remoteAlias == nil {
            // No class alias was set in the object, check to see if it was added through the mapping
            clsMap =  referenceData.getClassMap(clsName, isFromClassName:true)
            isTyped = ((clsMap) != nil) ? true : false
            remoteAlias = (isTyped) ? (clsMap?.classAlias)!: clsName
        }
        else{
            clsMap = referenceData.getClassMap(clsName, isFromClassName: true)
            
            if clsMap == nil {
                referenceData.add(ClassMap(className: clsName, classAlias: remoteAlias!))
            }
        }
        
        // 2. Get Class Definition
        var clsDef:ClassDefinition? = referenceData.getClassDefinition(remoteAlias!)
        
        if clsDef != nil {
            
            let clsDefRefIdx = referenceData.indexOf(clsDef!)
            let clsDict = ObjectUtils.toDictionary(value)
            
            encodeAmfInlineHeader(clsDefRefIdx! << 1);
            
            for (_, value) in clsDict {
                encode(value)
                //print("Property Value: \(value)")
            }
            
            return nil
        }
        
        clsDef = ClassDefinition(name: remoteAlias!,
                                 isTyped: isTyped,
                                 members: ObjectUtils.toClassMembers(value),
                                 isDynamic: false,
                                 isExternalizable: false)
        
        // 3. Cache Class Definition reference
        referenceData.add(clsDef!)
        
        return clsDef
    }
    
    @discardableResult
    override open func encodeObject(_ value:BasicObject, excludeMarker:Bool=false ) -> Self{
        
        encodeMarker(.objectType)
        
        // 1. If Object is a reference, return reference
        if let objectRefIndex = referenceData.indexOf(value) {
            return encodeReference(index: objectRefIndex)
        }
        
        // 2. Add object to reference data
        referenceData.add(value)
       
        // 3. Get Class Definition
        let clsDef:ClassDefinition? = encodeClassDefinition(value)
        
        if clsDef == nil {
            
            // 3.1 Class Definition was already cached and properties encoded
            return self
        }
        
        // 4. Encode Class Definition and values
        ///Note: Externalizable classes/serialization is not supported at this time
        if (clsDef?.isExternalizable)! {
            
        }
        else{
            
            let header = ClassDefinition.getFlags(clsDef!)
           
            encodeAmfInlineHeader(header)
            
            encodeUTFBytes((clsDef!.isTyped) ? (clsDef?.name)!: "") // Class name
            
            let clsDict = (value is DynamicObject) ? (value as! DynamicObject).properties  : ObjectUtils.toDictionary(value)
            
            // Write class properties & values
            for (key, _) in clsDict {
                encodeUTFBytes(key)
                if(AMF3Coder.verboseDebug){
                    print("Property Key: \(key)")
                }
                
            }
            
            for (key, value) in clsDict {
                 
                encode((value == nil) ? nil : value!)
                
                if(AMF3Coder.verboseDebug){
                    print("Key Value: \(key)")
                    print("Property Value: \((value == nil) ? "nil" : value!)")
                }
            }

            ///Note: Dynamic classes are not supported at this time
            if(clsDef?.isDynamic)!{
                
                //throw AMFCoderError.featureNotSupported
                // Not supported yet
                //        if(clsDef.isDynamic){
                //            for (key, value) in clsMemberDict {
                //                encodeString(key, excludeMarker:true)
                //                encode(value)
                //                print("Property Key: \(key) Value: \(value)")
                //            }
                //
                //            // empty key signifies end of hash map
                //            encodeUTFBytes( "")
                //
                //        }
            }

  
            
        }
        
        return self
    }
    
    override open func addClassMap(map:ClassMap){
        
        _referenceData.add(map)
    }


    func decodeClassDefinition(flags:Int) throws -> ClassDefinition{
        
        let isReference = (flags & 1) == 0
        
        if (isReference){
           return try referenceData.getClassDefinition(Int(flags >> 1))
        }
 
        let clsAlias = try decodeString()
        let clsMap = referenceData.getClassMap(clsAlias, isFromClassName: false)
        let isTyped:Bool = (clsMap != nil)
        let clsMemberCount = ClassDefinition.classMemberCount(flags)
        
        // Decode class member
        var members:[String]=[]
        var memberName:String
        for index in 0..<clsMemberCount {
            
            memberName = try decodeString()
            
            if(AMF3Coder.verboseDebug) { print("Member: \(memberName) at Index: \(index)") }
            members.append(memberName)
        }
      
        let clsDef:ClassDefinition = ClassDefinition(name: clsAlias, isTyped: isTyped, members: members, flags: flags)

        // Only store clsDefinitions with members
        if(clsMemberCount > 0){
            referenceData.add(clsDef)
        }
        
        return clsDef
    }
    
    
    func decodeObject() throws -> BasicObject
    {
        
        let header  = try decodeHeader()
        
        // Check for reference
        if (header.isReference){
            return try referenceData.getObject(header.value) as! BasicObject
        }
        
         //print("Decode Bytes before: \(position)")
        let clsDef:ClassDefinition = try decodeClassDefinition(flags: header.value)
        let clsMap = referenceData.getClassMap(clsDef.name, isFromClassName: false)
        
        // print("Decode Bytes after: \(position)")
        // Use generic ASObject if no class type was found
        let clsInstance = (clsDef.isTyped == false) ? ASObject() : (NSClassFromString((clsMap?.className)!) as! BasicObject.Type).init()
        
        referenceData.add(clsInstance)
        
        ///Note: Externalizable classes/serialization is not supported at this time
        if(clsDef.isExternalizable){
            // Throw error
            throw AMFCoderError.featureNotSupported
        }
        else{
            // Setting all values for class
            var anyValue:Any?
            
            for member in clsDef.members{
                 
                anyValue = try decode()
                 
                if(clsDef.isTyped){
                    
                    if(anyValue == nil){
                        continue
                    }
                    
                    clsInstance.setValue(anyValue, forKey: member)
                    continue
                    //try clsInstance.set(value: anyValue!, key: member)
                }
               
                // Use ASObject if not typed
                (clsInstance as? ASObject)?.properties[member] = anyValue
            }
            
            ///Note: Dynamic classes are not supported at this time
            if(clsDef.isDynamic){
                
                // Associative Array
                while (true) {
                    
                    // Get key
                    let dynamicMember = try decodeString()
                    
                    guard dynamicMember != "" else {
                        break
                    }
                    
                    let dynamicValue:Any? = try decode()
                    
                    if(clsDef.isTyped){
                        try clsInstance.set(value: dynamicValue!, key: dynamicMember)
                        
                        continue
                    }
                    
                    // Use ASObject if not typed
                    (clsInstance as? ASObject)?.properties[dynamicMember] = dynamicMember


                    
                    // Get value
                    //(clsInstance as? ASObject)?.properties[key] = any
 
                }

                //throw AMFCoderError.featureNotSupported
                
                //
                //            while (true) {
                //
                //                // Get key
                //                let key = try decodeString()
                //
                //                if(key == clsDef.name){
                //                    print("issue")
                //                    continue
                //                }
                //                else{
                //                    print(key)
                //                }
                //                guard key != "" else { break }
                //
                //                anyValue = try decode()
                //
                //                do {
                //                    if(clsDef.isTyped == false){
                //                        asObject.properties[key] = anyValue
                //                    }
                //                    else{
                //                        try asObject.set(value: anyValue!, key: key)
                //                    }
                //                    
                //                } catch {
                //                    print("Error: \(error ) \"\(key )\"- value: \(String(describing: anyValue!))")
                //                }
                //            }
                
                //return (clsInstance )
                
            }

        }
        
        return (clsInstance )
    }


    fileprivate func encodeStringReference(_ index:Int) -> Self{
        
        let oneBasedIndex = index// + 1 // 1 Based array values for References
        
        if(AMF3Coder.verboseDebug){
            let action = "Encoding:"
            print("\(action) String (Ref) at index:\(oneBasedIndex)")
        }

        return encodeReference(index: oneBasedIndex)
        
    }
    
    fileprivate func encodeReference(index:Int) -> Self{
        //print("Ref Bytes before: \(super.bytes.count)")
        
        // 0 == not inline (an object reference)
        encodeInt(index << 1, excludeMarker: true)
        //print("Ref Bytes after: \(super.bytes.count)")
       
        
        return self
        
    }
    
    
    
   override open func encodeMessageHeader(header:AMFMessageHeader){
   
        resetReferences()
        
        encodeUTFBytes(header.name!)
        encodeBool(header.mustUnderstand)
        encodeInt(-1)
        encode(header.content)
        
    }
 
    override open func resetReferences(){
        
        _referenceData.reset(excludeClassMap: true)
        
    }
    
//    override open func encodeMessage( message: AMFMessage){
//        resetReferences()
//        super.encodeMessage(message: message)
//    }

    //    func isReference(index:Int)->Bool{
    //
    //       return ((index & 0x01) == 0 ) ?  true : false
    //    }
    
    //    fileprivate func decodeReference(index:Int) throws -> String{
    //
    //        let reference = try referenceData.getString(index >>  1)
    //        print("got string reference for: " + reference)
    //
    //        return reference
    //        
    //    }
    //

    
}
