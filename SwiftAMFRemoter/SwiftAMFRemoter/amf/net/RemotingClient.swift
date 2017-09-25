//
//  RemotingClient.swift
//  WebApiPOC
//
//  Created by Tony Henderson on 6/14/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation



open class RemotingClient: INetConnection {
    
    
    fileprivate var _gatewayUrl:String = ""
    fileprivate var _netConnection:NetConnection
    fileprivate var _encoder:IAMFCoder
    fileprivate var _decoder:IAMFCoder
    fileprivate var _requestCount:Int = 0
    fileprivate var _index:Int = 0
    fileprivate var _isPendingCallResponse:Bool = false
    fileprivate var _key:String = String()
    fileprivate var _pendingMessages:[Int:PendingMessageResult]

    
    
    
    init(netConnection connection:NetConnection, key: String) {
        
        _netConnection = connection
        _key = key
        
        // Require copy of both encoder and decoder for concurrency.
        _encoder = (connection.objectEncoding == ObjectEncoding.amf3) ? AMF3Coder() : AMF0Coder()
        _decoder = (connection.objectEncoding == ObjectEncoding.amf3) ? AMF3Coder() : AMF0Coder()
        _pendingMessages = [:]
        
    }
    
    //TODO: Add this functionality later.
    open func connect(_ command: String, params arguments: [AnyObject]?) {
        
        _gatewayUrl = command
        
        //let commandMessage = CommandMessage.commandMessageFactory(destination: "fluorine", endpoint: _gatewayUrl)
        //call(commandMessage, callback: nil)
    }
    
    //TODO: Add this functionality later
    open func close(){}
    
    open var key: String {
        get{ return _key }
    }
    
    open var connected:Bool {
        get{ return true }
    }
    
    public var encoder:IAMFCoder {
        get{ return _encoder }
    }
    
    public var decoder:IAMFCoder {
        get{ return _decoder }
    }
    
    public var isPendingCallResponse:Bool{
        get { return _isPendingCallResponse}
    }
    
    private func addPendingMessageResult( _ message:IMessage, serviceDefinition:IAMFServiceDefinition){
        
        _pendingMessages[_pendingMessages.count] = PendingMessageResult(message, serviceDefinition: serviceDefinition)
        
    }
    
    private func removePendingMessageResult(messageId:String?) -> PendingMessageResult?{
        
        if(messageId == nil){
            return nil
        }
        
        print("Remove Pending message for MessageID:" + messageId!)
        
        for (index, pendingMessage) in _pendingMessages {
            
            if messageId! == pendingMessage.messageId {
                
                print("Message found at index:" + String(index))
                let foundMessage = _pendingMessages.removeValue(forKey: index)
                return foundMessage
            }
        }
        
        print("Message remove FAILED")

        
        return nil
        
//        let result = PendingMessageResult.getPendingMessageResult(messageId, pendingMessages: _pendingMessages)
//        print("MessageID:" + messageId)
//        
//        if(result == nil){
//            print("Message Not FOUND")
//            return nil
//        }
//        
//        print("Message found at index:" + String((result?.index)!))
//        
//        // Remove pending message
//        _pendingMessages.removeValue(forKey: (result?.index)!)
//        
//        return result?.pendingMessage
    }
    
    private func encodeAndSendMessage(requestMessage:AMFMessage){
        
        
        self.encoder.encodeMessage(message: requestMessage)
        
                // TODO: Fix
        //_registeredServiceConfigurations.updateItem(config)
        
        invokeCall(self._gatewayUrl, requestMessage: Data(encoder.bytes)) { (success, resultMessage) -> () in
            
            if success {
                
                if(resultMessage == nil){
                    //TODO: Print error here
                    return
                }
                
                var messageCorrelationId:String? = nil
                
                do{
                    messageCorrelationId = try resultMessage!.getMessageId()
                }catch let e {
                    print(e.localizedDescription)
                }
                
                let result = self.removePendingMessageResult(messageId: messageCorrelationId)
                
                // Update result message with service definition
                resultMessage!.serviceDefinition = (result?.serviceDefinition)!
                
                NotificationCenter.default.post(name: Notification.Name(self.key), object: nil, userInfo: ["result": resultMessage!, "serviceKey": self.key])
 
                //self.dispatch(self.key, bubbles: false, data: resultMessage)
                
                //SwiftAMFRemoterManager.sharedInstance.dispatch("test", bubbles: false, data: message)
                //self.dispatch("test", bubbles: false, data: resultMessage)
                
                //print("logged in successfully!")
            } else {
                
                // Do logic to handle errors here
                print("there was an error:", resultMessage!)
            }
        }

    }
    
    private func isWaiting() -> Bool{
        
        if(self.isPendingCallResponse==true){
            
            // Add to Batch
            return true
        }
        
        return false
    }

 
    //: For Flex RPC
    open func call( _ message:IMessage, serviceDefinition:IAMFServiceDefinition, callback:IPendingServiceCallback?)
    {
        if (_netConnection.objectEncoding == ObjectEncoding.amf0){
            
            print("AMF0 not supported for Flex RPC")
    
            //throw new NotSupportedException("AMF0 not supported for Flex RPC")

            return
        }
        
        // Add pending message for future retrieval
        addPendingMessageResult(message, serviceDefinition: serviceDefinition)

        let responseString = (_requestCount == 0) ? "0" : String(_requestCount+1)
        
        _requestCount = _requestCount+1
        
//        if(_requestCount == 0){
//            //message = CommandMessage.commandMessageFactory(destination: "fluorine", endpoint: _gatewayUrl)
//            _requestCount = _requestCount+1
//        }
//        else{
//            _requestCount = _requestCount+1
//        }
//        
//        let responseString = String(_requestCount)
        
        let amfMessage:AMFMessage = AMFMessage(version:  _netConnection.objectEncoding)
        amfMessage.serviceDefinition = serviceDefinition
        //amfMessage.remoteConfigurationKey = _netConnection.
        
        let amfMessageBody:AMFMessageBody = AMFMessageBody(target: "", response: responseString, content: message)
        amfMessage.addBody(amfMessageBody)
        
        
        encodeAndSendMessage(requestMessage: amfMessage)

    }
    
    fileprivate func invokeCall(_ endpoint:String, requestMessage:Data, completion: @escaping (_ success: Bool, _ resultMessage: AMFMessage?) -> ()) {
        
        //let loginObject = ["email": email, "password": password]
        
        post(clientAMFRequest(endpoint, requestAMFMessage: requestMessage)) { (success, result) -> () in
            
            // Thread on main queue
            DispatchQueue.main.async(execute: { () -> Void in
                
                if success {
                    completion(true, result as? AMFMessage)
                
                } else {
                    
                    // TODO: More in-depth error logic
                    var errorMessage = "there was an error"
                    if let result = result, let passedMessage = result["message"] as? String {
                        errorMessage = passedMessage
                    }
                     
                    print(errorMessage)
                    completion(true, result as? AMFMessage)
                }
            })
        }
    }
    
    
    // TODO: Will need to add custom headers eventually
    fileprivate func clientAMFRequest(_ endpoint:String, requestAMFMessage:Data, params: Dictionary<String, AnyObject>? = nil) -> URLRequest {
        
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
            request.httpBody = requestAMFMessage
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
                
                let bytes:[UInt8]? = data.bytes
                
                //self._index = self._index + 1
                //print("completed_" + String(self._index) + " - SIZE - " + String(data.bytes.count))
                //return
                    
                // Need to update coder to have decode method that takes parameter
                //let json = try? JSONSerialization.jsonObject(with: data, options: [])
                
                self.decoder.resetPosition()
                
                if(bytes != nil || data.bytes.count > 0){
                    let amfMessage:AMFMessage = try! self.decoder.decodeMessage(data.bytes)
                    
                    if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                        completion(true, amfMessage)
                    } else {
                        completion(false, amfMessage)
                    }
                    
                    return
                }
                
                // Error happened but still need to return
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    completion(true, nil)
                } else {
                    completion(false, nil)
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

