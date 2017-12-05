//
//  BaseMediaContent.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-29-2017 23:39.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( BaseMediaContent ) open class BaseMediaContent  : BaseContent{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Base.BaseMediaContent"
  
        
    }

    

	public var ThumbnailImageUrl:String = String()

	public var ImageUrl:String = String()
}
