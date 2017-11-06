//
//  UserFacadeModel.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-5-2017 1:6.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( UserFacadeModel ) open class UserFacadeModel  : BasicObject{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Facade.UserFacadeModel"
  
        
    }

    

	public var CreateNetworkResult:UserContext?

	public var CreateUserByEmailResult:UserContext?

	public var CreateUserByNetworkResult:UserContext?

	public var GetAppConfigurationDataResult:ConfigurationData?

	public var GetBrandsResult:[Any]?

	public var GetExceptionResult:VzException?

	public var GetInstructorsResult:[Any]?

	public var GetNetworkTypesResult:[Any]?

	public var GetUserByEmailResult:UserContext?

	public var GetUserByIdResult:UserContext?

	public var GetUserTypesResult:[Any]?

	public var LoginByEmailResult:UserContext?

	public var LoginByNetworkResult:UserContext?

	public var NetworkUserExistsResult:Bool = false

	public var RemoveNetworkResult:UserContext?

	public var ResetPasswordResult:Bool = false

	public var UpdateNetworkResult:UserContext?

	public var UpdatePasswordResult:Bool = false

	public var UpdateProfileResult:UserContext?

	public var UpdateProfileImageByIdResult:UserContext?

	public var UpdateUserResult:UserContext?

	public var UserExistsResult:Bool = false

	public var UserExistsForNetworkResult:Bool = false
}
