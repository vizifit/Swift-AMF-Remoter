//
//  INotificationConnector.swift
//  SwiftAMFRemoter
//
//  Created by Tony Henderson on 7/13/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation

public protocol IGlobalNotificationConnector:IDictionaryItem
{
    
    /**
     Register an `IServiceConnector` instance with the ServiceConnectorManager.
     
     - parameter connector: the IServiceConnector
     */
    func registerConnector(_ connector:IGlobalNotificationConnector)
    
    /**
     Register an `IServiceConnector` instance with the ServiceConnectorManager and notifications
     
     - parameter connector: the IServiceConnector
     - parameter withNotificationFilter: the notification filter
     */
    func registerConnector(_ connector:IGlobalNotificationConnector, withNotificationFilter:ServiceConnectorNotificationFilter)
    
    /**
     Remove an `IServiceConnector` from the implementing class.
     
     - parameter connectorName: name of the `IServiceConnector` instance to be removed.
     */
    func removeConnector(_ connectorName:String)
    
    /**
     Retrieve an `IServicdeConnector` from the implementing class.
     
     - parameter connectorName: the name of the `IMediator` instance to retrieve.
     - returns: the `IServiceConnector` instance previously registered with the given `connectorId`.
     */
    func retrieveConnector(_ connectorName:String)->IServiceConnector
    
    /**
     Check if a Connector is registered or not
     
     - parameter connectorName:
     - returns: whether a Connector is registered with the given `connectorId`.
     */
    func hasConnector(_ connectorName:String) -> Bool
    
    func handleGlobalNotification(_ notification:IGlobalNotification)
    
    func listNotificationInterests() -> [String]
    
    /**
     Gets unique Id of connector
     */
    var connectorName:String { get}
    
    var connectorNotificationFilter:ServiceConnectorNotificationFilter? { get set }
    
    /**
     NOTE: Might not need
     */
    func onRegister()
    
}
