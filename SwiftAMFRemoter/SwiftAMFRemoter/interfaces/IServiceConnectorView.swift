//
//  IServiceConnectorView.swift
//  SwiftAMFRemoter
//
//  Created by Tony Henderson on 7/17/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation


public protocol IServiceConnectorView : IServiceConnector
{
    
    func handleServiceNotification(_ notification:IServiceConnectorNotification)
    
    func listNotificationInterests() -> [String]
    
    /**
     Gets unique Id of connector
     */
    var connectorId:String { get}
     
    
    /**
     NOTE: Might not need
     */
    //func onRegister()

}

