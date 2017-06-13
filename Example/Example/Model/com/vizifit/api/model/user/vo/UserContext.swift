//
//  UserContext.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 6-1-2017 8:27.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 

@objc( UserContext ) open class UserContext  : BasicObject{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.User.UserContext"
  
        
    }

    

	public var User:VzUser = VzUser()

	public var Profile:VzProfile = VzProfile()

	public var Networks:[Any]? = nil

	public var Account:VzAccount = VzAccount()

	public var Membership:VzBrandMembership = VzBrandMembership()

	public var Session:VzSession = VzSession()

	public var Exception:VzServiceError = VzServiceError()
}
