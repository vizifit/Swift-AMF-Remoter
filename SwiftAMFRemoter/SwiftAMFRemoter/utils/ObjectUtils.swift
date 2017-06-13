//
//  ObjectUtils.swift
//  SwiftAMFManager
//
//  Created by Tony Henderson on 12/17/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation


open class ObjectUtils{
    
    
    static func unwrap(_ any: Any) -> Any? {
        let mi = Mirror(reflecting: any)
        if mi.displayStyle != .optional {
            return any
        }
        
        if mi.children.count == 0 { return nil }
        let (_, some) = mi.children.first!
        return some
    }
    
    static func isEnum(_ any: Any) -> Bool {
        return Mirror(reflecting: any).displayStyle == .enum
    }

    @discardableResult
    static func toDictionary(_ any: Any, excludePrivate:Bool=true, stripDash:Bool = true) -> [String: Any?] {
        
        var dict:[String: Any?] = [:]
        var mirror: Mirror? = Mirror(reflecting: unwrap(any)!)

        repeat {
            
            for (propName, propValue) in (mirror?.children)!  {

                //debugMirrorValue(enabled:false, mirror:mirror!, property:propName!, value: propValue)
                
                if continueIfPrivateVar(enabled: excludePrivate, value: propName!) { continue }
                
                let propName = sripDashIfRequired(enabled: stripDash, value: propName!)

                if let propValue: AnyObject = ObjectUtils.unwrap(propValue) as AnyObject? , let propName = propName {

                    if propValue is BasicObject {
                        dict[propName] = propValue as! BasicObject
                        continue
                    }
                    else if propValue is ASObject {
                        dict[propName] = propValue as! ASObject
                        continue
                    }
                    else if propValue is ASArray {
                        dict[propName] = propValue as! ASArray
                        continue
                    }
                    else if propValue is Dictionary<String, Any?> {
                        dict[propName] = propValue
                    }
                    else if propValue is Int || propValue is Double || propValue is Float || propValue is Bool {
                        dict[propName] = propValue
                    } else if let dataPropValue = propValue as? Data {
                        dict[propName] = dataPropValue.base64EncodedString(options: .lineLength64Characters) as AnyObject?
                    } else if let datePropValue = propValue as? Date {
                        dict[propName] = datePropValue.timeIntervalSince1970 as AnyObject?
                        //setValue(propertiesDictionary, value: datePropValue.timeIntervalSince1970 as AnyObject?, forKey: propName)
                    } else {
                        dict[propName] = propValue
                        //setValue(propertiesDictionary, value: propValue, forKey: propName)
                    }
                } else if let propValue: Int8 = propValue as? Int8 {
                    dict[propName!] = NSNumber(value: propValue as Int8)
                } else if let propValue: Int16 = propValue as? Int16 {
                    dict[propName!] = NSNumber(value: propValue as Int16)
                } else if let propValue: Int32 = propValue as? Int32 {
                    dict[propName!] = NSNumber(value: propValue as Int32)
                } else if let propValue: Int64 = propValue as? Int64 {
                    dict[propName!] = NSNumber(value: propValue as Int64)
                } else if let propValue: UInt8 = propValue as? UInt8 {
                    dict[propName!] = NSNumber(value: propValue as UInt8)
                } else if let propValue: UInt16 = propValue as? UInt16 {
                    dict[propName!] = NSNumber(value: propValue as UInt16)
                } else if let propValue: UInt32 = propValue as? UInt32 {
                    dict[propName!] = NSNumber(value: propValue as UInt32)
                } else if let propValue: UInt64 = propValue as? UInt64 {
                    dict[propName!] = NSNumber(value: propValue as UInt64)
                } else if ObjectUtils.isEnum(propValue) {
                    dict[propName!] = "\(propValue)" as AnyObject?
                }
            }
            
            mirror = mirror?.superclassMirror
            
        } while mirror != nil

        return dict
    }
    
    @discardableResult
    static func toClassMembers(_ value: DynamicObject, excludePrivate:Bool=true, stripDash:Bool = true) -> [String] {
        
        var members:[String] = []
        
        for (property, _) in value.properties {
            
            if continueIfPrivateVar(enabled: excludePrivate, value: property) { continue }
            
            let updatedProperty = sripDashIfRequired(enabled: stripDash, value: property)
            
            members.append(updatedProperty!)
            //print("Property Value: \(value)")
        }
        
        return members
    }

    @discardableResult
    static func toClassMembers(_ any: Any, excludePrivate:Bool=true, stripDash:Bool = true) -> [String] {
        
        var members:[String] = []
        
        switch any
        {
            
            case let dynObject as DynamicObject:
                members = toClassMembers(dynObject)
                break
                
            default:
                var mirror: Mirror? = Mirror(reflecting: unwrap(any)!)
                
                repeat {
                    for (propName, _) in (mirror?.children)! {
                        
                        //debugMirrorValue(enabled:false, mirror:mirror!, property:propName!)
                        
                        if continueIfPrivateVar(enabled: excludePrivate, value: propName!) { continue }
                        
                        let propName = sripDashIfRequired(enabled: stripDash, value: propName!)
                        
                        members.append(propName!)
                    }
                    
                    mirror = mirror?.superclassMirror
                    
                } while mirror != nil
                break
        }
        
        return members
    }

    static private func sripDashIfRequired( enabled:Bool, value:String )->String?{
        return (enabled) ? value.replacingOccurrences(of: "_", with: "", options: String.CompareOptions.literal, range: nil) : value
    }
    
    static private func continueIfPrivateVar( enabled:Bool, value:String )->Bool{
        if value.indexOf("_") != nil {
            
            //print("REMOVE: \(value)")
            return true
        }
        return false
    }
    
    static private func debugMirrorValue(enabled:Bool, mirror:Mirror, property:String){
        
        print("Mirror Property: \(property)")
        print("Mirror Subject: \(mirror.subjectType)")
        print("Mirror DispalyStyle: \(String(describing: mirror.displayStyle))")
        
    }
    
    static private func debugMirrorValue(enabled:Bool, mirror:Mirror, property:String, value:Any){
        
        debugMirrorValue(enabled: enabled, mirror: mirror, property: property)
        
        print("Mirror Value: \(String(describing: value))")
        
    }

 
    
    //
    //        for var attr in (mirror?.children)! {
    //
    //            //members.append(attr.label!)
    //            //print("Property value: \(String(describing: propValue))")
    //            print("Property name: \(attr.label!)")
    //            print("Property Subject: \(mirror?.subjectType)")
    //        }
    
    
    //        for (propName, _) in (mirror?.children)! {
    //
    //            members.append(propName!)
    //            //print("Property value: \(String(describing: propValue))")
    //            print("Property name: \(propName!)")
    //            print("Property Subject: \(mirror?.subjectType)")
    //        }
    //
    
    //        var nsojb:NSObject = NSObject()
    //
    //        nsojb.superclass
    
    //        let nextMirror = Mirror(reflecting: unwrap(any)!).superclassMirror
    //
    //
    //        if(nextMirror != nil && nextMirror?.subjectType != superMirror?.subjectType){
    //            members.append(contentsOf: toClassMembers(any, nextMirror))
    //        }
    

//    static func convertToObject<T>(_ any: Any, genericObject: T) -> T {
//        let mirroredObject = Mirror(reflecting: genericObject)
//        
//        for (_, var attr) in mirroredObject.children.enumerate() {
//            if let propertyName = attr.label as String! {
//                attr.value = json[propertyName]
//                print(propertyName)
//                print(attr.value)
//            }
//        }
//        // Figure out how to convert back to object type...
//    }
    // Runtime.swift
    
    
//    import Foundation
//    
//    public func setAssociatedObject(#object: NSObject, #key: NSString, #value: NSObject?) {
//        setAssociatedObject_glue(object, key, value)
//    }
//    
//    public func getAssociatedObject(#object: NSObject, #key: NSString) -> NSObject? {
//        return getAssociatedObject_glue(object, key)
//    }
}
