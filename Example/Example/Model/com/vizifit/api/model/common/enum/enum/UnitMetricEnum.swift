//
//  UnitMetricEnum.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 6-1-2017 8:27.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 

@objc( UnitMetricEnum ) open class UnitMetricEnum  : BasicObject{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Common.Enum.enum.UnitMetricEnum"
  
        
    }

    

	public static var Pounds:String = "Pounds"

	public static var Kilograms:String = "Kilograms"

	public static var Stones:String = "Stones"
}
