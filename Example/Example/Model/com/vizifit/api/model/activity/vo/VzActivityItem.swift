//
//  VzActivityItem.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-29-2017 23:39.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( VzActivityItem ) open class VzActivityItem  : BaseMediaContent{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Activity.VzActivityItem"
  
        
    }

    

	public var ItemDuration:Int = -1

	public var ActivityItemThemeType:VzActivityItemThemeType?

	public var ActivityItemThemeTypeId:Int = -1
}
