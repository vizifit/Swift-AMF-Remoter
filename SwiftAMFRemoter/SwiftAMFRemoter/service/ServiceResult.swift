//
//  ServiceResult.swift
//  SwiftAMF
//
//  Created by Tony Henderson on 5/1/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation

open class  ServiceResult:IDictionaryItem{
    
    
    init(serviceDefinition:IServiceDefinition, result:Any?=nil){
        
        self._key = serviceDefinition.value
        self._result=result
        
    }
    
    fileprivate var _key:String;
    fileprivate var _result:Any?;
    fileprivate var _isUpdateable: Bool=false
    
    
    open var key: String{
        
        get{return self._key}
    }
    
    open var result:Any?{
        
        get{
            return self._result
        }
    }
    open var isUpdateable: Bool{
        
        get{
            return self._isUpdateable;
        }
    }
}
