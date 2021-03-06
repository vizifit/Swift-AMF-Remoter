//
//  ServiceConnector.swift
//  SwiftAMFRemoter
//
//  Created by Tony Henderson on 6/28/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation

open class BaseServiceConnector: IServiceConnectorView{
    
    public init(){
        
        self._connectorId = UUID().uuidString // "D" - xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx (32 digits separated by hyphens)
        self._rsmgr = RemoteServiceManager.getInstance({ RemoteServiceManager() })
        
        registerServiceConnector(self)
    }
 
 
    private var _rsmgr:IRemoteServiceManager
    
    private var _connectorId:String
    
    open func registerServiceConnector(_ connector:IServiceConnectorView){
        remoteServiceManager.registerServiceConnector(connector)
    }
  
    open func removeServiceConnector(_ connectorId:String){
        remoteServiceManager.removeServiceConnector(connectorId)
    }
  
    open func getServiceConnector(_ connectorId:String)->IServiceConnectorView?{
        return remoteServiceManager.getServiceConnector(connectorId)
    }
    
    open func hasServiceConnector(_ connectorId:String) -> Bool{
        return  remoteServiceManager.hasServiceConnector(connectorId)
    }
    
    
    open func handleServiceNotification(_ notification:IServiceConnectorNotification){
        
        // Override and do something
    }
    
    /**
     List the `INotification` names this
     `Mediator` is interested in being notified of.
     
     - returns: Array the list of `INotification` names
     */
    open func listNotificationInterests() -> [String] {
        return []
    }
    
    open var remoteServiceManager:IRemoteServiceManager { get { return self._rsmgr} }

    /**
     Gets unique Id of connector
     */
    open var connectorId:String { get { return self._connectorId} }
    
    
}
