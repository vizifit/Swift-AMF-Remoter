//
//  PendingModalServiceResult.swift
//  SwiftAMF
//
//  Created by Tony Henderson on 5/1/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation


open class  PendingModalServiceResult:IDictionaryItem{
    
    
    init(key:String){
        
        _key=key

    }
    
    fileprivate var _key:String;
    fileprivate var _isUpdateable: Bool=false
    
    
    open var key: String{
        
        get{return self._key}
    }
    
    
    open var isUpdateable: Bool{
        
        get{
            return self._isUpdateable;
        }
    }

}
