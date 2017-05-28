//
//  BasicObject.swift
//  SwiftAMFManager
//
//  Created by Tony Henderson on 1/2/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation


open class BasicObject: NSObject, Object{
    
    required override public init() {
        
        super.init()
    }
    
    fileprivate var _remoteClassAlias:String? = nil
    
    open var remoteClassAlias:String?{
        
        get { return _remoteClassAlias }
        set { _remoteClassAlias = newValue }
    }

    
}
