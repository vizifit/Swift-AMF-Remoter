//
//  UserFacadeManifest.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-29-2017 23:39.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( UserFacadeManifest ) open class UserFacadeManifest  : BasicObject{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Facade.UserFacadeManifest"
  
        
    }

    

	public var configurationData:ConfigurationData?

	public var vzProfile:VzProfile?

	public var vzSession:VzSession?

	public var userContext:UserContext?

	public var vzBrand:VzBrand?

	public var vzUserType:VzUserType?

	public var vzNetworkType:VzNetworkType?
}
