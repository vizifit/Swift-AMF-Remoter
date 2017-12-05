//
//  UserFacadeModel.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-29-2017 23:39.
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

    

	public var _generateDependenciesResult:UserFacadeManifest?

	public var CreateNetworkResult:VzServiceResult?

	public var CreateUserByEmailResult:VzServiceResult?

	public var CreateUserByNetworkResult:VzServiceResult?

	public var GenerateSessionContextKeyResult:VzServiceResult?

	public var GenerateSessionNonceResult:VzServiceResult?

	public var GetAppConfigurationDataResult:VzServiceResult?

	public var GetAppConfigurationDataWithUserIdResult:VzServiceResult?

	public var GetBrandsResult:VzServiceResult?

	public var GetCurrentSessionResult:VzServiceResult?

	public var GetExceptionResult:VzException?

	public var GetInstructorsResult:VzServiceResult?

	public var GetNetworkTypesResult:VzServiceResult?

	public var GetUserByEmailResult:VzServiceResult?

	public var GetUserByEmailWithRequestorIdResult:VzServiceResult?

	public var GetUserByIdResult:VzServiceResult?

	public var GetUserTypesResult:VzServiceResult?

	public var LoginByEmailResult:VzServiceResult?

	public var LoginByNetworkResult:VzServiceResult?

	public var NetworkUserExistsResult:VzServiceResult?

	public var RemoveNetworkResult:VzServiceResult?

	public var ResetPasswordResult:VzServiceResult?

	public var ResetPasswordWithConfirmResult:VzServiceResult?

	public var UpdateNetworkResult:VzServiceResult?

	public var UpdatePasswordResult:VzServiceResult?

	public var UpdateProfileResult:VzServiceResult?

	public var UpdateProfileImageByIdResult:VzServiceResult?

	public var UpdateUserResult:VzServiceResult?

	public var UserExistsResult:VzServiceResult?

	public var UserExistsForNetworkResult:VzServiceResult?
}
