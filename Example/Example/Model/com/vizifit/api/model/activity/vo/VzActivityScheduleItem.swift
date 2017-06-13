//
//  VzActivityScheduleItem.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 6-1-2017 8:27.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 

@objc( VzActivityScheduleItem ) open class VzActivityScheduleItem  : BaseScheduleItem{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Activity.VzActivityScheduleItem"
  
        
    }

    

	public var DisplayDayAndTime:String = String()

	public var Activity:VzActivity = VzActivity()

	public var ActivityId:Int = -1
}
