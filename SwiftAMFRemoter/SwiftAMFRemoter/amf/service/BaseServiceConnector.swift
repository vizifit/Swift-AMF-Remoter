//
//  ServiceConnector.swift
//  SwiftAMFRemoter
//
//  Created by Tony Henderson on 6/28/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation

open class BaseServiceConnector: IServiceConnector{
    
    public init(){
        
        self._connectorId = UUID().uuidString // "D" - xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx (32 digits separated by hyphens)
        
        registerConnector(self)
    }
    
    public init(notificationFilter:ServiceConnectorNotificationFilter){
        
        self._connectorId = UUID().uuidString // "D" - xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx (32 digits separated by hyphens)
        self._connectorNotificationFilter = notificationFilter
        
        registerConnector(self, withNotificationFilter: notificationFilter)
    }

    
    private var _connectorId:String
    
    private var _connectorNotificationFilter:ServiceConnectorNotificationFilter? = nil
    
    
    open func registerConnector(_ connector:IServiceConnector){
        
        RemoteServiceManager.sharedInstance.registerServiceConnector(connector)
    }
    
    open func registerConnector(_ connector:IServiceConnector, withNotificationFilter:ServiceConnectorNotificationFilter){
        
        // Set filter
        var localConnector = connector
        localConnector.connectorNotificationFilter = withNotificationFilter
        
        RemoteServiceManager.sharedInstance.registerServiceConnector(localConnector)
    }
    
    open func unRegisterConnector(_ connectorId:String){
        RemoteServiceManager.sharedInstance.unRegisterServiceConnector(connectorId)
    }
    
    open func unRegisterConnector(_ connector:IServiceConnector){
        RemoteServiceManager.sharedInstance.unRegisterServiceConnector(connector)
    }
    
    open func onServiceNotification(_ notification:IServiceConnectorNotification){
        
        // Override and do something
    }
    
    /**
     Gets unique Id of connector
     */
    open var connectorId:String { get { return self.connectorId} }
    
    /**
     Gets/Sets service connector notification filter
     */
    open var connectorNotificationFilter: ServiceConnectorNotificationFilter? {
        get { return self._connectorNotificationFilter}
        set { self._connectorNotificationFilter = newValue}
    }
    
    
    /**
     IDictionaryItem protocol methods
     */
    open var key: String { get{ return self._connectorId } }
    
    
    open var isUpdateable: Bool { get{ return true } }
    
    
}
