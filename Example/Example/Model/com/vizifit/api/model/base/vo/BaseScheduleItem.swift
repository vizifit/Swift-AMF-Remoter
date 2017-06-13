//
//  BaseScheduleItem.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 6-1-2017 8:27.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 

@objc( BaseScheduleItem ) open class BaseScheduleItem  : EntityBase{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Base.BaseScheduleItem"
  
        
    }

    

	public var ExplicitDate:Any? = nil

	public var ScheduleDayType:VzScheduleDayType = VzScheduleDayType()

	public var ScheduleDayTypeId:Int = -1

	public var ScheduleTimeType:VzScheduleTimeType = VzScheduleTimeType()

	public var ScheduleTimeTypeId:Int = -1
}
