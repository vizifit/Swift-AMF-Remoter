//
//  ActivityConfigurationData.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 6-1-2017 8:27.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 

@objc( ActivityConfigurationData ) open class ActivityConfigurationData  : BasicObject{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Activity.ActivityConfigurationData"
  
        
    }

    

	public var ActivityAttributeTypes:[Any]? = nil

	public var ActivityEquipmentTypes:[Any]? = nil

	public var ActivityGoalTypes:[Any]? = nil

	public var ActivityItemThemeTypes:[Any]? = nil

	public var ActivityLevelTypes:[Any]? = nil

	public var ActivityThemeTypes:[Any]? = nil

	public var ActivityTypes:[Any]? = nil

	public var ScheduleDayTypes:[Any]? = nil

	public var ScheduleTimeTypes:[Any]? = nil
}
