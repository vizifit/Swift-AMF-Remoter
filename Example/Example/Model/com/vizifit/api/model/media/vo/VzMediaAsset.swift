//
//  VzMediaAsset.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 6-1-2017 8:27.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 

@objc( VzMediaAsset ) open class VzMediaAsset  : EntityBase{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Media.VzMediaAsset"
  
        
    }

    

	public var Description:String = String()

	public var Name:String = String()

	public var File:Any? = nil

	public var User:VzUser = VzUser()

	public var UserId:Int = -1

	public var MediaType:VzMediaAssetType = VzMediaAssetType()

	public var MediaTypeId:Int = -1

	public var MediaCategoryType:VzMediaCategoryType = VzMediaCategoryType()

	public var MediaCategoryTypeId:Int = -1

	public var MediaContentType:VzMediaContentType = VzMediaContentType()

	public var MediaContentTypeId:Int = -1
}
