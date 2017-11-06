//
//  VzProgramActivityAssignment.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-5-2017 1:7.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 
@objcMembers
@objc( VzProgramActivityAssignment ) open class VzProgramActivityAssignment  : EntityBase{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Program.VzProgramActivityAssignment"
  
        
    }

    

	public var ItemOrder:Int = -1

	public var Program:VzProgram?

	public var ProgramId:Int = -1

	public var Activity:VzActivity?

	public var ActivityId:Int = -1
}
