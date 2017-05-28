//
//  ClassMap.swift
//  SwiftAMFManager
//
//  Created by Tony Henderson on 1/2/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation


open class ClassMap
{
    
    fileprivate var _className:String
    fileprivate var _classAlias:String
    //fileprivate var _classAlias:String
    
    init(className:String, classAlias:String){
        
        _className = className
        _classAlias = classAlias
        
    }
    
    open var className:String{
        
        get { return _className }
        set { _className = newValue }
    }
    
    open var classAlias:String{
        
        get { return _classAlias }
        set { _className = newValue }
    }
}
