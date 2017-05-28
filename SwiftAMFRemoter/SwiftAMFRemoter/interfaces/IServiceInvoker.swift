//
//  IServiceInvoker.swift
//  SwiftAMFManager
//
//  Created by Tony Henderson on 1/2/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation


public protocol IServiceInvoker {
    
    /// <summary>
    /// Execute the passed service call in the given scope.  This looks up the
    /// handler for the call in the scope and the context of the scope.
    /// </summary>
    /// <param name="call">The call to invoke.</param>
    /// <param name="scope">The scope to search for a handler.</param>
    /// <returns><code>true</code> if the call was performed, otherwise <code>false</code>.</returns>
    //func invoke(call:IServiceCall, IScope scope)->Bool
    
    /// <summary>
    /// Execute the passed service call in the given object.
    /// </summary>
    /// <param name="call">The call to invoke.</param>
    /// <param name="service">The service to use.</param>
    /// <returns><code>true</code> if the call was performed, otherwise <code>false</code>.</returns>
    func invoke( _ call:IServiceCall,  service:AnyObject)->Bool
    
}
