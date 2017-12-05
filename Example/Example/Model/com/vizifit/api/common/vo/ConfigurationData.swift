//
//  ConfigurationData.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-29-2017 23:39.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( ConfigurationData ) open class ConfigurationData  : BasicObject{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Common.ConfigurationData"
  
        
    }

    

	public var BrandTypes:[Any]?

	public var NetworkTypes:[Any]?

	public var UserTypes:[Any]?

	public var MediaAssetTypes:[Any]?

	public var MediaContentTypes:[Any]?
}
