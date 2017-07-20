//
//  GlobalObserver.swift
//  SwiftAMFRemoter
//
//  Created by Tony Henderson on 7/15/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation

open class ServiceConnectorObserver: IServiceConnectorObserver {
    
    fileprivate var _notifyMethod: ((_ notification: IServiceConnectorNotification) -> ())?
    
    weak fileprivate var _notifyContext: AnyObject?
    
    /**
     Constructor.
     
     The notification method on the interested object should take
     one parameter of type `INotification`
     
     - parameter notifyMethod: the notification method of the interested object
     - parameter notifyContext: the notification context of the interested object
     */
    public init(notifyMethod: ((IServiceConnectorNotification) -> ())?, notifyContext: AnyObject?) {
        _notifyMethod = notifyMethod
        _notifyContext = notifyContext
    }
    
    /**
     Notify the interested object.
     
     - parameter notification: the `INotification` to pass to the interested object's notification method.
     */
    open func notifyObserver(_ notification: IServiceConnectorNotification) {
        self.notifyMethod?(notification)
    }
    
    /**
     Compare an object to the notification context.
     
     - parameter object: the object to compare
     - returns: boolean indicating if the object and the notification context are the same
     */
    open func compareNotifyContext(_ object: AnyObject) -> Bool {
        return object === _notifyContext
    }
    
    /// Get or set the notification method.
    open var notifyMethod: ((_ notification: IServiceConnectorNotification) -> ())? {
        get { return _notifyMethod }
        set { _notifyMethod = newValue }
    }
    
    /// Get or set the notification context.
    open var notifyContext: AnyObject? {
        get { return _notifyContext }
        set { _notifyContext = newValue }
    }
    
}
