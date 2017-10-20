//
//  AMFServiceRequestGroup.swift
//  SwiftAMF
//
//  Created by Tony Henderson on 5/1/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation


open class  AMFServiceRequestGroup{
    
    fileprivate var _amfServiceRequests:[AMFServiceRequest]?
    
    fileprivate var _notificationId:String?
    
    fileprivate var _modalWait:Bool
    
    fileprivate var _modalWaitMessage:String?
    
    fileprivate var _groupKey:String?
    
    public init( amfServiceRequests:[AMFServiceRequest],
          notificationId:String )
    {
        
        self._notificationId = notificationId;
        self._modalWait = false;
        self._modalWaitMessage = nil;
        self._amfServiceRequests = amfServiceRequests;
        
        // Generate a group key if not provided.
        self._groupKey =  AMFServiceRequestGroup.generateGroupKey(requestGroup: self)!
        
    }
    
    public init( amfServiceRequests:[AMFServiceRequest],
          notificationId:String,
          modalWait:Bool,
          modalWaitMessage:String)
    {
        
        self._notificationId = notificationId;
        self._modalWait = modalWait;
        self._modalWaitMessage = modalWaitMessage;
        self._amfServiceRequests = amfServiceRequests;
        
        // Generate a group key if not provided.
        self._groupKey =  AMFServiceRequestGroup.generateGroupKey(requestGroup: self)!
        
    }
    
    open var amfServiceRequests:[AMFServiceRequest]? {
        
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
    
    open var notificationId:String? {
        
        get{return self._notificationId}
        
    }

   
    open static func generateGroupKey(requestGroup:AMFServiceRequestGroup)->String?{
    
        var generatedKey:String = "SVC_GROUP_REQ_"
        generatedKey += UUID().uuidString

        for request in requestGroup.amfServiceRequests!{
             
            generatedKey += "-" + request.serviceDefinition.value
        }
 
        return generatedKey
  
    }
    
}
