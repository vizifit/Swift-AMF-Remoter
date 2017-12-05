//
//  ActivityConfigurationData.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-29-2017 23:39.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( ActivityConfigurationData ) open class ActivityConfigurationData  : BasicObject{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Activity.ActivityConfigurationData"
  
        
    }

    

	public var ActivityAttributeTypes:[Any]?

	public var ActivityEquipmentTypes:[Any]?

	public var ActivityGoalTypes:[Any]?

	public var ActivityItemThemeTypes:[Any]?

	public var ActivityLevelTypes:[Any]?

	public var ActivityThemeTypes:[Any]?

	public var ActivityTypes:[Any]?

	public var ScheduleDayTypes:[Any]?

	public var ScheduleTimeTypes:[Any]?

	public var ProgramStatusTypes:[Any]?

	public var ProgramCategoryTypes:[Any]?

	public var ProgramAccessTypes:[Any]?

	public var MetricUnitTypes:[Any]?

	public var MetricUnitAttributeTypes:[Any]?
}
