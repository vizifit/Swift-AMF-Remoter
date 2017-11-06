//
//  BaseContentType.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-5-2017 1:7.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( BaseContentType ) open class BaseContentType  : BaseContent{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Base.BaseContentType"
  
        
    }

    

	public var Code:String = String()
}
