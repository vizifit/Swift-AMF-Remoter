//
//  CloudStorageFacadeModel.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-29-2017 23:39.
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

    

	public var _generateDependenciesResult:CloudStorageFacadeManifest?

	public var GetAllMediaAssetsByUserResult:VzServiceResult?

	public var SaveMediaAssetByUserIdResult:VzServiceResult?
}
