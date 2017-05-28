//
//  IAMFServiceDefinition.swift
//  SwiftAMF
//
//  Created by Tony Henderson on 5/1/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation

public protocol IAMFServiceDefinition: IServiceDefinition {
    
    var destination:String? {get}
    
    var endpoint:String? {get}
    
    var methodName:String{get}
    
    var modalWait:Bool{get}
    
    var modalWaitMessage:String? {get}
    
    var source:String? {get}
    
    var alwaysSendNotification:Bool {get}
}