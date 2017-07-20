//
//  ServiceRequestGroupResult.swift
//  SwiftAMF
//
//  Created by Tony Henderson on 5/1/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation

open class  ServiceRequestGroupResult{
    
    
    init(){
        
        _resultList = DictionaryBuilder()
        
    }
    
    fileprivate var _resultList:DictionaryBuilder
    
    
    open var resultList:DictionaryBuilder {
        
        get{return self._resultList}
        
    }
    
    
    open func addResult(_ service:IServiceDefinition, result:Any?=nil){
        
        self.resultList.addItem( ServiceResult(serviceDefinition: service, result: result))
    }
    
    open func getAllServiceResults()->[String:ServiceResult]{
        
        var results:[String:ServiceResult] = [:]
        
        for (key, value) in _resultList.list {
            
            results[key]=value as? ServiceResult
        }
        
        return results
    }
    
    open func getServiceResultData(_ service:IServiceDefinition)->Any?{
        
        if(self._resultList.itemExists(service.value) == false){
            return nil
        }
        
        return (self._resultList.getItem(service.value) as? ServiceResult)?.result
    }
    
}
