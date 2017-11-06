
//

//  SwiftAMFRemoter
//
//  Created by Tony Henderson on 5/16/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation
import SwiftAMFRemoter
//@testable import SwiftAMFRemoter
import SwiftAMFRemoter
 
class ActivityFacadeServiceDefinition : BaseRemoteServiceDefinition
{
// MARK: Service method definitions
	
	/**

AddUserProgramActivitySchedule Service method

Arguments:
(0) token: String
 (1) userProgramId: int
 (2) activityScheduleItemId: int

Service Returns: Please refer to services for return type
*/
open static let  ADD_USER_PROGRAM_ACTIVITY_SCHEDULE:ActivityFacadeServiceDefinition = ActivityFacadeServiceDefinition("ADD_USER_PROGRAM_ACTIVITY_SCHEDULE","AddUserProgramActivitySchedule","com.vizifit.API.Facade.ActivityFacade")

/**

GetActivityConfigurationData Service method

Arguments:
 none: There are no parameters for this service.

Service Returns: Please refer to services for return type
*/
open static let  GET_ACTIVITY_CONFIGURATION_DATA:ActivityFacadeServiceDefinition = ActivityFacadeServiceDefinition("GET_ACTIVITY_CONFIGURATION_DATA","GetActivityConfigurationData","com.vizifit.API.Facade.ActivityFacade")

/**

GetActivityItemsByActivityId Service method

Arguments:
(0) activityId: int

Service Returns: Please refer to services for return type
*/
open static let  GET_ACTIVITY_ITEMS_BY_ACTIVITY_ID:ActivityFacadeServiceDefinition = ActivityFacadeServiceDefinition("GET_ACTIVITY_ITEMS_BY_ACTIVITY_ID","GetActivityItemsByActivityId","com.vizifit.API.Facade.ActivityFacade")

/**

GetActivityItemsByActivityItemListId Service method

Arguments:
(0) activityItemListId: int

Service Returns: Please refer to services for return type
*/
open static let  GET_ACTIVITY_ITEMS_BY_ACTIVITY_ITEM_LIST_ID:ActivityFacadeServiceDefinition = ActivityFacadeServiceDefinition("GET_ACTIVITY_ITEMS_BY_ACTIVITY_ITEM_LIST_ID","GetActivityItemsByActivityItemListId","com.vizifit.API.Facade.ActivityFacade")

/**

GetAllActivities Service method

Arguments:
 none: There are no parameters for this service.

Service Returns: Please refer to services for return type
*/
open static let  GET_ALL_ACTIVITIES:ActivityFacadeServiceDefinition = ActivityFacadeServiceDefinition("GET_ALL_ACTIVITIES","GetAllActivities","com.vizifit.API.Facade.ActivityFacade")

/**

GetAllActivityItems Service method

Arguments:
 none: There are no parameters for this service.

Service Returns: Please refer to services for return type
*/
open static let  GET_ALL_ACTIVITY_ITEMS:ActivityFacadeServiceDefinition = ActivityFacadeServiceDefinition("GET_ALL_ACTIVITY_ITEMS","GetAllActivityItems","com.vizifit.API.Facade.ActivityFacade")

/**

GetAllActivitySchedules Service method

Arguments:
 none: There are no parameters for this service.

Service Returns: Please refer to services for return type
*/
open static let  GET_ALL_ACTIVITY_SCHEDULES:ActivityFacadeServiceDefinition = ActivityFacadeServiceDefinition("GET_ALL_ACTIVITY_SCHEDULES","GetAllActivitySchedules","com.vizifit.API.Facade.ActivityFacade")

/**

GetAllProgramActivities Service method

Arguments:
 none: There are no parameters for this service.

Service Returns: Please refer to services for return type
*/
open static let  GET_ALL_PROGRAM_ACTIVITIES:ActivityFacadeServiceDefinition = ActivityFacadeServiceDefinition("GET_ALL_PROGRAM_ACTIVITIES","GetAllProgramActivities","com.vizifit.API.Facade.ActivityFacade")

/**

GetAllPrograms Service method

Arguments:
 none: There are no parameters for this service.

Service Returns: Please refer to services for return type
*/
open static let  GET_ALL_PROGRAMS:ActivityFacadeServiceDefinition = ActivityFacadeServiceDefinition("GET_ALL_PROGRAMS","GetAllPrograms","com.vizifit.API.Facade.ActivityFacade")

/**

GetProgramActivitiesByProgramId Service method

Arguments:
(0) token: String
 (1) programId: int

Service Returns: Please refer to services for return type
*/
open static let  GET_PROGRAM_ACTIVITIES_BY_PROGRAM_ID:ActivityFacadeServiceDefinition = ActivityFacadeServiceDefinition("GET_PROGRAM_ACTIVITIES_BY_PROGRAM_ID","GetProgramActivitiesByProgramId","com.vizifit.API.Facade.ActivityFacade")

/**

GetUserProgramActivitySchedule Service method

Arguments:
(0) token: String
 (1) userId: int
 (2) programId: int

Service Returns: Please refer to services for return type
*/
open static let  GET_USER_PROGRAM_ACTIVITY_SCHEDULE:ActivityFacadeServiceDefinition = ActivityFacadeServiceDefinition("GET_USER_PROGRAM_ACTIVITY_SCHEDULE","GetUserProgramActivitySchedule","com.vizifit.API.Facade.ActivityFacade")

/**

GetUserProgramsByUserId Service method

Arguments:
(0) token: String
 (1) userId: int

Service Returns: Please refer to services for return type
*/
open static let  GET_USER_PROGRAMS_BY_USER_ID:ActivityFacadeServiceDefinition = ActivityFacadeServiceDefinition("GET_USER_PROGRAMS_BY_USER_ID","GetUserProgramsByUserId","com.vizifit.API.Facade.ActivityFacade")

/**

UpdateUserProgramActivitySchedule Service method

Arguments:
(0) userProgramActivityScheduleId: int
 (1) activityScheduleItemId: Number

Service Returns: Please refer to services for return type
*/
open static let  UPDATE_USER_PROGRAM_ACTIVITY_SCHEDULE:ActivityFacadeServiceDefinition = ActivityFacadeServiceDefinition("UPDATE_USER_PROGRAM_ACTIVITY_SCHEDULE","UpdateUserProgramActivitySchedule","com.vizifit.API.Facade.ActivityFacade")


 
		
	override init(_ value:String,
                  _ methodName:String,
                  _ source:String?=nil,
                  _ modalWaitMessage:String="Loading...",
                  _ modalWait:Bool=true,
                  _ destination:String?=nil,
                  _ endpoint:String?=nil,
                  _ resultNotificationId:String?=nil,
                  _ faultNotificationId:String?=nil,
                  _ alwaysSendNotification:Bool=true) {
        
       	super.init(value,
                   methodName,
                   source,
                   modalWaitMessage,
                   modalWait,
                   destination,
                   endpoint,
                   resultNotificationId,
                   faultNotificationId,
                   alwaysSendNotification)
    }

}
 
