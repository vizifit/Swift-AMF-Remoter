//
//  IServiceCall.swift
//  SwiftAMFManager
//
//  Created by Tony Henderson on 1/2/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation


public protocol IServiceCall {
    
    
    /// <summary>
    /// Gets a value indicating if the call was successful or not.
    /// </summary>
    var isSuccess:Bool { get}
    /// <summary>
    /// Gets service method name.
    /// </summary>
    var serviceMethodName:String { get }
    /// <summary>
    /// Gets service name.
    /// </summary>
    var serviceName:String { get }
    /// <summary>
    /// Gets array of service method arguments.
    /// </summary>
    var arguments:[Any]? { get }
    /// <summary>
    /// Gets or sets service call status.
    /// </summary>
    var status:UInt8 { get set }  // UInt8 = Byte
    /// <summary>
    /// Get or sets service call exception.
    /// </summary>
    //Exception Exception { get;set;}
}
