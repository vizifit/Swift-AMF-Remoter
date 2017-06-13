//
//  VzActivityItem.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 6-1-2017 8:27.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 

@objc( VzActivityItem ) open class VzActivityItem  : BaseMediaContent{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Activity.VzActivityItem"
  
        
    }

    

	public var ItemDuration:Int = -1

	public var ActivityItemThemeType:VzActivityItemThemeType = VzActivityItemThemeType()

	public var ActivityItemThemeTypeId:Int = -1
}
