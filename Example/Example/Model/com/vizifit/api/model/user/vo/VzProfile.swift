//
//  VzProfile.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 6-1-2017 8:28.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 

@objc( VzProfile ) open class VzProfile  : BaseMedia{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.User.VzProfile"
  
        
    }

    

	public var DOB:Any? = nil

	public var Gender:String = String()

	public var Height:Int = -1

	public var Weight:Int = -1

	public var UnitOfMeasure:Int = -1

	public var Tagline:String = String()

	public var User:VzUser?

	public var UserId:Int = -1
}
