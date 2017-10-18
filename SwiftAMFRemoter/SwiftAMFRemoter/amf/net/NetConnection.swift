//
//  NetConnection.swift
//  SwiftAMFManager
//
//  Created by Tony Henderson on 1/2/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation



public final class NetConnection :NSObject{
    
    fileprivate var _clientId:String?
    fileprivate var _uri:URL?
    fileprivate var _arguments:[NSObject]
    fileprivate var _playerVersion:String?
    fileprivate var _swfUrl:String?
    fileprivate var _pageUrl:String?
    fileprivate var _client:NSObject?
    fileprivate var _objectEncoding:ObjectEncoding
    fileprivate var _headers:[AMFMessageHeader]
    fileprivate var _netConnectionClient:INetConnection?
    
    
    convenience override init() {
        self.init()
    }
    
    
    init(objectEncoding:ObjectEncoding) {
        
        self._clientId = nil
        self._uri = nil
        self._arguments = []
        self._playerVersion = "WIN 9,0,115,0"
        self._swfUrl = nil
        self._pageUrl = nil
        self._client = nil
        self._objectEncoding = objectEncoding
        self._headers = []
        self._netConnectionClient = nil
        
        super.init()
        
        
        //TODO: Learn how to create events similar to .net
        
    }
    
    
    public var uri:URL? {
        
        get{return self._uri}
        set{ self._uri = newValue}
        
    }
    
    public var clientId:String? {
        
        get{return self._clientId}
    }
    
    public var playerVersion:String? {
        
        get{return self._playerVersion}
        set{ self._playerVersion = newValue}
        
    }
    
    public var swfUrl:String? {
        
        get{return self._swfUrl}
        set{ self._swfUrl = newValue}
        
    }
    
    public var objectEncoding:ObjectEncoding {
        
        get{return self._objectEncoding}
        set{ self._objectEncoding = newValue}
        
    }
    
    public var client:NSObject? {
        
        get{return self._client}
        set{
            // NOTE: ValidationUtils.ArgumentNotNull(value, "Client");
            self._client = newValue
        }
        
    }
    
    
    internal func setClientId(_ clientId:String){
        
        _clientId = clientId
    }
    
    public var headers:[AMFMessageHeader]? {
        
        get{return self._headers}
        
    }
    
    internal var netConnectionClient:INetConnection?{
        
        get{return _netConnectionClient}
    }
    
    public var connected:Bool{
        
        get{
            if(_netConnectionClient != nil){
                return (_netConnectionClient?.connected)!
            }
            
            return false;
        }
    }
    
    
    
    public func connect(_ command:String, params arguments:[NSObject]  ){
        
        _uri = URL(string: command)
        _arguments = arguments
        connect();
    }
    
    fileprivate func connect(){
        
        if(_uri?.scheme == "http" || _uri?.scheme == "https")
        {
            //_netConnectionClient =  RemotingClient(netConnection: self, key: String);
            _netConnectionClient?.connect((_uri?.absoluteString)!, params: _arguments)
            
        }
        // NOTE: RTMP implementation
        //        if (_uri?.scheme == "rtmp")
        //        {
        //            _netConnectionClient = new RtmpClient(this);
        //            _netConnectionClient.Connect(_uri.ToString(), _arguments);
        //            return;
        //        }
        
        // NOTE: Throw exc.
        
    }
  
    
    open func call( request:IMessage, serviceDefinition:IAMFServiceDefinition){
        
        _netConnectionClient!.call(request: request, serviceDefinition: serviceDefinition)
    }
    
    open func call( requestGroup:AMFServiceRequestGroup, requestMessages:[AMFServiceRequestMessage]){
        
        _netConnectionClient!.call(requestGroup: requestGroup, requestMessages: requestMessages)
    }
    
    
    
}
