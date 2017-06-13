//
//  UserFacadeModel.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 6-1-2017 8:27.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 

@objc( UserFacadeModel ) open class UserFacadeModel  : BasicObject{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Facade.UserFacadeModel"
  
        
    }

    

	public var CreateNetworkResult:UserContext = UserContext()

	public var CreateUserByEmailResult:UserContext = UserContext()

	public var CreateUserByNetworkResult:UserContext = UserContext()

	public var GetAppConfigurationDataResult:ConfigurationData = ConfigurationData()

	public var GetBrandsResult:[Any]? = nil

	public var GetExceptionResult:VzException = VzException()

	public var GetInstructorsResult:[Any]? = nil

	public var GetNetworkTypesResult:[Any]? = nil

	public var GetUserByEmailResult:UserContext = UserContext()

	public var GetUserByIdResult:UserContext = UserContext()

	public var GetUserTypesResult:[Any]? = nil

	public var LoginByEmailResult:UserContext = UserContext()

	public var LoginByNetworkResult:UserContext = UserContext()

	public var NetworkUserExistsResult:Bool = false

	public var RemoveNetworkResult:UserContext = UserContext()

	public var ResetPasswordResult:Bool = false

	public var UpdateNetworkResult:UserContext = UserContext()

	public var UpdatePasswordResult:Bool = false

	public var UpdateProfileResult:UserContext = UserContext()

	public var UpdateUserResult:UserContext = UserContext()

	public var UserExistsResult:Bool = false
}
