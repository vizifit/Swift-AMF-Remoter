//
//  VzNmScheduledUserProgramActivity.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-5-2017 1:7.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( VzNmScheduledUserProgramActivity ) open class VzNmScheduledUserProgramActivity  : VzNmUserProgramActivity{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Program.VzNmScheduledUserProgramActivity"
  
        
    }

    

	public var UserProgramActivityScheduleItemId:Int = -1

	public var ActivityScheduleItemId:Int = -1

	public var SchedDay:String = String()

	public var SchedDayOfWeek:Int = -1

	public var SchedTime:String = String()

	public var SchedTimeInMinutes:Int = -1
}
