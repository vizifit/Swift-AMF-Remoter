//
//  InvocationException.swift
//  SwiftAMFManager
//
//  Created by Tony Henderson on 1/3/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation


open class InvocationException{
    
    
    fileprivate var _faultCode:String
    fileprivate var _faultString:String
    fileprivate var _faultDetail:String
    fileprivate var _rootCause:AnyObject
    fileprivate var _sourceException:AnyObject?
    
    init(message:ErrorMessage){
        
        _faultCode = message.faultCode
        _faultString = message.faultString
        _faultDetail = message.faultDetail
        _rootCause = message.rootCause
        _sourceException = nil
    }
    
    open var faultCode:String{
        
        get{return self._faultCode}
    }
    
    open var faultString:String{
        
        get{return self._faultString}
    }
    
    open var faultDetail:String{
        
        get{return self._faultDetail}
    }
    
    open var rootCause:AnyObject{
        
        get{return self._rootCause}
    }
}
