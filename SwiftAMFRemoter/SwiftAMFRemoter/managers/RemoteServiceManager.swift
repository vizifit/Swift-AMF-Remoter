//
//  SwiftAMFManager.swift
//  SwiftAMF
//
//  Created by Tony Henderson on 5/1/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation



open class RemoteServiceManager: IRemoteServiceManager  {
    
    
    
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
    
    //open static let sharedInstance = RemoteServiceManager()
    
    open class func getInstance(_ closure: () -> IRemoteServiceManager) -> IRemoteServiceManager {
        instanceQueue.sync(flags: .barrier, execute: {
            if(RemoteServiceManager.instance == nil) {
                RemoteServiceManager.instance = closure()
            }
        })
        
        return instance!
    }
    
    
    public init() {
        assert(RemoteServiceManager.instance == nil, RemoteServiceManager.SINGLETON_MSG)
        serviceConnectorMap = [:]
        observerMap = [:]
        
        _registeredServiceConfigurations = DictionaryBuilder()
        _registeredServiceRequestGroups = DictionaryBuilder()
        
        _amfCoder = AMF3Coder()
        
        RemoteServiceManager.instance = self
        
        //initializeView()
    }
    
    //This prevents others from using the default '()' initializer for this class.
//    fileprivate override init() {
//        
//        
//        _pendingModalServiceResults = DictionaryBuilder()
//        _registeredServiceConfigurations = DictionaryBuilder()
//        _registeredServiceRequestGroups = DictionaryBuilder()
//        _registeredServiceConnectors = DictionaryBuilder()
//        
//        serviceConnectorMap = [:]
//        observerMap = [:]
//        
//        _amfCoder = AMF3Coder()
//        
//        super.init()
//    
//    }
    
    fileprivate var _amfCoder:IAMFCoder
    
    fileprivate var _debugMode:Bool = false
    
    fileprivate var _registeredServiceConfigurations:DictionaryBuilder
    
    fileprivate var _registeredServiceRequestGroups:DictionaryBuilder
    
    
    /// Message constant
    open static let SINGLETON_MSG = "RemoteServiceManager Singleton already constructed!"
    
    
    // Mapping of NotificationConnector
    fileprivate var serviceConnectorMap: [String: IServiceConnectorView]
    
    // Concurrent queue for notificationConnectorMap
    // for speed and convenience of running concurrently while reading, and thread safety of blocking while mutating
    fileprivate let serviceConnectorMapQueue: DispatchQueue = DispatchQueue(label: "swiftAmfRemoter.serviceConnectorMapQueue", attributes: DispatchQueue.Attributes.concurrent)

    // Mapping of Notification names to Observer lists
    fileprivate var observerMap: [String: Array<IServiceConnectorObserver>]
   
    // Concurrent queue for observerMap
    // for speed and convenience of running concurrently while reading, and thread safety of blocking while mutating
    fileprivate let observerMapQueue: DispatchQueue = DispatchQueue(label: "swiftAmfRemoter.observerMapQueue", attributes: DispatchQueue.Attributes.concurrent)
    
    // Singleton instance
    fileprivate static var instance: IRemoteServiceManager?
    
    // Concurrent queue for singleton instance
    fileprivate static let instanceQueue = DispatchQueue(label: "swiftAmfRemoter.instanceQueue", attributes: DispatchQueue.Attributes.concurrent)

    
    internal enum EncryptionError: Error {
        case empty
        case short
        case obvious(String)
    }
   
    fileprivate var coder:IAMFCoder {
        get{
            return _amfCoder
        }
    }
    
    public var debugMode:Bool {
        get{
            return _debugMode
        }
    }


    @objc func serviceResponseHandler(_ notification: Notification) throws {
        
        guard let userInfo = notification.userInfo,
            let result  = userInfo["result"] as? AMFMessage,
            let serviceKey     = userInfo["serviceKey"]    as? String else {
                
                
                // TODO: Do logic here
                print("No userInfo found in notification")
                return
        }
        
        let connectorNotification:ServiceConnectorNotification = try ServiceConnectorNotification(result, serviceKey: serviceKey)
        
        //print(connectorNotification)
        // Display General services errors here
        
        //print(result)
        //print(serviceKey)
        
        // TODO: Remove EventHandler related code
        //dispatch(RemoteServiceManagerConstants.SERVICE_RESPONSE_NOTIFICATION, bubbles: false, data: result)

        
        // TODO: User service key as default filter

        notifyServiceConnectorObservers(connectorNotification)
        
        //notifyServiceConnectors(connectorNotification)

        
//        for (key,val) in (notification.userInfo)! {
//            let val_str = "\(key)"
//            
//            
//            if val_str == "event" {
//                let returnEvent:Event =  val as! Event
//                //let message = returnEvent.data as! AMFMessage
//                
//                
//                dispatch(RemoteServiceManagerConstants.SERVICE_RESPONSE_NOTIFICATION, bubbles: false, data: returnEvent.data)
//                
//                //remoteVideoURL = val
//                break
//            }
//        } 
    }
    
    open func toggleDebugMode(_ isEnabled:Bool){
        
        if(_debugMode != isEnabled){
            _debugMode = isEnabled
        }
    }
    /**
     *
     * @default
     */
    open func addClassMap(_ map:ClassMap){
        _amfCoder.addClassMap(map: map)
    }
    
    /**
     *
     * @default
     */
    open func removeAllClassMaps(){
        _amfCoder.removeAllClassMaps()
    }
    
    // MARK: - Service Connector Observer
    
    /**
     *
     * @default
     */
    func registerServiceConnectorObserver(_ notificationName: String, observer: IServiceConnectorObserver) {
        observerMapQueue.sync(flags: .barrier, execute: {
            if self.observerMap[notificationName] != nil {
                self.observerMap[notificationName]!.append(observer)
            } else {
                self.observerMap[notificationName] = [observer]
            }
        })
    }
    
    /**
     *
     * @default
     */
    func removeServiceConnectorObserver(_ notificationName: String, notifyContext: AnyObject) {
        observerMapQueue.sync(flags: .barrier, execute: {
            // the observer list for the notification under inspection
            if let observers = self.observerMap[notificationName] {
                
                // find the observer for the notifyContext
                for (index, _) in observers.enumerated() {
                    if observers[index].compareNotifyContext(notifyContext) {
                        // there can only be one Observer for a given notifyContext
                        // in any given Observer list, so remove it and break
                        self.observerMap[notificationName]!.remove(at: index)
                        break;
                    }
                }
                
                // Also, when a Notification's Observer list length falls to
                // zero, delete the notification key from the observer map
                if observers.isEmpty {
                    self.observerMap.removeValue(forKey: notificationName);
                }
            }
        })
    }
    
   func notifyServiceConnectorObservers(_ notification: IServiceConnectorNotification) {
        var observers: [IServiceConnectorObserver]?
        
        observerMapQueue.sync {
            // observers_ref is an immutable/constant reference to the observers list for this notification name
            // Swift Arrays are copied by value, and observers in this case a constant/immutable array
            // The original array may change during the notification loop but irrespective of that all observers will be notified
            if let observers_ref = self.observerMap[notification.notificationId] {
                observers = observers_ref
            }
        }
        
        // Notify Observers
        if observers != nil {
            for observer in observers! {
                observer.notifyObserver(notification)
            }
        }
    }
    
    // MARK: - Service Connector

    private func registerServiceConnector(_ connector: AnyObject) {
        
        serviceConnectorMapQueue.sync(flags: .barrier, execute: {
            
            if(_debugMode){
                print("Registering IServiceConnectorView: " + (connector as! IServiceConnectorView).connectorId)
            }
            
            // Register the Connector for retrieval by name
            self.serviceConnectorMap[(connector as! IServiceConnectorView).connectorId] = connector as? IServiceConnectorView
            
            // Get Notification interests, if any.
            let interests = (connector as! IServiceConnectorView).listNotificationInterests()
            
            // Register Mediator as an observer for each notification of interests
            if !interests.isEmpty {
                // Create Observer referencing this mediator's handlNotification method
                
                let observer = ServiceConnectorObserver(notifyMethod: {notification in (connector as! IServiceConnectorView).handleServiceNotification(notification)}, notifyContext: connector )
                
                // Register Mediator as Observer for its list of Notification interests
                for notificationName in interests {
                    self.registerServiceConnectorObserver(notificationName, observer: observer)
                }
            }
            
            //TODO: Not sure if I need
            //connector.onRegister()
        })

    }
    /**
     *
     * @default
     */
    open func registerServiceConnector(_ connector: IServiceConnectorView) {
        // do not allow re-registration (you must removeConnector first)
        if (hasServiceConnector(connector.connectorId)) {
            return
        }
        
        registerServiceConnector(connector as AnyObject)
        
//        serviceConnectorMapQueue.sync(flags: .barrier, execute: {
//            
//            // Register the Connector for retrieval by name
//            self.serviceConnectorMap[connector.connectorId] = connector
//            
//            // Get Notification interests, if any.
//            let interests = connector.listNotificationInterests()
//            
//            // Register Mediator as an observer for each notification of interests
//            if !interests.isEmpty {
//                // Create Observer referencing this mediator's handlNotification method
//                
//                let observer = ServiceConnectorObserver(notifyMethod: {notification in connector.handleServiceNotification(notification)}, notifyContext: connector as AnyObject )
//                
//                // Register Mediator as Observer for its list of Notification interests
//                for notificationName in interests {
//                    self.registerServiceConnectorObserver(notificationName, observer: observer)
//                }
//            }
//            
//            //TODO: Not sure if I need
//            //connector.onRegister()
//        })
    }
    
    /**
     *
     * @default
     */
    open func removeServiceConnector(_ connectorId: String) {
        var removed: IServiceConnectorView?
        serviceConnectorMapQueue.sync(flags: .barrier, execute: {
            if let connector = self.serviceConnectorMap[connectorId] {
                
                // for every notification this mediator is interested in...
                let interests = connector.listNotificationInterests()
                
                for notificationName in interests {
                    // remove the observer linking the mediator
                    // to the notification interest
                    self.removeServiceConnectorObserver(notificationName, notifyContext: connector as AnyObject)
                }
                
                if(_debugMode){
                    print("Removing IServiceConnectorView: " + connectorId)
                }
                
                // remove the connector from the map
                removed = self.serviceConnectorMap.removeValue(forKey: connectorId)
                
                // alert the connector that it has been removed
                
                //TODO: Do I need this?
                //connector.onRemove()
            }
        })
    }
    
    /**
     *
     * @default
     */
    open func getServiceConnector(_ connectorId: String) -> IServiceConnectorView? {
        var connector: IServiceConnectorView?
        serviceConnectorMapQueue.sync {
            connector = self.serviceConnectorMap[connectorId]
        }
        return connector
    }

    /**
     *
     * @default
     */
    open func hasServiceConnector(_ connectorId: String) -> Bool {
        var result = false
        serviceConnectorMapQueue.sync {
            result = self.serviceConnectorMap[connectorId] != nil
        }
        
        return result
    }

    
    // MARK: - Service Configuration
    
    /**
     *
     * @default
     */
    open func addServiceConfiguration(_ configuration:RemoteServiceConfiguration){
        
        if(_registeredServiceConfigurations.itemExists(configuration.key)){
            
            // TODO: Add logging here
            return
        }
         
        _registeredServiceConfigurations.addItem(configuration)
        
        
        // Add Notification observers
        NotificationCenter.default.addObserver(self, selector: #selector(RemoteServiceManager.serviceResponseHandler),
                                               name: Notification.Name(configuration.key),
                                               object: nil)
 
        
    }
    
    /**
     *
     * @default
     */
    open func removeServiceConfiguration(_ key:String){
        
        if(!_registeredServiceConfigurations.itemExists(key)){
            
            // TODO: Add logging here
            return
        }

        _registeredServiceConfigurations.removeItem(key)
        
        // Remove notification observers
        NotificationCenter.default.removeObserver(self,
                                               name: Notification.Name(key),
                                               object: nil)
        
    }
    
    /**
     *
     * @default
     */
    open func getServiceConfiguration(_ key:String)->RemoteServiceConfiguration?{
        
        return (_registeredServiceConfigurations.getItem(key) as? RemoteServiceConfiguration?)!
        
    }
    
    /**
     *
     * @default
     */
    open func hasServiceConfiguration(_ key:String)->Bool{
        
        return (_registeredServiceConfigurations.itemExists(key))
    }
    
    /**
     *
     * @default
     */
    open func invokeServiceCall(_ serviceConfigKey:String, serviceDefinition:IAMFServiceDefinition, args:Any?... ){
        
        invokeServiceBaseMethod(serviceConfigKey,
                                   serviceDefinition: serviceDefinition,
                                   requestId: nil,
                                   groupKey: nil,
                                   args: args)
        
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
            
            //TODO: Not sure if we want unique or per session
            // Update Unique messageId
            //config.remoteMessage?.clientId = UUID().uuidString
            
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
    
    
        // Set body arguments
        if(args.count > 0){
            
            var bodyArguments:[Any]? = []
            let parameters:[Any]? = args[0] as? [Any]
            
            for parameter in parameters! {
                bodyArguments!.append(parameter)
            }
            
            config.remoteMessage?.body = bodyArguments
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

// MARK: - Old service connector code
//
//    open func registerServiceConnector(_ connector:IServiceConnector){
//
//        if(self._registeredServiceConnectors.itemExists(connector.key)){
//
//            // TODO: Add logging here
//            return
//        }
//
//        self._registeredServiceConnectors.addItem(connector)
//
//    }
//
//    open func unRegisterServiceConnector(_ connectorId:String){
//
//        if(!_registeredServiceConnectors.itemExists(connectorId)){
//
//            // TODO: Add logging here
//            return
//        }
//
//        _registeredServiceConnectors.removeItem(connectorId)
//
//    }

//    fileprivate func notifyServiceConnectors(_ notification:IServiceConnectorNotification){
//
//        var connector:IServiceConnector
//
//        // Loop through connectors & call interface method
//        for (key, value) in _registeredServiceConnectors.list {
//
//            connector = value as! IServiceConnector
//
//            //TODO: For later (Type and group restriction)
//
//            //connector.connectorNotificationFilter
//            //connector.onServiceNotification(notification)
//
//            print("Property Value: \(key)")
//            print("Key Value: \(String(describing: value))")
//        }
//    }

//    open func unRegisterServiceConnector(_ connector:IServiceConnector){
//
//         //NSNotificationCenter.defaultCenter().addObserver(connector, selector: "gestureHandler", name: notificationName, object: nil)
//        if(!_registeredServiceConnectors.itemExists(connector.key)){
//
//            // TODO: Add logging here
//            return
//        }
//
//        _registeredServiceConnectors.removeItem(connector.key)
//
//    }
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
