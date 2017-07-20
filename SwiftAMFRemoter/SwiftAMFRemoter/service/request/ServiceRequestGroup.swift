//
//  ServiceRequestGroup.swift
//  SwiftAMF
//
//  Created by Tony Henderson on 5/1/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation


open class  ServiceRequestGroup{
    
    
    
    init(serviceConfigKey:String,
         groupKey:String,
         serviceRequestItems:DictionaryBuilder,
         resultNotificationId:String,
         faultNotificationId:String,
         modalWait:Bool=true,
         modalWaitMessage:String="Loading..."){
        
        
        let compositeKey:String = groupKey + "_" + UUID().uuidString
        
        self._serviceConfigKey=serviceConfigKey;
        self._key = compositeKey
        self._serviceRequestItems = serviceRequestItems;
        self._resultNotificationId = resultNotificationId;
        self._faultNotificationId = faultNotificationId;
       
        self._modalWait = modalWait;
        self._modalWaitMessage = modalWaitMessage;
        self._requestStart=CACurrentMediaTime()
        
        self._groupResult = nil
    }

    fileprivate var _key:String
    
    fileprivate var _resultNotificationId:String?
    
    fileprivate var _faultNotificationId:String?
    
    fileprivate var _serviceRequestItems:DictionaryBuilder
    
    fileprivate var _serviceConfigKey:String
    
    fileprivate var _requestEnd:Double?
    
    fileprivate var _requestStart:Double?
    
    fileprivate var _modalWait:Bool
    
    fileprivate var _modalWaitMessage:String?
    
    fileprivate var _groupResult:ServiceRequestGroupResult?
    
    
    
    open var key:String {
        
        get{return self._key}
        
    }
    
    open var modalWait:Bool {
        
        get{return self._modalWait}
        
    }
    
    open var modalWaitMessage:String? {
        
        get{return self._modalWaitMessage}
        
    }
    
    open var resultNotificationId:String? {
        
        get{return self._resultNotificationId}
        
    }
    
    open var faultNotificationId:String? {
        
        get{return self._faultNotificationId}
        
    }
    
    open var serviceRequestItems:DictionaryBuilder {
        
        get{return self._serviceRequestItems}
        
    }
    open var requestEnd:Double? {
        
        get{return self._requestEnd}
        
    }
    
    open var requestStart:Double? {
        
        get{return self._requestStart}
        
    }
    
    open var groupResult:ServiceRequestGroupResult? {
        
        get{
            
            if(_groupResult == nil){
                _groupResult = ServiceRequestGroupResult()
            }
            
            return self._groupResult
        
        }
        
    }
    
}
