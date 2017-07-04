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
    private var _errorMessage:ErrorMessage? = nil
    private var _resultMessage:IResultMessage? = nil
    private var _notificationKey:String
    
    public init(_ message:AMFMessage, serviceKey:String) throws {
        
        _serviceKey = serviceKey
        
        let serviceResult = try message.getResult()
        
        _result = serviceResult.1
        
        if(serviceResult.0 == AMFMessage.ResultType.serverError || serviceResult.0 == AMFMessage.ResultType.unknownError){
            _isError = true
            _errorMessage = _result as? ErrorMessage
            
            // Fault notification if error
            _notificationKey = (message.serviceDefinition?.faultNotificationId)!
            return
        }
        
        // Result notification if success
        _resultMessage = _result as? IResultMessage
        _notificationKey = (message.serviceDefinition?.resultNotificationId)!
    }
    
    
    open var serviceKey:String { get {return self.serviceKey} }
    
    open var notificationId:String { get {return self._notificationKey} }
    
    open var isError:Bool { get {return self._isError} }
    
    open var result:Any? { get {return self._result} }
    
    open var errorMessage:ErrorMessage? { get {return self._errorMessage} }
    
    open var resultMessage:IResultMessage? { get {return self._resultMessage} }

    
    
}
