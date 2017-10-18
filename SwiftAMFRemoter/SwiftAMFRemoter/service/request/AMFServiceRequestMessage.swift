//
//  AMFServiceRequestMessage.swift
//  SwiftAMFRemoter
//
//  Created by Tony Henderson on 10/17/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation


import Foundation

open class AMFServiceRequestMessage {

    init(message:IMessage, serviceDefinition:IAMFServiceDefinition ){
         
        self._serviceDefinition=serviceDefinition
        self._message =  message
        
    }
    
    private var _serviceDefinition:IAMFServiceDefinition
    
    private var _message:IMessage
    
    open var serviceDefinition: IAMFServiceDefinition{
        get{return self._serviceDefinition}
    }
    
    open var message: IMessage{
        get{return self._message}
    }
    
   
}
