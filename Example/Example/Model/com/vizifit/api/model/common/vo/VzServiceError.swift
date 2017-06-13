//
//  VzServiceError.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 6-1-2017 8:27.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 

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
