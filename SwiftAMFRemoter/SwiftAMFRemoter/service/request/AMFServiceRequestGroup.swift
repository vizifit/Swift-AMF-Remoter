//
//  AMFServiceRequestGroup.swift
//  SwiftAMF
//
//  Created by Tony Henderson on 5/1/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation


open class  AMFServiceRequestGroup{
    
    
    init( amfServiceRequests:[String:AMFServiceRequest]?,
        resultNotificationId:String?,
        faultNotificationId:String?,
        customGroupKey:String?=nil,
        modalWait:Bool=true,
        modalWaitMessage:String?="Loading...")
    {
        
        self._resultNotificationId = resultNotificationId;
        self._faultNotificationId = faultNotificationId;
        self._modalWait = modalWait;
        self._modalWaitMessage = modalWaitMessage;
        self._amfServiceRequests = amfServiceRequests;
        
        // Generate a group key if not provided.
        self._groupKey = customGroupKey != nil ? customGroupKey! : generateGroupKey()!
        
 
    }
    
    fileprivate var _amfServiceRequests:[String:AMFServiceRequest]?
    
    fileprivate var _resultNotificationId:String?
    
    fileprivate var _faultNotificationId:String?
    
    fileprivate var _modalWait:Bool
    
    fileprivate var _modalWaitMessage:String?
    
    fileprivate var _groupKey:String?

    
    
    open var amfServiceRequests:[String:AMFServiceRequest]? {
        
        get{return self._amfServiceRequests}
        
    }
    
    open var groupKey:String? {
        
        get{return self._groupKey}
        
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

   
    func generateGroupKey()->String?{
    
        var generatedKey:String = "SVC_GROUP_REQ_"
        generatedKey += UUID().uuidString

        for (key, _) in self.amfServiceRequests!{
            
            generatedKey += "-" + key
        }
 
        return generatedKey
  
    }
    
}