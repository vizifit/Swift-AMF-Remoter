//
//  IServiceRequest.swift
//  SwiftAMF
//
//  Created by Tony Henderson on 5/1/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation

public protocol IServiceRequest: IDictionaryItem {
    
    var serviceDefinition:IAMFServiceDefinition {get}
    
    var requestId:String{get}
    
    var customWaitMessage:String?{get}
    
    var serviceConfigKey:String{get}
    
    // Questionalbe on how this might work
    var args:[Any]?{get}

    }
