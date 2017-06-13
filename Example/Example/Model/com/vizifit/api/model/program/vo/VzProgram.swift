//
//  VzProgram.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 6-1-2017 8:27.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 

@objc( VzProgram ) open class VzProgram  : BaseMediaContent{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Program.VzProgram"
  
        
    }

    

	public var ItemOrder:Int = -1

	public var ProgramStatusTypeId:Int = -1

	public var ProgramStatusType:VzProgramStatusType = VzProgramStatusType()

	public var Activities:[Any]? = nil
}
