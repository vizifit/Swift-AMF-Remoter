//
//  VzNetworkRelationship.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 6-1-2017 8:27.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 

@objc( VzNetworkRelationship ) open class VzNetworkRelationship  : EntityBase{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Network.VzNetworkRelationship"
  
        
    }

    

	public var NetworkAccountId:Int = -1

	public var RelatedToNetworkAccountId:Int = -1

	public var NetworkRelationshipTypeId:Int = -1

	public var NetworkAccount:VzNetworkAccount = VzNetworkAccount()

	public var NetworkRelationshipType:VzNetworkRelationshipType = VzNetworkRelationshipType()
}
