//
//  BaseRemoteServiceDefinition.swift
//  SwiftAMF
//
//  Created by Tony Henderson on 5/1/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation

open class BaseRemoteServiceDefinition: IAMFServiceDefinition{
    
    init(_ value:String,
         _ methodName:String,
         _ source:String?=nil,
         _ modalWaitMessage:String="Loading...",
         _ modalWait:Bool=true,
         _ destination:String?=nil,
         _ endpoint:String?=nil,
         _ resultNotificationId:String?=nil,
         _ faultNotificationId:String?=nil,
         _ alwaysSendNotification:Bool=true){
        
        
        self._value = value
        self._methodName = methodName
        self._modalWaitMessage=modalWaitMessage
        self._modalWait = modalWait
        self._resultNotificationId=resultNotificationId
        self._faultNotificationId=faultNotificationId
        self._destination=destination
        self._source=source
        self._endpoint=endpoint
        self._alwaysSendNotification=alwaysSendNotification
        
        
    }
    
 
    fileprivate var _value: String;
    
    fileprivate var _methodName: String
    
    fileprivate var _destination: String?
    
    fileprivate var _endpoint: String?
    
    fileprivate var _source: String?
    
    fileprivate var _modalWait: Bool
    
    fileprivate var _modalWaitMessage: String?
    
    fileprivate var _alwaysSendNotification: Bool
    
    fileprivate var _resultNotificationId: String?
    
    fileprivate var _faultNotificationId: String?
    
    
    
    public var value: String{
        
        get{return self._value}

    }
    
    public var methodName: String{
        get{return self._methodName}

    }
    
    public var destination: String?{
        get{return self._destination}

    }
    
    public var endpoint: String?{
        get{return self._endpoint}

    }
    
    public var source: String?{
        get{return self._source}

    }
    
    public var modalWait: Bool{
        get{return self._modalWait}

    }
    
    public var modalWaitMessage: String?{
        get{return self._modalWaitMessage}

    }
    
    public var alwaysSendNotification: Bool{
        get{return self._alwaysSendNotification}

    }
    
    public var resultNotificationId: String?{
        get{return self._resultNotificationId}

    }
    
    public var faultNotificationId: String?{
        get{return self._faultNotificationId}

    }
    
    
}
