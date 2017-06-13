//
//  VzScheduleTimeType.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 6-1-2017 8:27.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 

@objc( VzScheduleTimeType ) open class VzScheduleTimeType  : BaseContentType{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Schedule.VzScheduleTimeType"
  
        
    }

    

	public var minutes:Int = -1
}
