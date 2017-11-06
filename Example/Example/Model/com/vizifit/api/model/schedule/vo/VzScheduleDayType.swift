//
//  VzScheduleDayType.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-5-2017 1:7.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( VzScheduleDayType ) open class VzScheduleDayType  : BaseContentType{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Schedule.VzScheduleDayType"
  
        
    }

    

	public var dayOfWeek:Int = -1
}
