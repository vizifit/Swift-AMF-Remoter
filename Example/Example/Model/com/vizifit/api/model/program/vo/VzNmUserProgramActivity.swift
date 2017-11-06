//
//  VzNmUserProgramActivity.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-5-2017 1:7.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( VzNmUserProgramActivity ) open class VzNmUserProgramActivity  : BasicObject{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Program.VzNmUserProgramActivity"
  
        
    }

    

	public var UserId:Int = -1

	public var UserProgramId:Int = -1

	public var ProgramId:Int = -1

	public var ActivityId:Int = -1

	public var ActivityOrder:Int = -1

	public var UserEmail:String = String()

	public var ProgramName:String = String()

	public var ActivityName:String = String()

	public var ActivityDesc:String = String()
}
