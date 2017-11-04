//
//  ViewController.swift
//  Example
//
//  Created by Tony Henderson on 6/7/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import UIKit
import SwiftAMFRemoter

class ViewController: UIViewController, IServiceConnectorView {
    
    
    private let GROUP_NOTIFICATION_TEST:String = "GROUP_NOTIFICATION_TEST"
    
    private var  _before:Double = 0
    private var _after:Double = 0
    private var _mgr:IRemoteServiceManager? = nil
    private var _connectorId:String = ""
    private var _encoder:IAMFCoder =  AMF3Coder()
    private var _decoder:IAMFCoder =  AMF3Coder()
    
    open func listNotificationInterests() -> [String]{
        
        return [UserFacadeServiceDefinition.LOGIN_BY_EMAIL.resultNotificationId!,
                UserFacadeServiceDefinition.LOGIN_BY_EMAIL.faultNotificationId!,
        GROUP_NOTIFICATION_TEST]
    }
    
    /**
     Gets unique Id of connector
     */
    open var connectorId:String { get { return self._connectorId} }
   
    //------------------------------------
    // Encode/Decode Values
    //------------------------------------
    @IBAction func encodeDecodeSimpleValue(_ sender: AnyObject) {
        
        testEncodeDecode()
    }
    
    @IBAction func encodeDecodeComplexValue(_ sender: AnyObject) {
        
    }
    
    //------------------------------------
    // Persist Encoded values
    //------------------------------------
    @IBAction func persistSaveAndRetrieveEncodedValue(_ sender: AnyObject) {
        
         testPersistSaveAndRetrieveEncodedData()
    }
    
    //------------------------------------
    // Service Calls
    //------------------------------------
    @IBAction func callAmfSingleParallelMethod(_ sender: AnyObject) {
        
        executeServiceCommand(type: CallExecutionType.singleParallelCall)
    }
    
    @IBAction func callAmfGroupedMethod(_ sender: AnyObject) {
        
        executeServiceCommand(type: CallExecutionType.groupedCall, maxRows: 10)
    }
    
    @IBAction func callAmfSingleMethod(_ sender: AnyObject) {
        
        executeServiceCommand(type: CallExecutionType.singleCall)
    }
    
    private enum CallExecutionType: Int    {
        case singleCall = 1
        case singleParallelCall = 2
        case groupedCall = 3
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        _mgr = UIViewController.getRemoteServiceManager()
        _mgr?.toggleDebugMode(false)
        AMF3Coder.verboseDebug = false
        
        DataTypeInitializer.registerClassAliases()
        
        registerServiceConnector(self)
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeServiceConnector(self.connectorId)
        
        super.viewWillDisappear(animated)
    }
    
    deinit {
        print("deinitializing")
        
    }
    
    func testPersistSaveAndRetrieveEncodedData(){
         
        let value:UserContext = returnUserContext()
        
        do {
            
            let pCache:AMFPersistantCache = try AMFPersistantCache(cacheId: "TestCacheItem", cacheData: [])
            let result = try PersistantStorage.encodeItemToCache(cacheItemKey: pCache.cacheId, cache: pCache, object: value)
            
            print(result)
            
            PersistantStorage.store(pCache, to: .caches, as: pCache.cacheId)
            
            // Retreive
            let getPCache = PersistantStorage.retrieve(pCache.cacheId, from: .caches, as: AMFPersistantCache.self)
            let decodedValue = try PersistantStorage.decodeItemFromCache(cache: getPCache, cacheItemKey: pCache.cacheId, isFromClassName: false) as? UserContext
            
            print((decodedValue?.User.FirstName)!)
            print((decodedValue?.User.LastName)!)
            print((decodedValue?.Account.Password)!)
            print((decodedValue?.Profile.Tagline)!)
            
        }
        catch {
            print("testPersistSaveAndRetrieveEncodedData: Failed")
        }
    }
    
    func testEncodeDecode() {
        
        _encoder.resetPosition()
        _decoder.resetPosition()
        
        print("AMF Encoder - START\n")
 
         let value:UserContext = returnUserContext()
        _encoder.encodeValue(value)

        print("> Encoded Bytes: \(_encoder.bytes.count)\n")

        var decodedValue:UserContext? = nil
        
        do {

             decodedValue = try _decoder.decodeValue(_encoder.bytes) as? UserContext

            print((decodedValue?.User.FirstName)!)
            print((decodedValue?.User.LastName)!)
            print((decodedValue?.Account.Password)!)
            print((decodedValue?.Profile.Tagline)!)

            print((decodedValue?.Membership.BrandId)!)

            print("> \nDecoded Bytes: \(_decoder.bytes.count)")
        }
            //            // 4
        catch {
             print("testEncodeDecode: Failed")
        }
        
        print("AMF Encoder - END")
    }
    
    func returnUser()-> VzUser{
        
        let value:VzUser = VzUser()
        
        //value.ItemGuid = "82c3fd1b-9157-4df2-a43c-05790e2f1ce8"
        value.Id = 1
        value.UserTypeId = 1
        //value.UserType.ItemGuid = "82c3fd1b-9157-4df2-a43c-05790e2f1ce8"
        value.FirstName = "Tony"
        value.LastName = "Henderson"
        
        return value
    }
    
    func returnUserContext()-> UserContext{
        
        let value:UserContext = UserContext()
        
        
        value.User.ItemGuid = "82c3fd1b-9157-4df2-a43c-05790e2f1ce8"
        value.User.Id = 1
        value.User.UserTypeId = 1
        value.User.FirstName = "Tony"
        value.User.LastName = "Henderson"
        
        value.User.UserType = VzUserType()
        value.User.UserType?.ItemGuid = "82c3fd1b-9157-4df2-a43c-05790e2f1ce8"
        
        //userContext.Profile.User = nil
        value.Profile.Tagline = "IRock"
        value.Account.Password = "FADSFADSDS"
        
        value.Membership.BrandId = 45
        //userContext.Account.User = nil
        value.Networks = []
        
        let netAcct:VzNetworkAccount = VzNetworkAccount()
        
        netAcct.DateRegistered = Date()
        netAcct.NetworkTypeId = 1
        netAcct.UserId = value.User.Id
        value.Networks?.append(netAcct)
        return value
    }
    
    private func executeServiceCommand(type: CallExecutionType, maxRows:Int = 10){
        
        _before = Date().timeIntervalSince1970
        
        _mgr?.addServiceConfiguration(RemoteServiceConfiguration(key: ServiceConstants.SERVICE_KEY,
                                                                 destination: "fluorine",
                                                                 endpoint: "http://vizifitdev.cloudapp.net/Gateway.aspx",
                                                                 securityPolicyUrl: "securityPolicyUrl",
                                                                 source: "ServiceLibrary.MyDataService",
                                                                 timeout: 3000,
                                                                 modalWait: true,
                                                                 isUpdateable: false))
        
        let max = maxRows
        var counter=0
        let startIdx = 1
        
        switch type {
        case .singleCall:
            //--------------------------------------
            // Single Call
            //--------------------------------------
            _mgr?.invokeServiceCall(ServiceConstants.SERVICE_KEY, serviceDefinition: UserFacadeServiceDefinition.LOGIN_BY_EMAIL , args: "test@test.com", "Ahhender7215")
            
            break
            
        case .singleParallelCall:
            //--------------------------------------
            // Parallel Single Call
            //--------------------------------------
            _mgr?.invokeServiceCall(ServiceConstants.SERVICE_KEY, serviceDefinition: UserFacadeServiceDefinition.LOGIN_BY_EMAIL , args: "test@test.com", "Ahhender7215")
            
            for i in startIdx..<max{
                _mgr?.invokeServiceCall(ServiceConstants.SERVICE_KEY, serviceDefinition: UserFacadeServiceDefinition.LOGIN_BY_EMAIL , args: String(counter) +  "test@test.com", "Ahhender7215")
                counter = i
            }
            break
            
        case .groupedCall:
            //--------------------------------------
            // Grouped Call
            //--------------------------------------
            var requestGroup:[AMFServiceRequest] = []
            requestGroup.append(AMFServiceRequest(serviceConfigKey:ServiceConstants.SERVICE_KEY, serviceDefinition: UserFacadeServiceDefinition.LOGIN_BY_EMAIL, args: "test@test.com", "Ahhender7215"))
            requestGroup.append(AMFServiceRequest(serviceConfigKey:ServiceConstants.SERVICE_KEY, serviceDefinition: UserFacadeServiceDefinition.LOGIN_BY_EMAIL, args: "test@test1.com", "Ahhender7215"))
            requestGroup.append(AMFServiceRequest(serviceConfigKey:ServiceConstants.SERVICE_KEY, serviceDefinition: UserFacadeServiceDefinition.LOGIN_BY_EMAIL, args: "test@test2.com", "Ahhender7215"))
            
            let serviceGroup:AMFServiceRequestGroup = AMFServiceRequestGroup(amfServiceRequests: requestGroup,
                                                                             notificationId: GROUP_NOTIFICATION_TEST)
            
            _mgr?.invokeGroupedServiceCall(ServiceConstants.SERVICE_KEY, requestGroup: serviceGroup)
            break
        default:
            //
            break
        }
        
        _after = Date().timeIntervalSince1970
    }
    
    
    open func handleServiceNotification(_ notification: IServiceConnectorNotification) {
        
        print("NotificationID: " + notification.notificationId)
        
        switch(notification.notificationId){
            
        case UserFacadeServiceDefinition.LOGIN_BY_EMAIL.resultNotificationId!:
            print("Received RESULT for:" + notification.notificationId)
            break
            
        case UserFacadeServiceDefinition.LOGIN_BY_EMAIL.faultNotificationId!:
            print("Received FAULT for:" + notification.notificationId)
            
            break
            
        case GROUP_NOTIFICATION_TEST:
            print("Received RESULT for:" + notification.notificationId)
            break
            
        default:
            print("Unregistered notification...")
            break
        }
    }
    
}

//    func onRemoteServiceEvent(_ notification: Notification) {
//
//        do {
//            for (key,val) in (notification.userInfo)! {
//                let val_str = "\(key)"
//
//
//                print(key)
//                if val_str == "event" {
//                    let returnEvent:Event =  val as! Event
//                    let message = returnEvent.data as! AMFMessage
//
//                    let result = try message.getResult()
//
//                    if((result.1 as? ASObject) != nil){
//
//                        print("ERROR")
//                        print("------------------------")
//                        print(((result.1 as? ErrorMessage)?.faultCode)! + " " + ((result.1 as? ErrorMessage)?.faultString)!)
//                        return
//                    }
//
//                    //PunchJunkieModel.sharedInstance.userFacadeModel.LoginByEmailResult = (result.1 as? UserContext)!
//
//                    print("SUCCESS")
//                    print("------------------------")
//                    print(result)
//                    //remoteVideoURL = val
//                    break
//                }
//            }
//
//            _after = Date().timeIntervalSince1970
//
//            print (String(format: "%.2f Seconds", (_after-_before)))
//        }
//        catch let e as Error {
//            print(e.localizedDescription)
//        }
//
//    }



