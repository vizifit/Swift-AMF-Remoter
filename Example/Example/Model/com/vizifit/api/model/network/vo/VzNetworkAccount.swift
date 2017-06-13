//
//  VzNetworkAccount.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 6-1-2017 8:27.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 

@objc( VzNetworkAccount ) open class VzNetworkAccount  : EntityBase{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Network.VzNetworkAccount"
  
        
    }

    

	public var AuthToken:String = String()

	public var DateRegistered:Any? = nil

	public var DateRemoved:Any? = nil

	public var UserNetworkAccountId:String = String()

	public var NetworkMessages:[Any]? = nil

	public var NetworkRelationships:[Any]? = nil

	public var NetworkType:VzNetworkType = VzNetworkType()

	public var NetworkTypeId:Int = -1

	public var User:VzUser = VzUser()

	public var UserId:Int = -1
}
