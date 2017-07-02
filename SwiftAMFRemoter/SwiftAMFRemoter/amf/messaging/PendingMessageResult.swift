//
//  PendingMessage.swift
//  SwiftAMFRemoter
//
//  Created by Tony Henderson on 7/2/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation

open class PendingMessageResult{
    
    
    fileprivate var _messageId:String
    
    fileprivate var _message:IMessage
    
    fileprivate var _serviceDefinition:IAMFServiceDefinition
    
    public init(_ message:IMessage, serviceDefinition:IAMFServiceDefinition){
        
        _message = message
        _messageId = message.messageId
        _serviceDefinition = serviceDefinition
    }
    
    open var  message:IMessage{
        
        get { return _message }
        set { _message = newValue }
    }
    
    open var  messageId:String{
        
        get { return _messageId }
        set { _messageId = newValue }
    }
    
    open var  serviceDefinition:IAMFServiceDefinition{
        
        get { return _serviceDefinition }
        set { _serviceDefinition = newValue }
    }
    
    
}




