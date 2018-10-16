//
//  VzProgram.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-29-2017 23:39.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( VzProgram ) open class VzProgram  : BaseMediaContent{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Program.VzProgram"
  
        
    }

    

	public var ItemOrder:Int = -1

	public var ProgramCategoryTypeId:Int = -1

	public var ProgramCategoryType:VzProgramCategoryType?

	public var ProgramStatusTypeId:Int = -1

	public var ProgramStatusType:VzProgramStatusType?

	public var ProgramAccessTypeId:Int = -1

	public var ProgramAccessType:VzProgramAccessType?

	public var Activities:[Any]?
}
