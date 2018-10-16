//
//  VzActivity.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-29-2017 23:39.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( VzActivity ) open class VzActivity  : BaseMediaContent{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Activity.VzActivity"
  
        
    }

    

	public var ItemOrder:Int = -1

	public var ActivityHostUser:VzUser?

	public var ActivityHostUserId:Int = -1

	public var ActivityItemList:VzActivityItemList?

	public var ActivityItemListId:Int = -1

	public var ActivityLevelType:VzActivityLevelType?

	public var ActivityLevelTypeId:Int = -1

	public var ActivityThemeType:VzActivityThemeType?

	public var ActivityThemeTypeId:Int = -1

	public var ActivityType:VzActivityType?

	public var ActivityTypeId:Int = -1
}
