//
//  VzProgram.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 11-5-2017 1:7.
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

	public var ProgramStatusTypeId:Int = -1

	public var ProgramStatusType:VzProgramStatusType?

	public var Activities:[Any]?
}
