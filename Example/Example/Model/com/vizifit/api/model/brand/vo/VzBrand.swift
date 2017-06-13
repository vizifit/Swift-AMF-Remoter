//
//  VzBrand.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 6-1-2017 8:27.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 

@objc( VzBrand ) open class VzBrand  : EntityBase{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Brand.VzBrand"
  
        
    }

    

	public var Name:String = String()

	public var Description:String = String()
}
