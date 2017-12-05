//
//  VzServiceError.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-29-2017 23:39.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( VzServiceError ) open class VzServiceError  : BasicObject{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Common.VzServiceError"
  
        
    }

    

	public var Code:String = String()

	public var Name:String = String()

	public var Description:String = String()

	public var source:String = String()
}
