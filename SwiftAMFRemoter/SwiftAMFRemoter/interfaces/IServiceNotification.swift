//
//  IServiceNotification.swift
//  SwiftAMF
//
//  Created by Tony Henderson on 5/1/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation

public protocol IServiceNotification {
    
    
    var resultNotificationId:String? {get}
    
    var faultNotificationId:String?{get}
    
}
