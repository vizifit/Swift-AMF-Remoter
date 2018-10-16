//
//  ActivityFacadeManifest.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-29-2017 23:39.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( ActivityFacadeManifest ) open class ActivityFacadeManifest  : BasicObject{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Facade.ActivityFacadeManifest"
  
        
    }

    

	public var vzNmScheduledUserProgramActivity:VzNmScheduledUserProgramActivity?

	public var vzActivityItemListAssignment:VzActivityItemListAssignment?

	public var vzActivityScheduleItem:VzActivityScheduleItem?

	public var activityConfigurationData:ActivityConfigurationData?

	public var vzProgramActivityAssignment:VzProgramActivityAssignment?

	public var vzActivity:VzActivity?

	public var vzProgram:VzProgram?

	public var vzUserProgram:VzUserProgram?
}
