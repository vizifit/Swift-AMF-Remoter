//
//  VzSession.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 6-1-2017 8:28.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 

@objc( VzSession ) open class VzSession  : EntityBase{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.User.VzSession"
  
        
    }

    

	public var UserId:Int = -1

	public var User:VzUser = VzUser()

	public var SessionStarted:Any? = nil

	public var SessionEnded:Any? = nil

	public var SessionActive:Bool = false

	public var Device:String = String()

	public var IPAddress:String = String()
}
