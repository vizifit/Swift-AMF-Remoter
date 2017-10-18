//
//  INetConnection.swift
//  SwiftAMFManager
//
//  Created by Tony Henderson on 1/2/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation


public protocol INetConnection  {
    // protocol definition goe
    
    var key:String {get}

    
    func connect(_ command:String, params arguments:[AnyObject]?  )
    
    func close()
    
    func call( request:IMessage, serviceDefinition:IAMFServiceDefinition )
    
    func call( requestGroup:AMFServiceRequestGroup, requestMessages:[AMFServiceRequestMessage] )
   
    var connected:Bool {get}
    
    //var coder:IAMFCoder {get}
    //func write(messge:IRtmpEvent)
    //var connection:IConnection {get}
    
}
