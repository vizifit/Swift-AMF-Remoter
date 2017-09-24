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
    
    open func handleServiceNotification(_ notification: IServiceConnectorNotification) {
     
        print("NotificationID: " + notification.notificationId)
        
        switch(notification.notificationId){
            
        case UserFacadeServiceDefinition.LOGIN_BY_EMAIL.resultNotificationId!:
            print("Received RESULT for:" + notification.notificationId)
            break
            
        case UserFacadeServiceDefinition.LOGIN_BY_EMAIL.faultNotificationId!:
            print("Received FAULT for:" + notification.notificationId)
            
            break
            
        default:
            print("Unregistered notification...")
            break
        }
    }

    open func listNotificationInterests() -> [String]{
        
        return [UserFacadeServiceDefinition.LOGIN_BY_EMAIL.resultNotificationId!,
                UserFacadeServiceDefinition.LOGIN_BY_EMAIL.faultNotificationId!]
    }

    private var _connectorId:String = ""
     
    
    /**
     Gets unique Id of connector
     */
    open var connectorId:String { get { return self._connectorId} }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    
    private var  _before:Double = 0
    private var _after:Double = 0
    private var _mgr:IRemoteServiceManager? = nil
    @IBAction func callAmfSimpleMethod(_ sender: AnyObject) {
        
        
        
        
        _before = Date().timeIntervalSince1970
        
        _mgr = UIViewController.getRemoteServiceManager()
        
        DataTypeInitializer.registerClassAliases()
        
        _mgr?.toggleDebugMode(true)
        
        _mgr?.addServiceConfiguration(RemoteServiceConfiguration(key: ServiceConstants.SERVICE_KEY,
                                                               destination: "fluorine",
                                                               endpoint: "http://vizifitdev.cloudapp.net/Gateway.aspx",
                                                               securityPolicyUrl: "securityPolicyUrl",
                                                               source: "ServiceLibrary.MyDataService",
                                                               timeout: 3000,
                                                               modalWait: true,
                                                               isUpdateable: false))
        
        //mgr.addEventListener(RemoteServiceManagerConstants.SERVICE_RESPONSE_NOTIFICATION, selector: #selector(ViewController.onRemoteServiceEvent(_:)), observer: self)
        
        
//        var values = self.form.values(includeHidden: true)
//        let email = values["txtEmail"]
//        let password = values["txtPassword"]
        
        //mgr.invokeServiceCall(ServiceConstants.SERVICE_KEY, serviceDefinition: UserFacadeServiceDefinition.LOGIN_BY_EMAIL , args: email!, password!)
        
        let max = 10
        var counter=0
        var startIdx = 0
        
//        let myPicture = UIImage(data: try! Data(contentsOf: URL(string:"http://i.stack.imgur.com/Xs4RX.jpg")!))!
//        
//        // ADD IMAGE METHOD
//        //let myThumb1 = myPicture.resized(withPercentage: 0.1)
//        let myThumb2 = myPicture.resizeWithWidth(width: 10.0)
//        let imageData:Data = UIImagePNGRepresentation(myThumb2!)! as Data
//        
//        AMFCoder.bypassUtf16Length = true
//        
//        self.updateUserProfileImage(filedata: imageData.base64EncodedString())
        
        // LOGIN METHOD
        _mgr?.invokeServiceCall(ServiceConstants.SERVICE_KEY, serviceDefinition: UserFacadeServiceDefinition.LOGIN_BY_EMAIL , args: "test@test.com", "Ahhender7215")
        
        
        
//        for i in startIdx..<max{
//            mgr.invokeServiceCall(ServiceConstants.SERVICE_KEY, serviceDefinition: UserFacadeServiceDefinition.LOGIN_BY_EMAIL , args: String(counter) +  "test@test.com", "Ahhender7215")
//            
//
//            counter = i
//        }

        
        _after = Date().timeIntervalSince1970
        
    }
    
    func updateUserProfileImage(filedata:String){
        
        print(filedata)
        let nonceToken = ""  // Not implemented yet
        
        let userId:Int = 1
        let typeId:Int = 3 // Thumbnail Need to get from Helper Utility
        let contentTypeId:Int = 1 // PNG Need to get from Helper Utility
        let name = "Profile Image Name" // PNG Need to get from Helper Utility
        let description = "Profile Image Description" // PNG Need to get from Helper Utility
        var filedata = filedata
        let blobContainerName = "profile" // Should come from enum or constants
        
        //print(filedata.endIndex)
        //let index = filedata.index(filedata.startIndex, offsetBy: 70000)
        //filedata = filedata.substring(to: index)
        //let metricEnum:UnitMetricEnum = UnitMetricEnum.Pounds
        _mgr?.invokeServiceCall(ServiceConstants.SERVICE_KEY, serviceDefinition: CloudStorageFacadeServiceDefinition.SAVE_MEDIA_ASSET_BY_USER_ID , args:nonceToken, userId, typeId, contentTypeId, name, description, filedata, blobContainerName)
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



