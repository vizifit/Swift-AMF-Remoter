//
//  VzBrandMembership.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 6-1-2017 8:27.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 

@objc( VzBrandMembership ) open class VzBrandMembership  : EntityBase{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Brand.VzBrandMembership"
  
        
    }

    

	public var IsLockedOut:Bool = false

	public var LastLoginDate:Any? = nil

	public var LastPasswordChange:Any? = nil

	public var LastLockoutDate:Any? = nil

	public var FailedPasswordAttemptCount:Int = -1

	public var FailedPasswordAttemptWindowStart:Int = -1

	public var UserId:Int = -1

	public var BrandId:Int = -1

	public var Brand:VzBrand = VzBrand()

	public var User:VzUser = VzUser()
}
