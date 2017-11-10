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
    fileprivate var _isPendingMessageResponse:Bool = false
    fileprivate var _isPendingGroupedMessageResponse:Bool = false
    
    fileprivate var _key:String = String()
    fileprivate var _pendingMessageCount:Int = 0
    fileprivate var _pendingMessages:[String:PendingMessageResult]
    fileprivate var _pendingMessagesRaw:[[UInt8]]
    fileprivate var _pendingGroupRequest:AMFServiceRequestGroup?

    
    
    
    init(netConnection connection:NetConnection, key: String) {
        
        _netConnection = connection
        _key = key
        
        // Require copy of both encoder and decoder for concurrency.
        _encoder = (connection.objectEncoding == ObjectEncoding.amf3) ? AMF3Coder() : AMF0Coder()
        _decoder = (connection.objectEncoding == ObjectEncoding.amf3) ? AMF3Coder() : AMF0Coder()
        _pendingMessages = [:]
        _pendingMessagesRaw = []
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
    
    public var isPendingMessageResponse:Bool{
        get { return _isPendingMessageResponse}
    }
    
    private func addPendingMessageResult( _ message:IMessage, serviceDefinition:IAMFServiceDefinition){
        
         print("ADD Pending message for MessageID:" + message.messageId)
        
        _pendingMessages[message.messageId] = PendingMessageResult(message, serviceDefinition: serviceDefinition)
        
    }
    
    private func removePendingMessageResult(messageId:String?) -> PendingMessageResult?{
        
        if(messageId == nil){
            return nil
        }
        
        print("REMOVE Pending message for MessageID:" + messageId!)
        
        let foundMessage = _pendingMessages.removeValue(forKey: messageId!)
        
        if((foundMessage) != nil){
            return foundMessage
        }
        
        print("FAILED - REMOVE Pending message for MessageID:" + messageId!)
 
 
        return nil
 
    }
    private func packageResultMessage(rawMessage: [UInt8])->AMFMessage{
        
        let resultMessage:AMFMessage = try! self.decoder.decodeMessage(rawMessage)
        
        var messageCorrelationId:String? = nil
        
        do{
            messageCorrelationId = try resultMessage.getMessageId()
        }catch let e {
            print(e.localizedDescription)
        }
        
        let result = self.removePendingMessageResult(messageId: messageCorrelationId)
        
        // Update result message with service definition
        resultMessage.serviceDefinition = (result?.serviceDefinition)!
        
        return resultMessage
        
    }
    
    private func sendMessageGroup(rawMessageGroup: [[UInt8]]){
        
        var results:[AMFMessage] = []
        
        for rawMessage in rawMessageGroup{
            
             self.decoder.resetPosition()
            
             let resultMessage:AMFMessage = packageResultMessage(rawMessage: rawMessage)
            
             results.append(resultMessage)
        }
        
        NotificationCenter.default.post(name: Notification.Name(self.key), object: nil, userInfo: ["result": results, "serviceKey": self.key, "messageGroupKey": (self._pendingGroupRequest?.notificationId)!])
        
    }
    
    
    private func sendMessage(rawMessage: [UInt8]){
        
        self.decoder.resetPosition()
        
        let resultMessage:AMFMessage = packageResultMessage(rawMessage: rawMessage)
        
        NotificationCenter.default.post(name: Notification.Name(self.key), object: nil, userInfo: ["result": resultMessage, "serviceKey": self.key, "messageGroupKey": ""])
    }
    
    private func encodeAndSendMessage(_ messageId: String, requestMessage: AMFMessage){
        
        self.encoder.encodeMessage(message: requestMessage)
        
                // TODO: Fix
        //_registeredServiceConfigurations.updateItem(config)
        
        invokeCall(self._gatewayUrl, messageId: messageId, requestMessage: Data(encoder.bytes)) { [unowned self] (success, resultMessage) -> () in
            
            if success {
                
                // If bad result...
                if(resultMessage == nil ){
                    //TODO: Print error here
                    return
                }
                
                // (1) HAS NO PENDING message results
                if(self._pendingMessageCount == 1 && self._pendingMessagesRaw.count == 0){
                    self._pendingMessageCount = 0 // Reset pending message(s) count
                    self._isPendingMessageResponse = false 
                    self.sendMessage(rawMessage: resultMessage as! [UInt8])
                    self._pendingMessagesRaw.removeAll()
                    return
                }
                
                // (2). HAS PENDING message results
                self._pendingMessageCount -= 1
                self._pendingMessagesRaw.append(resultMessage as! [UInt8])
                print("Removing counter: \(self._pendingMessageCount)")
                
                // (3). Still pending message results from server... delay decoding
                if ( self._pendingMessageCount > 0){
                  return
                }
                
                // (4). All messages have been processed (Single or Grouped)
                if(self._isPendingGroupedMessageResponse){
                    // (4.1) Grouped Message
                    self.sendMessageGroup(rawMessageGroup: self._pendingMessagesRaw)
                }
                else{
                    // (4.2) Single Message
                    for rawMessage in self._pendingMessagesRaw {
                        self.sendMessage(rawMessage: rawMessage)
                    }
                }
                
                // (5). Reset flags/data for grouped service call
                self._isPendingGroupedMessageResponse = false
                self._isPendingMessageResponse = false
                self._pendingGroupRequest = nil
                self._pendingMessagesRaw.removeAll()
            }
            else {
                
                // Do logic to handle errors here
                print("there was an error:", resultMessage!)
            }
        }
    }
    
    private func isWaiting() -> Bool{
        
        if(self._isPendingMessageResponse==true){
            
            // Add to Batch
            return true
        }
        
        return false
    }
 
    // Grouped Service Call
    open func call( requestGroup:AMFServiceRequestGroup, requestMessages:[AMFServiceRequestMessage]){
        
        if (_netConnection.objectEncoding == ObjectEncoding.amf0){
            
            print("AMF0 not supported for Flex RPC")
            
            //throw new NotSupportedException("AMF0 not supported for Flex RPC")
            
            return
        }
        
        if(!self._isPendingMessageResponse && !_isPendingGroupedMessageResponse){
            self._isPendingGroupedMessageResponse = true
            self._isPendingMessageResponse = true
            self._pendingGroupRequest = requestGroup
            
            // TODO: Create another property for pending Request Group
            // Set for Group
            self._pendingMessageCount = requestMessages.count
        }
        else{
            
            // TODO: Throw error
            print("Must wait until single service has returned")
            return
        }
        
        for request in requestMessages{
            executeCall(request.message, serviceDefinition: request.serviceDefinition)
        }
    }
    
    
    //: For Flex RPC
    open func call( request:IMessage, serviceDefinition:IAMFServiceDefinition)
    {
        if (_netConnection.objectEncoding == ObjectEncoding.amf0){
            print("AMF0 not supported for Flex RPC")
            //throw new NotSupportedException("AMF0 not supported for Flex RPC")
            return
        }
        
        if(!self._isPendingMessageResponse){
            self._isPendingMessageResponse = true
            self._pendingMessageCount = 1
        }
        else{
            self._pendingMessageCount += 1
        }
        
        executeCall( request, serviceDefinition: serviceDefinition)
     
    }
    
    func executeCall( _ message:IMessage, serviceDefinition:IAMFServiceDefinition){
        
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
        
        
        encodeAndSendMessage(message.messageId, requestMessage: amfMessage)
    }
    
    // Chang this to just bytes, too : bytes:[UInt8]?
    fileprivate func invokeCall(_ endpoint:String, messageId:String, requestMessage:Data, completion: @escaping (_ success: Bool, _ resultMessage: AnyObject?) -> ()) {
        
      
        post(clientAMFRequest(endpoint, messageId: messageId, requestAMFMessage: requestMessage)) { (success, result) -> () in
            
            // Thread on main queue
            DispatchQueue.main.async(execute: { () -> Void in
                
                if success {
                    completion(true, result )
                
                } else {
                    
                    // TODO: More in-depth error logic
                    var errorMessage = "there was an error"
                    if let result = result, let passedMessage = result["message"] as? String {
                        errorMessage = passedMessage
                    }
                     
                    print(errorMessage)
                    completion(true, result)
                }
            })
        }
    }
    
    
    // TODO: Will need to add custom headers eventually
    fileprivate func clientAMFRequest(_ endpoint:String, messageId:String, requestAMFMessage:Data, params: Dictionary<String, AnyObject>? = nil) -> URLRequest {
        
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
            request.setValue(messageId, forHTTPHeaderField: "Message-ID")
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
                
                // PREFIX
                //self.decoder.resetPosition()
                
                if(bytes != nil || data.bytes.count > 0){
                    //let amfMessage:AMFMessage = try! self.decoder.decodeMessage(data.bytes)
                    
                    if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                        completion(true, bytes! as AnyObject)
                    } else {
                        completion(false, bytes! as AnyObject)
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


