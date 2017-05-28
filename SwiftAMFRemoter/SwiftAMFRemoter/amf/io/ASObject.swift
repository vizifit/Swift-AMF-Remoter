//
//  ASObject.swift
//  SwiftAMFManager
//
//  Created by Tony Henderson on 12/30/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation



public let kASUndefined:ASUndefined = ASUndefined()

public final class ASUndefined: BasicObject {
    public override var description:String {
        return "undefined"
    }
    
    required public init() {
        super.init()
    }
}

open class ASObject: BasicObject{
    
    public var type: String?
    public var isExternalizable: Bool = false
    public var data: [AnyObject]?

    public var properties:[String:Any?]
    
//    open var properties:[String:Any?]{
//        get { return _properties }
//        set { _properties = newValue }
//    }
//    
//    open var data:[AnyObject]? {
//        
//        get{return self._data}
//        set{ self._data = newValue}
//    }
//    
//    open var type:String? {
//        
//        get{return self._type}
//        set{ self._type = newValue}
//    }
//    
//    open var isExternalizable:Bool {
//        
//        get{return self._isExternalizable}
//        set{ self._isExternalizable = newValue}
//    }
 
    open var isTyped:Bool{
        get { return (self.type != nil && self.type!.characters.count > 0) ? true : false }
    }
    
    open var hasProperties:Bool{
        get { return (self.properties.count>0) }
    }
    
    required public init() {
        
        self.properties = [:]
        
        super.init()
    }
    
    
    override open func setValue(_ value: Any?, forKey key: String) {
        self.properties[key] = value
    }
    
    override open func value(forKey key: String) -> Any? {
        return self.properties[key]!
    }
    
    open func addObject(_ obj: AnyObject) {
        if self.data == nil {
            self.data = [AnyObject]()
            self.isExternalizable = true
        }
        
        self.data?.append(obj)
        
    }
    
    open func count() -> Int {
        return self.isExternalizable ? self.data!.count : self.properties.count
    }
    
    open override var description: String{
        
        return ""
//        return "<\(self.self) = \(self) | type: \((_type == nil) ? "nil" : _type)>\n\(_properties)\ndata: \((_data == nil) ? "nil" : String(describing: _data))"
    }
    
    
    //    override open func isEqual(_ object: Any?) -> Bool {
    //
    //        if !(((object as AnyObject).isKind(of: ASObject))) {
    //            return false
    //        }
    //
    //        let asObj: ASObject = (object as! ASObject)
    //
    //
    //        // TODO: Need to add comparison of AnyObject
    //
    //        return ((asObj.type == nil && _type == nil) || asObj.type!.isEqual(_type))
    //            && asObj.isExternalizable == _isExternalizable
    //        //&& (_isExternalizable ? asObj.data.isEqual(_data) : asObj.properties.isEqual(_properties))
    //        
    //    }
}






// MARK: -
/**
 ActionScript 1.0 and 2.0 and flash.xml.XMLDocument in ActionScript 3.0
 
 - seealso:
 - 2.17 XML Document Type (amf0-file-format-specification.pdf)
 - 3.9 XMLDocument type (amf-file-format-spec.pdf)
 */
public final class ASXMLDocument: NSObject {
    public override var description:String {
        return data
    }
    
    fileprivate var data:String
    
    public init(data:String) {
        self.data = data
    }
}

// MARK: -
/**
 ActionScript 3.0 introduces a new XML type.
 
 - seealso: 3.13 XML type (amf-file-format-spec.pdf)
 */
public final class ASXML: NSObject {
    public override var description:String {
        return data
    }
    
    fileprivate var data:String
    
    public init(data:String) {
        self.data = data
    }
}

