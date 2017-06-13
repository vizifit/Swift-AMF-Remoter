//
//  ConfigurationData.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 6-1-2017 8:27.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 

@objc( ConfigurationData ) open class ConfigurationData  : BasicObject{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Common.ConfigurationData"
  
        
    }

    

	public var BrandTypes:[Any]? = nil

	public var NetworkTypes:[Any]? = nil

	public var UserTypes:[Any]? = nil

	public var MediaAssetTypes:[Any]? = nil

	public var MediaContentTypes:[Any]? = nil
}
