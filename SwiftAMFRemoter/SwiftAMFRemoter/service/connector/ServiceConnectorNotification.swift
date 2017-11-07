//
//  ServiceConnectorNotification.swift
//  SwiftAMFRemoter
//
//  Created by Tony Henderson on 6/29/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation

open class ServiceConnectorNotification: IServiceConnectorNotification{
    
    
 
    private var _serviceKey:String
    private var _result:Any?
    private var _isError:Bool = false
    private var _hasGroupedResultErrors:Bool = false
    private var _groupedResultErrorCount:Int = 0
    private var _errorMessage:ErrorMessage?
    private var _resultMessageGroup:[String:Any?]?
    private var _isGroupedResult:Bool = false
    private var _notificationKey:String
    private var _resultMessage: IResultMessage?
    
    public init(_ messageGroup:[AMFMessage], resultMessageGroupKey:String, serviceKey:String) throws {
        
        _serviceKey = serviceKey
        _isGroupedResult = true
        _resultMessageGroup = [:]
        
        // Loop for Group
        for message in messageGroup{
            
            let serviceResult = try message.getResult()
            //let messageResult:IResultMessage = (serviceResult.1 as? IResultMessage)!
            
            // Result with Error
            if(serviceResult.0 == AMFMessage.ResultType.serverError || serviceResult.0 == AMFMessage.ResultType.unknownError){
                _hasGroupedResultErrors = true
                _groupedResultErrorCount += 1 // Increment
            }
            
            var key:String = (message.serviceDefinition?.value)!
            let keyIndex = _resultMessageGroup!.index(forKey: key)
            
            // Create unique keys for same service definitions
            if(keyIndex != nil){
                key += "_" + serviceResult.2!
            }
            
            _resultMessageGroup![key] = serviceResult.1
        }
        
        _notificationKey = resultMessageGroupKey
    }
        
    public init(_ message:AMFMessage, serviceKey:String) throws {
        
        let serviceResult = try message.getResult()
        
        _serviceKey = serviceKey
        _result = serviceResult.1
        
        if(serviceResult.0 == AMFMessage.ResultType.serverError || serviceResult.0 == AMFMessage.ResultType.unknownError){
            _isError = true
            _errorMessage = _result as? ErrorMessage
            
            // Fault notification if error
            _notificationKey = (message.serviceDefinition?.faultNotificationId)!
            return
        }
        
        // Result notification if success
        _notificationKey = (message.serviceDefinition?.resultNotificationId)!
    }
    
   
    open var errorMessage:ErrorMessage? { get {return self._errorMessage} }
    
    open var isError:Bool { get {return self._isError} }
    
    open var isGroupedResult:Bool { get {return self._isGroupedResult} }
    
    open var hasGroupedResultErrors:Bool { get {return self._hasGroupedResultErrors} }
    
    open var groupedResultErrorCount:Int { get {return self._groupedResultErrorCount} }
    
    open var notificationId:String { get {return self._notificationKey} }
    
    open var result:Any? { get {return self._result} }
    
    open var resultMessage:IResultMessage? { get {return self._resultMessage} }
    
    open var resultMessageGroup:[String:Any?]? { get {return self._resultMessageGroup} }
    
    open var serviceKey:String { get {return self.serviceKey} }
    
}
