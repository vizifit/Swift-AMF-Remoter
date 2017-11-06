//
//  UnitMetricEnum.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-5-2017 1:7.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( UnitMetricEnum ) open class UnitMetricEnum  : BasicObject{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Common.Enum.enum.UnitMetricEnum"
  
        
    }

    

	public static var Pounds:String = "Pounds"

	public static var Kilograms:String = "Kilograms"

	public static var Stones:String = "Stones"
}
