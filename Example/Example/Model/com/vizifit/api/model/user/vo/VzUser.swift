//
//  VzUser.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-29-2017 23:39.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( VzUser ) open class VzUser  : EntityBase{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.User.VzUser"
  
        
    }

    

	public var FirstName:String = String()

	public var LastName:String = String()

	public var Username:String = String()

	public var Email:String = String()

	public var UserTypeId:Int = -1

	public var UserType:VzUserType?
}
