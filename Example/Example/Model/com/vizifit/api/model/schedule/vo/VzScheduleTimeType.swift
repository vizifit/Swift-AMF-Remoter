//
//  VzScheduleTimeType.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-5-2017 1:7.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( VzScheduleTimeType ) open class VzScheduleTimeType  : BaseContentType{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Schedule.VzScheduleTimeType"
  
        
    }

    

	public var minutes:Int = -1
}
