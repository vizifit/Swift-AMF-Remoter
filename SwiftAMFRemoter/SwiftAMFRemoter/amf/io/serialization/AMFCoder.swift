//
//  AMFCoder.swift
//  SwiftAMFManager
//
//  Created by Tony Henderson on 12/7/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation


public enum ObjectEncoding : Int {
    case amf0 = 1
    case amf3 = 3
    case unknown = 4
}


open class AMFCoder: AMFByteArray, IAMFCoder {
    
    public static var bypassUtf16Length:Bool = false
    
    public func encodeValue(_ value:Any?) {
        
        clear()
        encode(value)
    }
    
    public func resetPosition() {
        position = 0
    }
    
    public func decodeValue(_ bytes:[UInt8]?) throws -> Any? {
       
        // Bytes are passed in
        if(bytes != nil){
            _bytes = bytes!
            
        }
        
        return try decode()
    }
    
    @discardableResult
    public func encode(_ value:Any?) -> Self{
        return self
    }
    
     @discardableResult
    public func decode() throws -> Any? {
        return nil
    }
    
    @discardableResult
    public func encodeDate(_ value:Date) -> Self{
        
        // Override 
        return self
    }

    
    @discardableResult
    public func encodeInt(_ value:Int, excludeMarker:Bool=false ) -> Self{
        //override
        
        return self
    }

    @discardableResult
    public func encodeBool(_ value: Bool) -> Self {
        
        return self
    }

    @discardableResult
    public func encodeDouble(_ value: Double, excludeMarker: Bool=false) -> Self {
        encodeBytes(value.bytes.reversed())
        return self
    }
    
//   override func decodeDouble() throws -> Double {
//        guard AMFCoder.sizeOfDouble <= bytesAvailable else {
//            throw AMFCoder.Error.eof
//        }
//        position += AMFCoder.sizeOfDouble
//        
//        return Double(bytes: Array(_bytes[position - AMFCoder.sizeOfDouble..<position].reversed()))
//    }
    
    func encodeUInt32(_ value:UInt32){
        encodeBytes(value.bigEndian.bytes)
    }
    
    func encodeInt32(_ value:Int32){
        encodeBytes(value.bigEndian.bytes)
    }
    
    func encodeShort(_ value:UInt16){
        encodeBytes(value.bigEndian.bytes)
    }
    
    
    @discardableResult
    public func encodeBigEndian(_ bytes:[UInt8]) -> Self {
        
        encodeBytes(bytes.reversed())
        
        return self
    }
    
    /// encodes `value` with the `inline object flag`. the object contents is expected to be written after this header.
    @discardableResult
    func encodeAmfInlineHeader(_ value:Int) -> Self{
      
        encodeInt( (value << 1) | 1, excludeMarker: true)
        
        return self
    }
    
    @discardableResult
    public func encodeUTFBytes(_ value:String) -> Self{
        
        let localBytes:[UInt8] = [UInt8](value.utf8)
        
        // Force maximum byte size for UTF string
        let byteCountConstrained = (localBytes.count > Int(UInt16.max)) ? Int(UInt16.max) : localBytes.count
        
        let byteCount = ( AMFCoder.bypassUtf16Length) ? localBytes.count : byteCountConstrained
 
        /// encode string header and value
        encodeAmfInlineHeader( byteCount )
        encodeBytes(localBytes)
        
        return self
    }
    
     @discardableResult
    func encodeUTFAMF0Bytes(_ value:String) -> Self{
        
        let localBytes:[UInt8] = [UInt8](value.utf8)
        
        // Force maximum byte size for UTF string
        let byteCount = (localBytes.count > Int(UInt16.max)) ? Int(UInt16.max) : localBytes.count
        
        /// encode string header and value
        encodeShort(UInt16(byteCount))
        encodeBytes(localBytes)
        
        return self
    }

    func decodeString() throws -> String
    {
        
        return String()
    }
    
    
    @discardableResult
    open func clear() -> Self {
        position = 0
        _bytes.removeAll()
        
        return self
    }
    
    open func resetReferences(){
        
        
    }
    
    
    open func encodeByte(_ value:UInt8){
        
        encodeBytes([value])

    }
    
    @discardableResult
    open func encodeObject(_ value:BasicObject, excludeMarker:Bool=false ) -> Self{
        
        return self
        
    }
   
    
    
    
    open func encodeMessageHeader(header:AMFMessageHeader){
    
        resetReferences()
        
        encodeUTFBytes(header.name!)
        encodeBool(header.mustUnderstand)
        encodeInt32(-1)
        encodeData(header.content as! BasicObject)
        
    }
    
    open func encodeData(_ value:Any?){
        
        encodeByte(17)
        encode(value)
        //encodeObject(value as! BasicObject)
        
    }

    
    open func encodeMessageBody(_ value:AMFMessageBody){
        
        // Target
        encodeUTFAMF0Bytes(value.target)
        
        // Response
        encodeUTFAMF0Bytes(value.response)
 
        // Flag
        encodeInt32(-1)
        
        
        encodeData(value.content)
        
//        if (this.Target == null)
//        writer.WriteUTF("null");
//        else
//        writer.WriteUTF(this.Target);
//        
//        if (this.Response == null)
//        writer.WriteUTF("null");
//        else
//        writer.WriteUTF(this.Response);
//        writer.WriteInt32(-1);
//        
    }
    
    open func encodeMessage( message: AMFMessage){
        
        clear()
    
        //encodeShort(UInt16(message.version.rawValue))
        encodeShort(3)
        
        let headerCount = message.headerCount()
        encodeShort(UInt16(headerCount))
        
        //encodeDouble(Double(headerCount)) // Header
        
        for i in 0..<headerCount{
            encodeMessageHeader(header: message.getHeaderAt(i)!)
        }
        
        let bodyCount = message.bodyCount()
        encodeShort(UInt16(bodyCount))
        
//        for i in 0..<bodyCount{
//            encodeMessageBody(message.getBodyAt(i))
//        }

        
        
        // NOTE: Can be more than one body
        encodeMessageBody(message.getBodyAt(0))
        
        
        
            
        //encode(message.getBodyAt(0))
        
//        for i in 0..<headerCount{
//            
//            encodeMessageHeader(header: message.getHeaderAt(i)!)
//        }
        
//        base.WriteShort(amfMessage.Version);
//        int headerCount = amfMessage.HeaderCount;
//        base.WriteShort(headerCount);
//        for(int i = 0; i < headerCount; i++)
//        {
//            this.WriteHeader(amfMessage.GetHeaderAt(i), ObjectEncoding.AMF0);
//        }
//        int bodyCount = amfMessage.BodyCount;
//        base.WriteShort(bodyCount);
        
    }
    
    func decodeInt() throws -> Int
    {

        return 0
    }
    
    func decodeMarker(  ) throws -> UInt8{
         
        return UInt8(0)
    }

    open func removeAllClassMaps(){
        
        
    }

    open func addClassMap(map:ClassMap){
        
        
    }
    
    open func decodeMessage(_ bytes:[UInt8]?) throws -> AMFMessage {
        
        // Bytes are passed in
        if(bytes != nil){
            _bytes = bytes!
        }
        else{
            
            // throw error here.
        }
        
        // Only support version 3 right now
        let amfVersion = try decodeUInt16()
        
        let encoding:ObjectEncoding =  (Int(amfVersion) == ObjectEncoding.amf3.rawValue) ? ObjectEncoding.amf3 : ObjectEncoding.unknown
        
        let message:AMFMessage = AMFMessage(version: encoding)
        
        // Header
        let headerCount = try Int(decodeUInt16())
        
        for _ in 0..<headerCount{
            message.addHeader(try decodeMessageHeader())
        }

        // Body
        let bodyCount = try Int(decodeUInt16())
        
        for _ in 0..<bodyCount{
            message.addBody(try decodeMessageBody())
        }

        
        return message
        
    }
    
    open func decodeMessageHeader() throws -> AMFMessageHeader  {
        
        // Reset oject references?? Need to understand this
        resetReferences()
        
        // Read name.
        let name:String = try decodeString()
        
        // Read must understand flag.
        let mustUnderstand:Bool = false
        
        // Read the length of the header.
        _ = try decodeInt32()
        
        // Read content.
        let content:AnyObject = "Replace with method" as AnyObject        //object content = base.ReadData();
        
        return   AMFMessageHeader(name: name, mustUnderstand: mustUnderstand, content: content);
 
        
    }


    open func decodeMessageBody() throws -> AMFMessageBody  {
        
        // Reset oject references?? Need to understand this
        resetReferences()
        
        // Target
        let targetValue = try decodeUTFBytes(Int(try decodeUInt16()))
        
        // Response
        let responseValue = try decodeUTFBytes(Int(try decodeUInt16()))
        
        // Placeholder: should be negative 1
        _ =  Int(try decodeInt32())
        
        _ = try decodeUInt8()
        
        var body:[Any]? = []
        body?.append(try decode()!)
        let amfBody:AMFMessageBody = AMFMessageBody(target: targetValue, response: responseValue, content: body)
        
        return amfBody
    }
    
    

    
}
