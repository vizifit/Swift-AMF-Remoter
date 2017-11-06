//
//  ActivityFacadeModel.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-5-2017 1:6.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( ActivityFacadeModel ) open class ActivityFacadeModel  : BasicObject{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Facade.ActivityFacadeModel"
  
        
    }

    

	public var AddUserProgramActivityScheduleResult:[Any]?

	public var GetActivityConfigurationDataResult:ActivityConfigurationData?

	public var GetActivityItemsByActivityIdResult:[Any]?

	public var GetActivityItemsByActivityItemListIdResult:[Any]?

	public var GetAllActivitiesResult:[Any]?

	public var GetAllActivityItemsResult:[Any]?

	public var GetAllActivitySchedulesResult:[Any]?

	public var GetAllProgramActivitiesResult:[Any]?

	public var GetAllProgramsResult:[Any]?

	public var GetProgramActivitiesByProgramIdResult:[Any]?

	public var GetUserProgramActivityScheduleResult:[Any]?

	public var GetUserProgramsByUserIdResult:[Any]?

	public var UpdateUserProgramActivityScheduleResult:[Any]?
}
