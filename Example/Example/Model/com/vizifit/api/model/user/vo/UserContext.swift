//
//  UserContext.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-5-2017 1:7.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( UserContext ) open class UserContext  : BasicObject{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.User.UserContext"
  
        
    }

    

	public var User:VzUser?

	public var Profile:VzProfile?

	public var Networks:[Any]?

	public var Account:VzAccount?

	public var Membership:VzBrandMembership?

	public var Session:VzSession?

	public var Exception:VzServiceError?
}
