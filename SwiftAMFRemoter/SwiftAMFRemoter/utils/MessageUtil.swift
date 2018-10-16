//
//  AMFMessageUtil.swift
//  WebApiPOC
//
//  Created by Tony Henderson on 6/15/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation

open class AMFMessageUtil{
     
     public static func getHeader(_ key: String, headers:[AMFMessageHeader]?) -> AMFMessageHeader? {
        
        for header in headers!{
            
            if(header.name == key){
                
                return header
            }
        }
        
        return nil
    }
    
//    static public func getHeader(key: String, headers:[String:AMFMessageHeader]?) -> AMFMessageHeader? {
//        
//        for header in headers!{
//            
//            if(header.name == key){
//                
//                return header
//            }
//        }
//        
//        return nil
//    }

    
//    static public func removeHeader(key: String, headers:[AMFMessageHeader]?){
//        
//        var index:Int = 0
//        
//        for header in headers!{
//            
//            index += 1
//            
//            if(header.name == key){
//                
//                headers?.removeAtIndex(index)
//                
//                return
//            }
//        }
//        
//    }


    
}
