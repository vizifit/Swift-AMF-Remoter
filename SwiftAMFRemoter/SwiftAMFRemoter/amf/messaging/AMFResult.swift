//
//  AMFResult.swift
//  SwiftAMFManager
//
//  Created by Tony Henderson on 5/13/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation

open class AMFResult: Object{
    
    init(isSuccess isSuccessValue:Bool,
         serviceDefinition serviceDefinitionValue:IAMFServiceDefinition,
         result resultValue:Any?,
         fault faultValue:Any?) {
        
        isSuccess = isSuccessValue
        serviceDefinition = serviceDefinitionValue
        result = resultValue
        fault = faultValue
    }
    
    open var isSuccess:Bool
    open var serviceDefinition:IAMFServiceDefinition
    open var result:Any?
    open var fault:Any?
    
    
}
