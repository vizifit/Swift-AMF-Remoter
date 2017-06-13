//
//  ViewController.swift
//  Example
//
//  Created by Tony Henderson on 6/7/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import UIKit
import SwiftAMFRemoter

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private var  _before:Double = 0
    private var _after:Double = 0
    
    let mgr = SwiftAMFRemoterManager.sharedInstance

    
    func onRemoteServiceEvent(_ notification: Notification) {
        
        do {
            for (key,val) in (notification.userInfo)! {
                let val_str = "\(key)"
                
                
                print(key)
                if val_str == "event" {
                    let returnEvent:Event =  val as! Event
                    let message = returnEvent.data as! AMFMessage
                    
                    let result = try message.getResult()
                    
                    if((result.1 as? ASObject) != nil){
                        
                        print("ERROR")
                        print("------------------------")
                        print(((result.1 as? ErrorMessage)?.faultCode)! + " " + ((result.1 as? ErrorMessage)?.faultString)!)
                        return
                    }
                    
                    //PunchJunkieModel.sharedInstance.userFacadeModel.LoginByEmailResult = (result.1 as? UserContext)!
                    
                    print("SUCCESS")
                    print("------------------------")
                    print(result)
                    //remoteVideoURL = val
                    break
                }
            }
            
            _after = Date().timeIntervalSince1970
            
            print (String(format: "%.2f Seconds", (_after-_before)))
        }
        catch let e as Error {
            print(e.localizedDescription)
        }
        
    }

    @IBAction func callAmfSimpleMethod(_ sender: AnyObject) {
        
        
        
        
        _before = Date().timeIntervalSince1970
        
        let mgr = SwiftAMFRemoterManager.sharedInstance
        
        DataTypeInitializer.registerClassAliases()
        
        mgr.addServiceConfiguration(RemoteServiceConfiguration(key: ServiceConstants.SERVICE_KEY,
                                                               destination: "fluorine",
                                                               endpoint: "http://vizifitdev.cloudapp.net/Gateway.aspx",
                                                               securityPolicyUrl: "securityPolicyUrl",
                                                               source: "ServiceLibrary.MyDataService",
                                                               timeout: 3000,
                                                               modalWait: true,
                                                               isUpdateable: false))
        
        mgr.addEventListener("test", selector: #selector(ViewController.onRemoteServiceEvent(_:)), observer: self)
        
        
//        var values = self.form.values(includeHidden: true)
//        let email = values["txtEmail"]
//        let password = values["txtPassword"]
        
        //mgr.invokeServiceCall(ServiceConstants.SERVICE_KEY, serviceDefinition: UserFacadeServiceDefinition.LOGIN_BY_EMAIL , args: email!, password!)
        
        let max = 10
        var counter=0
        var startIdx = 0
        
        mgr.invokeServiceCall(ServiceConstants.SERVICE_KEY, serviceDefinition: UserFacadeServiceDefinition.LOGIN_BY_EMAIL , args: "test@test.com", "Ahhender7215")
        
//        for i in startIdx..<max{
//            mgr.invokeServiceCall(ServiceConstants.SERVICE_KEY, serviceDefinition: UserFacadeServiceDefinition.LOGIN_BY_EMAIL , args: String(counter) +  "test@test.com", "Ahhender7215")
//            
//
//            counter = i
//        }

        
        _after = Date().timeIntervalSince1970
        
        
        
        
    }

}

