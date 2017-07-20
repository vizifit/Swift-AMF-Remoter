//
//  IGlobalObserver.swift
//  SwiftAMFRemoter
//
//  Created by Tony Henderson on 7/15/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation


public protocol IServiceConnectorObserver  {
    
    /**
     Set the notification method.
     
     The notification method should take one parameter of type `INotification`
     
     - parameter notifyMethod: the notification (callback) method of the interested object
     */
    var notifyMethod: ((_ notification: IServiceConnectorNotification) -> ())? { get set }
    
    /// Get or set the notification context (self) of the interested object.
    var notifyContext: AnyObject? { get set }
    
    /**
     Notify the interested object.
     
     - parameter notification: the `INotification` to pass to the interested object's notification method
     */
    func notifyObserver(_ notification: IServiceConnectorNotification)
    
    /**
     Compare the given object to the notificaiton context object.
     
     - parameter object: the object to compare.
     - returns: boolean indicating if the notification context and the object are the same.
     */
    func compareNotifyContext(_ object: AnyObject) -> Bool

}
