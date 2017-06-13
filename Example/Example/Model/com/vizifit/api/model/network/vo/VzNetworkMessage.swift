//
//  VzNetworkMessage.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 6-1-2017 8:27.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 

@objc( VzNetworkMessage ) open class VzNetworkMessage  : EntityBase{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Network.VzNetworkMessage"
  
        
    }

    

	public var MessageSent:Date = Date()

	public var MessageContent:String = String()

	public var MessageDetails:String = String()

	public var NetworkAccountId:Int = -1

	public var NetworkAccount:VzNetworkAccount = VzNetworkAccount()

	public var NetworkMessageTypeId:Int = -1

	public var NetworkMessageType:VzNetworkMessageType = VzNetworkMessageType()
}
