//
//  IPendingServiceCall.swift
//  SwiftAMFManager
//
//  Created by Tony Henderson on 1/2/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation

public protocol IPendingServiceCall : IServiceCall {
    
    
    /// <summary>
    /// Gets or sets the service call result.
    /// </summary>
    var result:AnyObject {get set}
    /// <summary>
    /// Registers callback object that implements IPendingServiceCallback interface.
    /// </summary>
    /// <param name="callback"></param>
    func registerCallback(_ callback:IPendingServiceCallback )
    /// <summary>
    /// Unregisters callback object that implements IPendingServiceCallback interface.
    /// </summary>
    /// <param name="callback"></param>
    func unregisterCallback(_ callback:IPendingServiceCallback )
    /// <summary>
    /// Returns list of callback objects that implements IPendingServiceCallback.
    /// </summary>
    /// <returns></returns>
    func getCallbacks()->[IPendingServiceCallback]
    
}
