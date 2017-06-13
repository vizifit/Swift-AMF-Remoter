//
//  VzActivityItemListAssignment.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 6-1-2017 8:27.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 

@objc( VzActivityItemListAssignment ) open class VzActivityItemListAssignment  : EntityBase{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Activity.VzActivityItemListAssignment"
  
        
    }

    

	public var ItemOrder:Int = -1

	public var ActivityItemList:VzActivityItemList = VzActivityItemList()

	public var ActivityItemListId:Int = -1

	public var ActivityItem:VzActivityItem = VzActivityItem()

	public var ActivityItemId:Int = -1
}
