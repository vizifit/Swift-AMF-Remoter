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
                ActivityFacadeServiceDefinition.GET_ACTIVITY_CONFIGURATION_DATA.resultNotificationId!,
                ActivityFacadeServiceDefinition.GET_ACTIVITY_CONFIGURATION_DATA.faultNotificationId!,
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
        _mgr?.toggleDebugMode(true)
        AMF3Coder.verboseDebug = true
        
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
            
            let pCache:AMFPersistantCache = try AMFPersistantCache(cacheId: "USED_DATA_CACHE", cacheData: [])
            let result = try PersistantStorage.encodeItemToCache(cacheItemKey: pCache.cacheId, cache: pCache, object: value)
            
            print(result)
            
            PersistantStorage.store(pCache, to: .caches, as: pCache.cacheId)
            
            // Retreive
            let getPCache = PersistantStorage.retrieve(pCache.cacheId, from: .caches, as: AMFPersistantCache.self)
            let decodedValue = try PersistantStorage.decodeItemFromCache(cache: getPCache, cacheItemKey: pCache.cacheId, isFromClassName: false) as? UserContext
            
            print((decodedValue?.User?.FirstName)!)
            print((decodedValue?.User?.LastName)!)
            print((decodedValue?.Account?.Password)!)
            print((decodedValue?.Profile?.Tagline)!)
            
        }
        catch {
            print("testPersistSaveAndRetrieveEncodedData: Failed")
        }
    }
    
    func testEncodeDecode() {
        
        
        let cachefiles = ["USED_DATA_CACHE",
                          "MEDIA_DATA_CACHE",
                          "ACTIVITY_DATA_CACHE"]
        
        PersistantStorage.remove(cachefiles, from: .caches)
        _encoder.resetPosition()
        _decoder.resetPosition()
        
        print("AMF Encoder - START\n")
 
         //let value:UserContext = returnUserContext()
        let value:ActivityConfigurationData = returnActivityConfigData()
        _encoder.encodeValue(value)

        print("> Encoded Bytes: \(_encoder.bytes.count)\n")

        var decodedValue:ActivityConfigurationData? = nil
        
        do {

             decodedValue = try _decoder.decodeValue(_encoder.bytes) as? ActivityConfigurationData

            print(decodedValue?.ActivityAttributeTypes?.count)
//            print((decodedValue?.User?.FirstName)!)
//            print((decodedValue?.User?.LastName)!)
//            print((decodedValue?.Account?.Password)!)
//            print((decodedValue?.Profile?.Tagline)!)
//
//            print((decodedValue?.Membership?.BrandId)!)

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
    
    func returnActivityConfigData() -> ActivityConfigurationData{
        
        let value:ActivityConfigurationData = ActivityConfigurationData()
        
        value.ActivityAttributeTypes = []
        
        
        let sameDate:Date = Date()
        var index = 0
        let attrType:VzActivityAttributeType = VzActivityAttributeType()
        let attrType2:VzActivityAttributeType = VzActivityAttributeType()
        index+=1
        setBaseContent(value: attrType , index: index , sameDate: sameDate)
        index+=1
        setBaseContent(value: attrType2, index: index , sameDate: sameDate)
        value.ActivityAttributeTypes?.append(attrType)
        value.ActivityAttributeTypes?.append(attrType2)
        
        value.ActivityGoalTypes = []
        let goalType:VzActivityGoalType = VzActivityGoalType()
        let goalType2:VzActivityGoalType = VzActivityGoalType()
        index+=1
        setBaseContent(value: goalType , index: index , sameDate: sameDate)
        index+=1
        setBaseContent(value: goalType2, index: index , sameDate: sameDate)
        value.ActivityGoalTypes?.append(goalType)
        value.ActivityGoalTypes?.append(goalType2)
        
        value.ActivityEquipmentTypes = []
        let equipType:VzActivityEquipmentType = VzActivityEquipmentType()
        let equipType2:VzActivityEquipmentType = VzActivityEquipmentType()
        index+=1
        setBaseContent(value: equipType , index: index , sameDate: sameDate)
        index+=1
        setBaseContent(value: equipType2, index: index , sameDate: sameDate)
        value.ActivityEquipmentTypes?.append(equipType)
        value.ActivityEquipmentTypes?.append(equipType2)
        
        
        value.ActivityTypes = []
        let actType:VzActivityType = VzActivityType()
        let actType2:VzActivityType = VzActivityType()
        index+=1
        setBaseContent(value: actType , index: index , sameDate: sameDate)
        index+=1
        setBaseContent(value: actType2, index: index , sameDate: sameDate)
        value.ActivityTypes?.append(actType)
        value.ActivityTypes?.append(actType2)
        
        return value
        
    }
    
    func setBaseContent(value:BaseContentType, index:Int, sameDate:Date){
        
        let uniqueValue = String(index) + "Test"
        value.Code = uniqueValue
        value.Id = index
        value.Name = uniqueValue
        value.Description = uniqueValue + " Description"
        value.CreatedDate = sameDate
        value.CreatedDateUtc = sameDate
        value.LastModifiedDate = sameDate
        value.LastModifiedDateUtc = sameDate
    }
    func returnUserContext()-> UserContext{
        
        let value:UserContext = UserContext()
        
        value.User = VzUser()
        value.User?.ItemGuid = "82c3fd1b-9157-4df2-a43c-05790e2f1ce8"
        value.User?.Id = 1
        value.User?.UserTypeId = 1
        value.User?.FirstName = "Tony"
        value.User?.LastName = "Henderson"
        
        value.User?.UserType = VzUserType()
        value.User?.UserType?.ItemGuid = "82c3fd1b-9157-4df2-a43c-05790e2f1ce8"
        
        //userContext.Profile.User = nil
        
        value.Profile = VzProfile()
        value.Profile?.Tagline = "IRock"
        
        value.Account = VzAccount()
        value.Account?.Password = "FADSFADSDS"
        
        value.Membership = VzBrandMembership()
        value.Membership?.BrandId = 45
        //userContext.Account.User = nil
        value.Networks = []
        
        let netAcct:VzNetworkAccount = VzNetworkAccount()
    
        netAcct.DateRegistered = Date()
        netAcct.NetworkTypeId = 1
        netAcct.UserId = (value.User?.Id)!
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
            //_mgr?.invokeServiceCall(ServiceConstants.SERVICE_KEY, serviceDefinition: UserFacadeServiceDefinition.LOGIN_BY_EMAIL , args: "test@test.com", "Password1")
            _mgr?.invokeServiceCall(ServiceConstants.SERVICE_KEY, serviceDefinition: ActivityFacadeServiceDefinition.GET_ACTIVITY_CONFIGURATION_DATA)
            break
            
        case .singleParallelCall:
            //--------------------------------------
            // Parallel Single Call
            //--------------------------------------
            _mgr?.invokeServiceCall(ServiceConstants.SERVICE_KEY, serviceDefinition: UserFacadeServiceDefinition.LOGIN_BY_EMAIL , args: "test@test.com", "Ahhender7215")
            
            for i in startIdx..<max{
                _mgr?.invokeServiceCall(ServiceConstants.SERVICE_KEY, serviceDefinition: UserFacadeServiceDefinition.LOGIN_BY_EMAIL , args: String(counter) +  "test@test.com", "Password1")
                counter = i
            }
            break
            
        case .groupedCall:
            //--------------------------------------
            // Grouped Call
            //--------------------------------------
            var requestGroup:[AMFServiceRequest] = []
            //requestGroup.append(AMFServiceRequest(serviceConfigKey:ServiceConstants.SERVICE_KEY, serviceDefinition: ActivityFacadeServiceDefinition.GET_ACTIVITY_CONFIGURATION_DATA))
            requestGroup.append(AMFServiceRequest(serviceConfigKey:ServiceConstants.SERVICE_KEY, serviceDefinition: UserFacadeServiceDefinition.LOGIN_BY_EMAIL, args: "test@test.com", "Ahhender7215"))
            requestGroup.append(AMFServiceRequest(serviceConfigKey:ServiceConstants.SERVICE_KEY, serviceDefinition: ActivityFacadeServiceDefinition.GET_ALL_PROGRAMS))
            
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
            
        case ActivityFacadeServiceDefinition.GET_ACTIVITY_CONFIGURATION_DATA.resultNotificationId!:
            print("Received RESULT for:" + notification.notificationId)
            break
            
        case ActivityFacadeServiceDefinition.GET_ACTIVITY_CONFIGURATION_DATA.faultNotificationId!:
            print("Received FAULT for:" + notification.notificationId)
            
            break
        case UserFacadeServiceDefinition.LOGIN_BY_EMAIL.resultNotificationId!:
            print("Received RESULT for:" + notification.notificationId)
            break
            
        case UserFacadeServiceDefinition.LOGIN_BY_EMAIL.faultNotificationId!:
            print("Received FAULT for:" + notification.notificationId)
            
            break
            
        case GROUP_NOTIFICATION_TEST:
            
            for (resultKey, resultValue) in  (notification.resultMessageGroup)!   {
                print("Airport code: \(resultKey)")
            }
            // notification.resultMessageGroup?.index(forKey: ActivityFacadeServiceDefinition.GET_ALL_PROGRAMS.value) as? [Any]
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



