//
//  VzActivity.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 6-1-2017 8:27.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 

@objc( VzActivity ) open class VzActivity  : BaseMediaContent{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Activity.VzActivity"
  
        
    }

    

	public var ItemOrder:Int = -1

	public var ActivityHostUser:VzUser = VzUser()

	public var ActivityHostUserId:Int = -1

	public var ActivityItemList:VzActivityItemList = VzActivityItemList()

	public var ActivityItemListId:Int = -1

	public var ActivityLevelType:VzActivityLevelType = VzActivityLevelType()

	public var ActivityLevelTypeId:Int = -1

	public var ActivityThemeType:VzActivityThemeType = VzActivityThemeType()

	public var ActivityThemeTypeId:Int = -1

	public var ActivityType:VzActivityType = VzActivityType()

	public var ActivityTypeId:Int = -1
}
