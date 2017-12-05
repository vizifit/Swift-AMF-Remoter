//
//  BaseResult.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-29-2017 23:39.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( BaseResult ) open class BaseResult  : BasicObject{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Base.BaseResult"
  
        
    }

    

	public var SessionContextKey:String = String()

	public var ReturnType:String = String()

	public var HasContext:Bool = false

	public var Exception:VzServiceError?
}
