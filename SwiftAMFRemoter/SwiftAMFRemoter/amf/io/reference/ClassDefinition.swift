//
//  ClassDefinition.swift
//  SwiftAMFManager
//
//  Created by Tony Henderson on 1/2/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation


open class ClassDefinition
{
    
    fileprivate var _isDynamic:Bool=false
    fileprivate var _isExternalizable:Bool=false
    fileprivate var _isTyped:Bool
    fileprivate var _name:String
    fileprivate var _members:[String]
    
    init(name:String){
        
        _name = name
        _members = []
        _isTyped = false
        _isDynamic = false
        _isExternalizable = false
    }
    
    
    init(name:String, isTyped:Bool=false, members:[String], flags:Int? = nil){
        
        _name = name
        _members = members
        _isTyped = isTyped
        
        if(flags != nil){
            _isDynamic = ClassDefinition.isClassDynamic(flags!)
            _isExternalizable = ClassDefinition.isClassExternizable(flags!)
        }
        
    }
    
    init(name:String, isTyped:Bool=false, members:[String]=[], isDynamic:Bool=false, isExternalizable:Bool=false){
        
        _name = name
        _members = members
        _isDynamic = isDynamic
        _isTyped = isTyped
        _isExternalizable = isExternalizable
        
    }
    
    open var isDynamic:Bool{
        
        get { return _isDynamic }
    }
    
    open var name:String{
        
        get { return _name }
    }
    
    open var isTyped:Bool{
        
        get { return _isTyped }
    }
    
    open var isExternalizable:Bool{
        
        get { return _isExternalizable }
    }
    
    open var members:[String]{
        
        get { return _members }
    }
    
    open static func isClassExternizable(_ flags:Int)->Bool{
        
        return ((flags >> 1) & 1) != 0
    }
    
    open static func isClassDynamic(_ flags:Int)->Bool{
        
        return ((flags >> 2) & 1) != 0
    }
    
    open static func classMemberCount(_ flags:Int)->Int{
        
        return flags >> 3
    }
    
    open static func getFlags(_ clsDef:ClassDefinition)->Int{
        var flags = clsDef.members.count;
        flags = (flags << 1) | (clsDef.isDynamic ? 1 : 0);
        flags = (flags << 1) | (clsDef.isExternalizable ? 1 : 0);
        flags = (flags << 1) | 1;
        
        return flags
    }
}
