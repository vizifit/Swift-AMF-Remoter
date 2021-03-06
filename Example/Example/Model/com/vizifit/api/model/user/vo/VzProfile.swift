//
//  VzProfile.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-29-2017 23:39.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( VzProfile ) open class VzProfile  : BaseMedia{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.User.VzProfile"
  
        
    }

    

	public var DOB:Any?

	public var Gender:String = String()

	public var Height:Int = -1

	public var Weight:Int = -1

	public var Tagline:String = String()

	public var MetricUnitType:VzMetricUnitType?

	public var MetricUnitTypeId:Int = -1

	public var User:VzUser?

	public var UserId:Int = -1
}
