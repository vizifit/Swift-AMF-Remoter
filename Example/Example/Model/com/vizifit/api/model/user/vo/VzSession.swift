//
//  VzSession.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-29-2017 23:39.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( VzSession ) open class VzSession  : EntityBase{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.User.VzSession"
  
        
    }

    

	public var UserId:Int = -1

	public var User:VzUser?

	public var SessionStarted:Any?

	public var SessionEnded:Any?

	public var SessionActive:Bool = false

	public var SessionNonce:Any?

	public var Device:String = String()

	public var IPAddress:String = String()

	public var SessionContextKey:String = String()
}
