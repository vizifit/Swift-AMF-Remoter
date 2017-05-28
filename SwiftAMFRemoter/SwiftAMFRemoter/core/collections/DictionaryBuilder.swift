//
//  DictionaryBuilder.swift
//  SwiftAMF
//
//  Created by Tony Henderson on 5/1/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation


open class DictionaryBuilder{
    
    
    init(){
        
        self._dict = [:]
    }
    
    
    fileprivate var _dict:[String: Any?] = [:]
    
    
    //as? String // Casting
    
//    func addItem(item:IDictionaryItem, args:[Any]?...){
//        
//        self._dict[item.key] = item
//        
//    }

    open func addItem(_ item:IDictionaryItem){
        
        self._dict[item.key] = item
        
    }
    
    open func updateItem(_ item:IDictionaryItem){
        
        self._dict.updateValue(item, forKey: item.key)
    }
    
    open func getItem(_ key:String)-> Any?{
       
        return self._dict[key] as Any
    }
    
    open func itemExists(_ key:String)->Bool{
        
        
        return (self._dict[key] != nil)
    }
    
    
    open func removeItem(_ key:String){
        
        self._dict.removeValue(forKey: key)

    }
    
    open var list:[String: Any?]{
        
        get{
            return self._dict
        }
    }
    
}
