
//

//  SwiftAMFRemoter
//
//  Created by Tony Henderson on 5/16/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
 
class ActivityFacadeServiceDefinition : BaseRemoteServiceDefinition
{
// MARK: Service method definitions
	
	/**

GetActivityConfigurationData Service method

Arguments:
 none: There are no parameters for this service.

Service Returns: Please refer to services for return type
*/
open static let  GET_ACTIVITY_CONFIGURATION_DATA:ActivityFacadeServiceDefinition = ActivityFacadeServiceDefinition("GET_ACTIVITY_CONFIGURATION_DATA","GetActivityConfigurationData","com.vizifit.API.Facade.ActivityFacade")

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
 
