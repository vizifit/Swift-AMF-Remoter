//
//  VzNetworkRelationship.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-5-2017 1:7.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( VzNetworkRelationship ) open class VzNetworkRelationship  : EntityBase{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Network.VzNetworkRelationship"
  
        
    }

    

	public var NetworkAccountId:Int = -1

	public var RelatedToNetworkAccountId:Int = -1

	public var NetworkRelationshipTypeId:Int = -1

	public var NetworkAccount:VzNetworkAccount?

	public var NetworkRelationshipType:VzNetworkRelationshipType?
}
