//
//  VzException.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-5-2017 1:6.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( VzException ) open class VzException  : BasicObject{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Common.VzException"
  
        
    }

    

	public var Title:String = String()

	public var Description:String = String()

	public var Message:String = String()

	public var Source:String = String()

	public var StackTrace:String = String()

	public var HelpLink:String = String()
}
