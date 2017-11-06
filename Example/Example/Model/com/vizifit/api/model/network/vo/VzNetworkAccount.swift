//
//  VzNetworkAccount.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-5-2017 1:7.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( VzNetworkAccount ) open class VzNetworkAccount  : EntityBase{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Network.VzNetworkAccount"
  
        
    }

    

	public var AuthToken:String = String()

	public var DateRegistered:Any?

	public var DateRemoved:Any?

	public var UserNetworkAccountId:String = String()

	public var NetworkMessages:[Any]?

	public var NetworkRelationships:[Any]?

	public var NetworkType:VzNetworkType?

	public var NetworkTypeId:Int = -1

	public var User:VzUser?

	public var UserId:Int = -1
}
