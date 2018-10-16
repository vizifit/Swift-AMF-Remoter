//
//  VzUserProgram.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-29-2017 23:39.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( VzUserProgram ) open class VzUserProgram  : EntityBase{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.User.VzUserProgram"
  
        
    }

    

	public var IsScheduled:Bool = false

	public var RepeatCount:Int = -1

	public var LastCompleted:Any?

	public var DisplayProgram:String = String()

	public var Program:VzProgram?

	public var ProgramId:Int = -1

	public var User:VzUser?

	public var UserId:Int = -1

	public var UserProgramStatusTypeId:Int = -1

	public var UserProgramStatusType:VzUserProgramStatusType?
}
