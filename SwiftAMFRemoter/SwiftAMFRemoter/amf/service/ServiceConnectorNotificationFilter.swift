//
//  ServiceConnectorNotificationFilter.swift
//  SwiftAMFRemoter
//
//  Created by Tony Henderson on 6/28/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation

open class ServiceConnectorNotificationFilter{

    private var _notificationTypes:[String]?
    
    private var _notificationGroups:[String]?
    
    public init(_ notificationTypes:[String]?=nil,
               _ notificationGroups:[String]?=nil){
        
        self._notificationTypes = notificationTypes
        self._notificationGroups = notificationGroups
    }
 

    /**
     Returns notification filter types
     */
    var notificationTypes:[String]? { get { return self._notificationTypes } }
    
    /**
     Returns notification filter groups
     */
    var notificationGroups:[String]? { get {return self._notificationGroups } }
    
}
