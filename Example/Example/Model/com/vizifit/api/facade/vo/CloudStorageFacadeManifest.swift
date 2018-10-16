//
//  CloudStorageFacadeManifest.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-29-2017 23:39.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( CloudStorageFacadeManifest ) open class CloudStorageFacadeManifest  : BasicObject{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Facade.CloudStorageFacadeManifest"
  
        
    }

    

	public var vzMediaAsset:VzMediaAsset?
}
