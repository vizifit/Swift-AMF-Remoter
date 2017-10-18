//
//  AMFServiceRequest.swift
//  SwiftAMF
//
//  Created by Tony Henderson on 5/1/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation

open class  AMFServiceRequest:IServiceRequest{
     
    init(serviceConfigKey:String, serviceDefinition:IAMFServiceDefinition, args: Any...){
        
        
        // Return args as an array
        self._serviceConfigKey = serviceConfigKey
        self._serviceDefinition=serviceDefinition
        self._args = args
        
        self._customWaitMessage = nil;
        self._key=UUID().uuidString
        self._isUpdateable = false
        
    }
    
    fileprivate var _args:[Any]?
    
    fileprivate var _customWaitMessage:String?
    
    fileprivate var _key:String
    
    fileprivate var _serviceDefinition:IAMFServiceDefinition
    
    fileprivate var _isUpdateable:Bool

    fileprivate var _serviceConfigKey:String
    
    
    open var serviceConfigKey: String{
        get{return self._serviceConfigKey}
    }
    
    open var requestId: String{
        get{return self._key}
    }
    
    open var customWaitMessage: String?{
        get{return self._customWaitMessage}
    }
    
    open var key: String{
        get{return self._key}
 
    }
    
    open var serviceDefinition: IAMFServiceDefinition{
        get{return self._serviceDefinition} 
    }
    
    open var args: [Any]?{
        get{return self._args}

    }
    
    open var isUpdateable:Bool {
        get{return self._isUpdateable}
    }

}
