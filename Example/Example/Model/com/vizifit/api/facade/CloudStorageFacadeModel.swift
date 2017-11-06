//
//  CloudStorageFacadeModel.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-5-2017 1:6.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( CloudStorageFacadeModel ) open class CloudStorageFacadeModel  : BasicObject{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Facade.CloudStorageFacadeModel"
  
        
    }

    

	public var GetAllMediaAssetsByUserResult:[Any]?

	public var SaveMediaAssetByUserIdResult:VzMediaAsset?
}
