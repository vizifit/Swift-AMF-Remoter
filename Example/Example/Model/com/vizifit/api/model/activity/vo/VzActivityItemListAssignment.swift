//
//  VzActivityItemListAssignment.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-5-2017 1:6.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( VzActivityItemListAssignment ) open class VzActivityItemListAssignment  : EntityBase{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Activity.VzActivityItemListAssignment"
  
        
    }

    

	public var ItemOrder:Int = -1

	public var ActivityItemList:VzActivityItemList?

	public var ActivityItemListId:Int = -1

	public var ActivityItem:VzActivityItem?

	public var ActivityItemId:Int = -1
}
