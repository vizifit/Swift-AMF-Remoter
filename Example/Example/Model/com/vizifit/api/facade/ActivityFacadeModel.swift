//
//  ActivityFacadeModel.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-29-2017 23:39.
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

    

	public var _generateDependenciesResult:ActivityFacadeManifest?

	public var AddProgramResult:VzServiceResult?

	public var AddProgramWithImageResult:VzServiceResult?

	public var AddUserProgramActivityScheduleResult:VzServiceResult?

	public var GetActivityConfigurationDataResult:VzServiceResult?

	public var GetActivityItemsByActivityIdResult:VzServiceResult?

	public var GetActivityItemsByActivityItemListIdResult:VzServiceResult?

	public var GetAllActivitiesResult:VzServiceResult?

	public var GetAllActivityItemsResult:VzServiceResult?

	public var GetAllActivitySchedulesResult:VzServiceResult?

	public var GetAllProgramActivitiesResult:VzServiceResult?

	public var GetAllProgramsResult:VzServiceResult?

	public var GetProgramActivitiesByProgramIdResult:VzServiceResult?

	public var GetUserProgramActivityScheduleResult:VzServiceResult?

	public var GetUserProgramsByUserIdResult:VzServiceResult?

	public var UpdateUserProgramActivityScheduleResult:VzServiceResult?

	public var UpdateUserProgramActivityScheduleTestResult:VzServiceResult?
}
