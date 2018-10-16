//
//  EntityBase.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-29-2017 23:39.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( EntityBase ) open class EntityBase  : BasicObject{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Base.EntityBase"
  
        
    }

    

	public var Id:Int = -1

	public var ItemGuid:Any?

	public var CreatedDateUtc:Date?

	public var LastModifiedDateUtc:Date?

	public var CreatedBy:Int = -1

	public var ModifiedBy:Int = -1

	public var Exception:VzServiceError?

	public var CreatedDate:Date?

	public var LastModifiedDate:Date?
}
