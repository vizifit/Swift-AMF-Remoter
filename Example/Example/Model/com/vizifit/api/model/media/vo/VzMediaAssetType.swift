//
//  VzMediaAssetType.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-5-2017 1:7.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( VzMediaAssetType ) open class VzMediaAssetType  : BaseContentType{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Media.VzMediaAssetType"
  
        
    }

    

	public var Width:Int = -1

	public var Height:Int = -1
}
