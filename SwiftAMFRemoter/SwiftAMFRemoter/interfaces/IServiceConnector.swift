//
//  IServiceNotifier.swift
//  SwiftAMFRemoter
//
//  Created by Tony Henderson on 6/17/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation

public protocol IServiceConnector:IDictionaryItem
{
    
    
    func registerConnector(_ connector:IServiceConnector)
    
    func registerConnector(_ connector:IServiceConnector, withNotificationFilter:ServiceConnectorNotificationFilter)
    
    func unRegisterConnector(_ connectorId:String)
    
    func unRegisterConnector(_ connector:IServiceConnector)
    
    func onServiceNotification(_ notification:IServiceConnectorNotification)
    
    /**
     Gets unique Id of connector
     */
    var connectorId:String { get}
    
    var connectorNotificationFilter:ServiceConnectorNotificationFilter? { get set }

}
