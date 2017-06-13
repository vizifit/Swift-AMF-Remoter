//
//  EntityBase.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 6-1-2017 8:27.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 

@objc( EntityBase ) open class EntityBase  : BasicObject{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Base.EntityBase"
  
        
    }

    

	public var Id:Int = -1

	public var ItemGuid:Any? = nil

	public var CreatedDateUtc:Date = Date()

	public var LastModifiedDateUtc:Date = Date()

	public var CreatedBy:Int = -1

	public var ModifiedBy:Int = -1

	public var Exception:VzServiceError = VzServiceError()

	public var CreatedDate:Date = Date()

	public var LastModifiedDate:Date = Date()
}
