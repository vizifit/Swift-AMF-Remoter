//
//  IServiceNotifier.swift
//  SwiftAMFRemoter
//
//  Created by Tony Henderson on 6/17/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation

public protocol IServiceConnector 
{
    
    /**
     Register an `IServiceConnector` instance with the ServiceConnectorManager.
     
     - parameter connector: the IServiceConnector
     */
    func registerServiceConnector(_ connector:IServiceConnectorView)
    
    /**
     Register an `IServiceConnector` instance with the ServiceConnectorManager and notifications
     
     - parameter connector: the IServiceConnector
     - parameter withNotificationFilter: the notification filter
     */
    //func registerServiceConnector(_ connector:IServiceConnector, withNotificationFilter:ServiceConnectorNotificationFilter)
    
    /**
     Remove an `IServiceConnector` from the implementing class.
     
     - parameter connectorId: name of the `IServiceConnector` instance to be removed.
     */
    func removeServiceConnector(_ connectorId:String)
    
    /**
     Retrieve an `IServicdeConnector` from the implementing class.
     
     - parameter connectorId: the name of the `IMediator` instance to retrieve.
     - returns: the `IServiceConnector` instance previously registered with the given `connectorId`.
     */
    func getServiceConnector(_ connectorId:String)->IServiceConnectorView?
    
    /**
     Check if a Mediator is registered or not
     
     - parameter connectorId:
     - returns: whether a Connector is registered with the given `connectorId`.
     */
    func hasServiceConnector(_ connectorId:String) -> Bool
    

      
}
