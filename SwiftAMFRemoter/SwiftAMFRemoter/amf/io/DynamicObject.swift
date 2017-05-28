//
//  DynamicObject.swift
//  SwiftAMFManager
//
//  Created by Tony Henderson on 1/15/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation

open class DynamicObject: BasicObject{
    
    required public init() {
        
        self.properties = [:]
        
        super.init()
        
    }
    
    public var properties:[String:Any?]
    
    open var hasProperties:Bool{
        get { return (self.properties.count>0) }
    }
}
