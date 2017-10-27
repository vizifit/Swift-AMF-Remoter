//
//  VzAccount.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 6-1-2017 8:28.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 

@objc( VzAccount ) open class VzAccount  : EntityBase{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.User.VzAccount"
  
        
    }

    

	public var UserId:Int = -1

	public var User:VzUser?

	public var Password:String = String()
}
