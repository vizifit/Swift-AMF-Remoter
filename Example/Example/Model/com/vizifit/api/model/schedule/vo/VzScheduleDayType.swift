//
//  VzScheduleDayType.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 6-1-2017 8:27.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 

@objc( VzScheduleDayType ) open class VzScheduleDayType  : BaseContentType{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Schedule.VzScheduleDayType"
  
        
    }

    

	public var dayOfWeek:Int = -1
}
