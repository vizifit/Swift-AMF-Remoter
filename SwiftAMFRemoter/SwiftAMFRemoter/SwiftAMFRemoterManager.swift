//
//  SwiftAMFManager.swift
//  SwiftAMF
//
//  Created by Tony Henderson on 5/1/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation



open class SwiftAMFRemoterManager : EventDispatcher {
    
    
    
    /**
     *
     * @default
     */
    //public static const DEFAULT_LOADING_MESSAGE:String = "Loading data...";
    
    /**
     *
     * @default
     */
    //public static const DEFAULT_LOADING_TITLE:String = "Please wait";
    
    open static let sharedInstance = SwiftAMFRemoterManager()
    
    //This prevents others from using the default '()' initializer for this class.
    fileprivate override init() {
        
        
        _pendingModalServiceResults = DictionaryBuilder()
        _registeredServiceConfigurations = DictionaryBuilder()
        _registeredServiceRequestGroups = DictionaryBuilder()
        _amfCoder = AMF3Coder()
        
        super.init()
    
    }
    
    fileprivate var _amfCoder:IAMFCoder;
    
    fileprivate var _pendingModalServiceResults:DictionaryBuilder
    
    fileprivate var _registeredServiceConfigurations:DictionaryBuilder
    
    fileprivate var _registeredServiceRequestGroups:DictionaryBuilder
    
   
    fileprivate var coder:IAMFCoder {
        get{
            return _amfCoder
        }
    }

    func onClientResponse(_ notification: Notification) {
        
        for (key,val) in (notification.userInfo)! {
            let val_str = "\(key)"
            
            
            if val_str == "event" {
                let returnEvent:Event =  val as! Event
                //let message = returnEvent.data as! AMFMessage
                
                
                dispatch(RemoteServiceManagerConstants.SERVICE_RESPONSE_NOTIFICATION, bubbles: false, data: returnEvent.data)
                
                //remoteVideoURL = val
                break
            }
        } 
    }
    
    open func addClassMap(_ map:ClassMap){
        _amfCoder.addClassMap(map: map)
    }
    
    
    open func addServiceConfiguration(_ configuration:RemoteServiceConfiguration){
        
        if(_registeredServiceConfigurations.itemExists(configuration.key)){
            
            // TODO: Add logging here
            return
        }
         
        _registeredServiceConfigurations.addItem(configuration)
        
        configuration.connection.addEventListener(configuration.key, selector: #selector(onClientResponse(_:)), observer: self, useCapture: false)
        
        
    }
    
    open func removeServiceConfiguration(_ key:String){
        
        if(!_registeredServiceConfigurations.itemExists(key)){
            
            // TODO: Add logging here
            return
        }
        
        // Remove event listner
        getServiceConfiguration(key)?.connection.removeEventListener(key, selector: #selector(onClientResponse(_:)), observer: self, useCapture: false)
        
        
        _registeredServiceConfigurations.removeItem(key)
        
    }
    
    open func getServiceConfiguration(_ key:String)->RemoteServiceConfiguration?{
        
        return (_registeredServiceConfigurations.getItem(key) as? RemoteServiceConfiguration?)!
        
    }
    
    open func serviceCongurationExists(_ key:String)->Bool{
        
        return (_registeredServiceConfigurations.itemExists(key))
    }
    
    open func invokeServiceCall(_ serviceConfigKey:String, serviceDefinition:IAMFServiceDefinition, args:Any?... ){
        
        invokeServiceBaseMethod(serviceConfigKey,
                                   serviceDefinition: serviceDefinition,
                                   requestId: nil,
                                   groupKey: nil,
                                   args: args)
        
    }
    
    internal enum EncryptionError: Error {
        case empty
        case short
        case obvious(String)
    }
 
   fileprivate func invokeServiceBaseMethod( _ serviceConfigKey:String,
                                                 serviceDefinition:IAMFServiceDefinition,
                                                 requestId:String? = nil,
                                                 groupKey:String? = nil,
                                                 args:Any?... ){
        
        if(_registeredServiceConfigurations.itemExists(serviceConfigKey) == false){
            
            // Todo: Throw error/log
            return
        }
    
        
        
        let config:RemoteServiceConfiguration = (_registeredServiceConfigurations.getItem( serviceConfigKey ) as? RemoteServiceConfiguration)!
    
        if config.connection.connected == false {
            // Todo: Throw error/log
            print("NOT CONNECTED")
            return
        }
    
    
        let destination = serviceDefinition.destination != nil ? serviceDefinition.destination : config.destination
        let endpoint = serviceDefinition.endpoint != nil ? serviceDefinition.endpoint : config.endpoint
        let source = serviceDefinition.source != nil ? serviceDefinition.source : config.source
        
        if(config.remoteMessage == nil){
            
            config.remoteMessage = RemotingMessage.remoteMessageFactory(destination: destination!,
                                                                        endpoint: "my-amf",
                                                                        timeToLive: config.timeout,
                                                                        connectionId: requestId)
            
            config.remoteMessage?.source = source
        }
        else{
            if serviceDefinition.destination != nil{
                config.remoteMessage?.destination = destination
            }
           
            if serviceDefinition.endpoint != nil {
                RemotingMessage.updateRemoteMessage(message: config.remoteMessage!, endpoint: endpoint!, clientId: nil)
            }
            
            if serviceDefinition.source != nil {
                config.remoteMessage?.source = source
            }
            
            if requestId != nil {
                 RemotingMessage.updateRemoteMessage(message: config.remoteMessage!, endpoint: nil, clientId: requestId)
            }
           
        }
    
        config.remoteMessage?.source = serviceDefinition.source //"com.vizifit.API.Facade.UserFacade"
        config.remoteMessage?.operation = serviceDefinition.methodName
    
    
        //var parameters:[Any]? = []
    
    
    
        if(args.count > 0){
            
            
            var bodyArr:[Any]? = []
            
            let parameters:[Any]? = args[0] as? [Any]
            for parameter in parameters! {
                bodyArr!.append(parameter)
            }
            
            config.remoteMessage?.body = bodyArr
        }
    
    
        //config.remoteMessage?.body = ((parameters?.count)!>0) ? parameters : nil // args
        config.connection.call(config.remoteMessage!, serviceDefinition:serviceDefinition, callback: nil)
    
        // Command test
        //let commMessage:CommandMessage = CommandMessage.commandMessageFactory(destination: "Fluorine", endpoint: config.endpoint!)

        //config.connection.call(commMessage, callback: nil)

    }
    
    
    fileprivate func clientAMFRequest(_ endpoint:String, amfMessage:Data, params: Dictionary<String, AnyObject>? = nil) -> URLRequest {
        
        var request = URLRequest(url: URL(string: endpoint)!)
        
        if params != nil {
//            var paramString = ""
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
    
}

// MARK: OLD Code, leave around temporarily until things are working.

//    fileprivate func post(_ request: URLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
//        dataTask(request as URLRequest, method: "POST", completion: completion)
//    }
//
//    fileprivate func put(_ request: URLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
//        dataTask(request as URLRequest, method: "PUT", completion: completion)
//    }
//
//    fileprivate func get(_ request: URLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
//        dataTask(request as URLRequest, method: "GET", completion: completion)
//    }
//
//    fileprivate func dataTask(_ request: URLRequest, method: String, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
//
//        var request = request
//        request.httpMethod = method
//
//        let session = URLSession(configuration: URLSessionConfiguration.default)
//
//
//        session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
//            if let data = data {
//                let json = try? JSONSerialization.jsonObject(with: data, options: [])
//                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
//                    completion(true, json as AnyObject?)
//                } else {
//                    completion(false, json as AnyObject?)
//                }
//            }
//        }) .resume()
//    }


//    internal function invokeAMFServiceBaseMethod( serviceConfigKey:String, serviceDefinition:IAmfServiceFacadeDefinition, requestId:String = null,
//    groupKey:String = null, ... args ):void {
//
//    try {
//
//				if ( !serviceConfigKey )
//    throw new Error( FacadeErrorConstants.FACADE_KEY_ERROR_MSG );
//
//				if ( !_registeredServiceConfigurations.itemExists( serviceConfigKey ))
//    throw new Error( FacadeErrorConstants.FACADE_NOT_REGISTERED_ERROR_MSG );
//
//				var config:FacadeServiceConfiguration = _registeredServiceConfigurations.getItem( serviceConfigKey ) as FacadeServiceConfiguration;
//
//				// Reuse remote object.
//				config.remoteObject.requestTimeout = config.timeout;
//				config.remoteObject.destination = ( serviceDefinition.destination ) ? serviceDefinition.destination : config.destination;
//				config.remoteObject.source = ( serviceDefinition.source ) ? serviceDefinition.source : config.source;
//				config.remoteObject.endpoint = ( serviceDefinition.endpoint ) ? serviceDefinition.endpoint : config.endpoint;
//
//				const asyncToken:AsyncToken = config.remoteObject[ serviceDefinition.methodName ].send.apply( null, args );
//
//				// Create unique request ID (if not provided)
//				if ( !requestId )
//    requestId = UIDUtil.createUID();
//
//				//  Add Modal wait (blocking) here
//				if ( !useServiceGroupWaitMessage( groupKey ))
//    addPendingModalResult( requestId, null, serviceDefinition.modalWaitMessage );
//
//				// Send service with custom responder
//				asyncToken.addResponder( new FacadeServiceResponder( onAmfServiceResult,
//    onAmfServiceFault,
//    serviceConfigKey,
//    serviceDefinition,
//    requestId,
//    groupKey ));
//
//				LoggingManager.instance.trace(serviceDefinition, "invokeAMFServiceBaseMethod service: " + serviceDefinition.value + " groupKey: ", groupKey);
//				//trace( "DEBUG: ", "invokeAMFServiceBaseMethod ", "service: ", serviceDefinition.value, " groupKey: ", groupKey );
//
//    } catch ( e:Error ) {
//
//				// Todo: Might handle with custom message and log here.
//				throw e;
//    }
//    }
/**
 *
 * @param serviceConfigKey
 * @param serviceDefinition
 * @param args
 */
//    public function invokeAMFServiceCall( serviceConfigKey:String, serviceDefinition:IAmfServiceFacadeDefinition, ... args ):void {
//
//    trace( "DEBUG: ", "invokeAMFServiceCall ", "service: ", serviceDefinition.value );
//
//    // Call base, internal method which handles grouped service calls
//    invokeAMFServiceBaseMethod.apply( null, [ serviceConfigKey, serviceDefinition, UIDUtil.createUID(), null ].concat( args ));
//
//    }


/// Old test code


//return

//ObjectUtils.toDictionary(CommandMessage())
//ObjectUtils.toClassMembers(CommandMessage())

//        ObjectUtils.toDictionary((config.remoteMessage!))
//


//        let amfMessage:AMFMessage = AMFMessage(version:  ObjectEncoding.amf3)
//        let amfMessageBody:AMFMessageBody = AMFMessageBody(target: "test", response: "test", content: [config.remoteMessage!])
//        amfMessage.addBody(amfMessageBody)
//
//
//
//
//
//        coder.encodeMessage(message: amfMessage)
//        var data:Data = Data()
//        data.append(coder.bytes, count: coder.bytes.count)
//        // TODO: Fix
//        //_registeredServiceConfigurations.updateItem(config)
//
//        invokeCall(endpoint!, amfMessage: data) { (success, message) -> () in
//                if success {
//                    print("logged in successfully!")
//                } else {
//                    print("there was an error:", message!)
//                }
//        }


//    fileprivate func invokeCall(_ endpoint:String, amfMessage:Data, completion: @escaping (_ success: Bool, _ message: String?) -> ()) {
//
//
//        //let loginObject = ["email": email, "password": password]
//
//        post(clientAMFRequest(endpoint, amfMessage: amfMessage)) { (success, object) -> () in
//
//            DispatchQueue.main.async(execute: { () -> Void in
//                if success {
//                    completion(true, nil)
//                } else {
//                    var errorMessage = "there was an error"
//                    if let object = object, let passedMessage = object["message"] as? String {
//                        errorMessage = passedMessage
//                    }
//                    completion(true, errorMessage)
//                }
//            })
//        }
//    }
