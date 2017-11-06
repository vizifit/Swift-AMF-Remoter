//
//  BaseScheduleItem.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-5-2017 1:7.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( BaseScheduleItem ) open class BaseScheduleItem  : EntityBase{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Base.BaseScheduleItem"
  
        
    }

    

	public var ExplicitDate:Any?

	public var ScheduleDayType:VzScheduleDayType?

	public var ScheduleDayTypeId:Int = -1

	public var ScheduleTimeType:VzScheduleTimeType?

	public var ScheduleTimeTypeId:Int = -1
}
