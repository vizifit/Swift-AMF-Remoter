//
//  RemoteServiceConfiguration.swift
//  SwiftAMF
//
//  Created by Tony Henderson on 5/1/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation


open class  RemoteServiceConfiguration:IDictionaryItem{
    
    public init(key:String,
         destination:String?=nil,
         endpoint:String?=nil,
         securityPolicyUrl:String?=nil,
         source:String?=nil,
         timeout:Int=3000,
         encoding:ObjectEncoding=ObjectEncoding.amf3,
         modalWait:Bool=true,
         isUpdateable:Bool=true){
    
        self._key = key
        self._destination = destination
        self._endpoint=endpoint
        self._securityPolicyUrl=securityPolicyUrl
        self._source=source
        self._timeout=timeout
        self._modalWait = modalWait
        self._isUpdateable = isUpdateable
        self._encoding = encoding
        
        //(netConnection: NetConnection(objectEncoding: encoding), key: self._key)
        self._connection = RemotingClient(netConnection: NetConnection(objectEncoding: encoding), key: key)
        
        self._connection.connect(endpoint!, params: nil)
    }
    
    fileprivate var _timeout:Int
    fileprivate var _modalWait:Bool
    fileprivate var _endpoint:String?
    fileprivate var _securityPolicyUrl:String?
    fileprivate var _source:String?
    fileprivate var _destination:String?
    fileprivate var _key:String
    fileprivate var _isUpdateable:Bool
    fileprivate var _remotingMessage:RemotingMessage? = nil
    fileprivate var _encoding:ObjectEncoding
    fileprivate var _connection:INetConnection
    
    open var connection:INetConnection {
        
        get{return self._connection}
    }

    
    open var timeout:Int {
        
        get{return self._timeout}
        
    }
    
    open var endpoint:String? {
        
        get{return self._endpoint}
        
    }

    open var encoding:ObjectEncoding? {
        
        get{return self._encoding}
        
    }

    
    open var securityPolicyUrl:String? {
        
        get{return self._securityPolicyUrl}
        
    }
    
    open var source:String? {
        
        get{return self._source}
    }
 
    
    open var destination:String? {
        
     get{return self._destination}
    }

    open var isUpdateable:Bool {
        
        get{return self._isUpdateable}
        
    }
    
    open var modalWait:Bool {
        
        get{return self._modalWait}
    }
 
    open var key:String {
        
        get{return self._key}
        
    }
    
    open var remoteMessage:RemotingMessage? {
        
         get{return self._remotingMessage}
         set{ self._remotingMessage = newValue}
        
    }
    
    
}
