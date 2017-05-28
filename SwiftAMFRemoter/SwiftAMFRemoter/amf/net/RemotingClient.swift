//
//  RemotingClient.swift
//  WebApiPOC
//
//  Created by Tony Henderson on 6/14/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation


open class RemotingClient: EventDispatcher, INetConnection{
    
    fileprivate var _gatewayUrl:String = ""
    fileprivate var _netConnection:NetConnection
    fileprivate var _amfCoder:IAMFCoder;
    fileprivate var _requestCount:Int = 0;
    
    
    init(netConnection connection:NetConnection) {
        
        _netConnection = connection
        _amfCoder = (connection.objectEncoding == ObjectEncoding.amf3) ? AMF3Coder() : AMF0Coder()
        
        super.init()
    }
    
    open func connect(_ command: String, params arguments: [AnyObject]?) {
        
        _gatewayUrl = command
        
        //let commandMessage = CommandMessage.commandMessageFactory(destination: "fluorine", endpoint: _gatewayUrl)
        
        //call(commandMessage, callback: nil)
    }
    
    open func close(){
        
    }
    
    open var connected:Bool {
        get{
            return true
        }
        
    }
    
    public var coder:IAMFCoder {
        get{
            return _amfCoder
        }
    }
    
    

 
    //: For Flex RPC
    open func call( _ message:IMessage, serviceDefinition:IAMFServiceDefinition, callback:IPendingServiceCallback?)
    {
        if (_netConnection.objectEncoding == ObjectEncoding.amf0){
            
            print("AMF0 not supported for Flex RPC")
    
            //throw new NotSupportedException("AMF0 not supported for Flex RPC")

            return
        }
        
        if(_requestCount == 0){
            //message = CommandMessage.commandMessageFactory(destination: "fluorine", endpoint: _gatewayUrl)
            _requestCount = _requestCount+1
            
        }
        
        let responseString = "" ///\(String(_requestCount))"
        
        let amfMessage:AMFMessage = AMFMessage(version:  _netConnection.objectEncoding)
        amfMessage.serviceDefinition = serviceDefinition
        //amfMessage.remoteConfigurationKey = _netConnection.
        
        let amfMessageBody:AMFMessageBody = AMFMessageBody(target: "", response: responseString, content: message)
        amfMessage.addBody(amfMessageBody)
        
        coder.encodeMessage(message: amfMessage)
        
        // TODO: Fix
        //_registeredServiceConfigurations.updateItem(config)
        
        invokeCall(self._gatewayUrl, amfMessage: Data(coder.bytes)) { (success, message) -> () in
            if success {
  
                //dispatch(<#T##type: String##String#>, bubbles: <#T##Bool#>, data: <#T##Any?#>)
                
                SwiftAMFRemoterManager.sharedInstance.dispatch("test", bubbles: false, data: message)
                //self.dispatch("test", bubbles: false, data: amfMessage)
                
                print("logged in successfully!")
            } else {
                print("there was an error:", message!)
            }
        }
    }
    
    fileprivate func invokeCall(_ endpoint:String, amfMessage:Data, completion: @escaping (_ success: Bool, _ message: AMFMessage?) -> ()) {
        
        
        //let loginObject = ["email": email, "password": password]
        
        post(clientAMFRequest(endpoint, amfMessage: amfMessage)) { (success, object) -> () in
            
            DispatchQueue.main.async(execute: { () -> Void in
                if success {
                    completion(true, object as? AMFMessage)
                } else {
                    // TODO: More in-depth error logic
                    var errorMessage = "there was an error"
                    if let object = object, let passedMessage = object["message"] as? String {
                        errorMessage = passedMessage
                    }
                     
                    print(errorMessage)
                    completion(true, object as? AMFMessage)
                }
            })
        }
    }
    
    
    fileprivate func clientAMFRequest(_ endpoint:String, amfMessage:Data, params: Dictionary<String, AnyObject>? = nil) -> URLRequest {
        
        var request = URLRequest(url: URL(string: endpoint)!)
        
        // TODO: Will deal with parameters for later.
        if params != nil {
            //var paramString = ""
            //            for (key, value) in params {
            //                let escapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            //                let escapedValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            //                paramString += "\(escapedKey)=\(escapedValue)&"
            //            }
            
            
            // Eventually this will be AMF Message
            //request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        }
        else{
            request.setValue("application/x-amf", forHTTPHeaderField: "Content-Type")
            request.setValue("BigMavAMF", forHTTPHeaderField: "User-Agent")
            //request.setValue("", forHTTPHeaderField: "Accept-Encoding")
            //request.setValue("100-continue", forHTTPHeaderField: "Expect")
            request.httpBody = amfMessage
        }
        
        return request
    }
    
    
    // MARK: private composition methods
    
    fileprivate func post(_ request: URLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        dataTask(request as URLRequest, method: "POST", completion: completion)
    }
    
    fileprivate func put(_ request: URLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        dataTask(request as URLRequest, method: "PUT", completion: completion)
    }
    
    fileprivate func get(_ request: URLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        dataTask(request as URLRequest, method: "GET", completion: completion)
    }
    
    fileprivate func dataTask(_ request: URLRequest, method: String, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        var request = request
        request.httpMethod = method
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
         
        session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            
            if let data = data {
                
                // Need to update coder to have decode method that takes parameter
                //let json = try? JSONSerialization.jsonObject(with: data, options: [])
                
                self._amfCoder.position=0;
                
                let amfMessage:AMFMessage = try! self._amfCoder.decodeMessage(data.bytes)
                
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    completion(true, amfMessage)
                } else {
                    completion(false, amfMessage)
                }
//                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
//                    completion(true, json as AnyObject?)
//                } else {
//                    completion(false, json as AnyObject?)
//                }
            }
        }) .resume()
    }
    

}


//open class AmfRequestData
//{
//    internal var  _call:PendingCall
//    //readonly HttpWebRequest _request
//    fileprivate var _amfMessage:AMFMessage
//    fileprivate var _callback:IPendingServiceCallback
//    fileprivate var _responder:AnyObject
//    
//    init( amfMessage:AMFMessage,  call:PendingCall,  callback:IPendingServiceCallback,  responder:AnyObject?){
//        
//        //_request = request
//        _call = call
//        _responder = responder ?? "" as AnyObject
//        _amfMessage = amfMessage
//        _callback =  callback
//        
//    }
//    
//    internal var call:PendingCall
//        {
//        get { return _call }
//    }
//    
//    //        public HttpWebRequest Request
//    //        {
//    //        get { return _request }
//    //        }
//    
//    open var AmfMessage:AMFMessage
//        {
//        get { return _amfMessage }
//    }
//    
//    open var callback:IPendingServiceCallback
//        {
//        get { return _callback }
//    }
//    
//    open var responder:AnyObject
//        {
//        get { return _responder }
//    }
//    
//    
//}

