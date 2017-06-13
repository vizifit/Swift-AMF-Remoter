//
//  ActivityFacadeModel.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 6-1-2017 8:27.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 

@objc( ActivityFacadeModel ) open class ActivityFacadeModel  : BasicObject{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Facade.ActivityFacadeModel"
  
        
    }

    

	public var GetActivityConfigurationDataResult:ActivityConfigurationData = ActivityConfigurationData()

	public var GetAllActivitiesResult:[Any]? = nil

	public var GetAllActivityItemsResult:[Any]? = nil

	public var GetAllActivitySchedulesResult:[Any]? = nil

	public var GetAllProgramActivitiesResult:[Any]? = nil

	public var GetAllProgramsResult:[Any]? = nil
}
