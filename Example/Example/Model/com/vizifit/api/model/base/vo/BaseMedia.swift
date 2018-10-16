//
//  BaseMedia.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-29-2017 23:39.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( BaseMedia ) open class BaseMedia  : EntityBase{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Base.BaseMedia"
  
        
    }

    

	public var ThumbnailImageUrl:String = String()

	public var ImageUrl:String = String()
}
