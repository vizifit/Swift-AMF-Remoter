//
//  VzMediaContentType.swift
//  SwiftAMFRemoter
//
//  Created by SwiftAMFManager on 6-1-2017 8:27.
//  Copyright © 2017 by SwiftAMFManager. All rights reserved.
//

import Foundation
import SwiftAMFRemoter 

@objc( VzMediaContentType ) open class VzMediaContentType  : BaseContentType{
 
 	required public init() {
 
 		super.init()
        
        self.remoteClassAlias = "com.vizifit.API.Model.Media.VzMediaContentType"
  
        
    }

    

	public var Extension:String = String()

	public var MimeType:String = String()
}
