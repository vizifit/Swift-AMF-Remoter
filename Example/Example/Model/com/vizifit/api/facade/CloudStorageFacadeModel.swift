//
//  CloudStorageFacadeModel.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 6-1-2017 8:27.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 

@objc( CloudStorageFacadeModel ) open class CloudStorageFacadeModel  : BasicObject{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Facade.CloudStorageFacadeModel"
  
        
    }

    

	public var GetAllMediaAssetsByUserResult:[Any]? = nil

	public var SaveMediaAssetByUserIdResult:VzMediaAsset = VzMediaAsset()
}
