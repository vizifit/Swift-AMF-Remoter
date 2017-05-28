//
//  Call.swift
//  SwiftAMFManager
//
//  Created by Tony Henderson on 1/2/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation

open class Call:IServiceCall{
    
    //internal static readonly object[] EmptyArguments
    
    // TODO
    //internal static var emptyArguments:[AnyObject]
    
    /// <summary>
    /// Pending status constant.
    /// </summary>
    open let STATUS_PENDING:UInt8 = 0x01
    /// <summary>
    /// Success result constant.
    /// </summary>
    open let STATUS_SUCCESS_RESULT:UInt8 = 0x02
    /// <summary>
    /// Returned value is null constant.
    /// </summary>
    open let STATUS_SUCCESS_NULL:UInt8 = 0x03
    /// <summary>
    /// Service returns no value constant.
    /// </summary>
    open let STATUS_SUCCESS_VOID:UInt8 = 0x04
    /// <summary>
    /// Service not found constant.
    /// </summary>
    open let STATUS_SERVICE_NOT_FOUND:UInt8 = 0x10
    /// <summary>
    /// Service's method not found constant.
    /// </summary>
    open let STATUS_METHOD_NOT_FOUND:UInt8 = 0x11
    /// <summary>
    /// Access denied constant.
    /// </summary>
    open let STATUS_ACCESS_DENIED:UInt8 = 0x12
    /// <summary>
    /// Exception on invocation constant.
    /// </summary>
    open let STATUS_INVOCATION_EXCEPTION:UInt8 = 0x13
    /// <summary>
    /// General exception constant.
    /// </summary>
    open let STATUS_GENERAL_EXCEPTION:UInt8 = 0x14
    /// <summary>
    /// The application for this service is currently shutting down.
    /// </summary>
    open let STATUS_APP_SHUTTING_DOWN:UInt8 = 0x15
    
    fileprivate var _serviceName:String
    fileprivate var _serviceMethodName:String
    fileprivate var _arguments:[Any]?
    fileprivate var _status:UInt8
    
    
    init() {
        
        self._serviceName = ""
        self._serviceMethodName = ""
        self._arguments=[]
        self._status=0
    }
    
    convenience init(method:String){
        
        self.init()
        
        self._serviceMethodName = method
    }
    
    convenience init(method:String, args:[Any]?){
        
        self.init()
        
        self._serviceMethodName = method
        self._arguments = args
    }
    
    convenience init(name:String, method:String, args:[Any]?){
        
        self.init()
        
        self._serviceName = name
        self._serviceMethodName = method
        self._arguments = args
    }
    
    
    
    open var isSuccess: Bool{
        get{
            return (_status == STATUS_SUCCESS_RESULT)
                || (_status == STATUS_SUCCESS_NULL)
                || (_status == STATUS_SUCCESS_VOID)
            
            
        }
    }
    
    open var serviceName:String{
        get{ return self._serviceName }
    }
    
    open var serviceMethodName:String{
        get{ return self._serviceMethodName }
    }
    
    open var arguments:[Any]?{
        get{ return self._arguments }
    }
    
    open var status:UInt8{
        get{ return self._status }
        set{ self._status = newValue }
    }
    
    // TODO: Create a similar exception class to .net
    //    public var exception:Exception{
    //        get{ return self._exception }
    //        set{ self._exception = newValue }
    //    }
    
}
