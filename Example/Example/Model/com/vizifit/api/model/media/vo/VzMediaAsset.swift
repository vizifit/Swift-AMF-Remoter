//
//  VzMediaAsset.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-5-2017 1:7.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( VzMediaAsset ) open class VzMediaAsset  : EntityBase{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Media.VzMediaAsset"
  
        
    }

    

	public var Description:String = String()

	public var Name:String = String()

	public var File:Any?

	public var User:VzUser?

	public var UserId:Int = -1

	public var MediaType:VzMediaAssetType?

	public var MediaTypeId:Int = -1

	public var MediaCategoryType:VzMediaCategoryType?

	public var MediaCategoryTypeId:Int = -1

	public var MediaContentType:VzMediaContentType?

	public var MediaContentTypeId:Int = -1
}
