//
//  IServiceHandlerProvider.swift
//  SwiftAMFManager
//
//  Created by Tony Henderson on 1/2/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation

public protocol IServiceHandlerProvider{
    
    /// <summary>
    /// Registers an object that provides methods which can be called from a client.
    /// </summary>
    /// <param name="name">The name of the handler.</param>
    /// <param name="handler">The handler object.</param>
    func registerServiceHandler( _ name:String,  handler:AnyObject)
    /// <summary>
    /// Unregisters service handler.
    /// </summary>
    /// <param name="name">The name of the handler.</param>
    func unregisterServiceHandler(_ name:String)
    /// <summary>
    /// Returns a previously registered service handler.
    /// </summary>
    /// <param name="name">The name of the handler to return.</param>
    /// <returns>The previously registered handler.</returns>
    func getServiceHandler(_ name:String)->AnyObject
    /// <summary>
    /// Gets a list of registered service handler names.
    /// </summary>
    /// <returns>The names of the registered handlers.</returns>
    func getServiceHandlerNames()->[String]
}
