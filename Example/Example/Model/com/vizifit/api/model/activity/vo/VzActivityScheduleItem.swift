//
//  VzActivityScheduleItem.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-5-2017 1:7.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( VzActivityScheduleItem ) open class VzActivityScheduleItem  : BaseScheduleItem{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Activity.VzActivityScheduleItem"
  
        
    }

    

	public var DisplayDayAndTime:String = String()

	public var Activity:VzActivity?

	public var ActivityId:Int = -1
}
