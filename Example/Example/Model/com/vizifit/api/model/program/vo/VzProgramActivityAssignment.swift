//
//  VzProgramActivityAssignment.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 6-1-2017 8:27.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 

@objc( VzProgramActivityAssignment ) open class VzProgramActivityAssignment  : EntityBase{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Program.VzProgramActivityAssignment"
  
        
    }

    

	public var ItemOrder:Int = -1

	public var Program:VzProgram = VzProgram()

	public var ProgramId:Int = -1

	public var Activity:VzActivity = VzActivity()

	public var ActivityId:Int = -1
}
