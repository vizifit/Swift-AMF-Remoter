//
//  VzBrandMembership.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-29-2017 23:39.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( VzBrandMembership ) open class VzBrandMembership  : EntityBase{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Brand.VzBrandMembership"
  
        
    }

    

	public var IsLockedOut:Bool = false

	public var LastLoginDate:Any?

	public var LastPasswordChange:Any?

	public var LastLockoutDate:Any?

	public var FailedPasswordAttemptCount:Int = -1

	public var FailedPasswordAttemptWindowStart:Int = -1

	public var UserId:Int = -1

	public var BrandId:Int = -1

	public var Brand:VzBrand?

	public var User:VzUser?
}
