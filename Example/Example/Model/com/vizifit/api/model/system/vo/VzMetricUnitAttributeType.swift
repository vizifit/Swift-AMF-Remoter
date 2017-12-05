//
//  VzMetricUnitAttributeType.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-29-2017 23:39.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( VzMetricUnitAttributeType ) open class VzMetricUnitAttributeType  : BaseContentType{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.System.VzMetricUnitAttributeType"
  
        
    }

    

	public var MetricUnitType:VzMetricUnitType?

	public var MetricUnitTypeId:Int = -1
}
