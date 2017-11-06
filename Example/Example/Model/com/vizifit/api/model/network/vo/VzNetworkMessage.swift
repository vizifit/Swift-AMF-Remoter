//
//  VzNetworkMessage.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-5-2017 1:7.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( VzNetworkMessage ) open class VzNetworkMessage  : EntityBase{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Network.VzNetworkMessage"
  
        
    }

    

	public var MessageSent:Date?

	public var MessageContent:String = String()

	public var MessageDetails:String = String()

	public var NetworkAccountId:Int = -1

	public var NetworkAccount:VzNetworkAccount?

	public var NetworkMessageTypeId:Int = -1

	public var NetworkMessageType:VzNetworkMessageType?
}
