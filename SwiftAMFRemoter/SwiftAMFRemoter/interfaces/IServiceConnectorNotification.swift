//
//  IServiceConnnectorNotification.swift
//  SwiftAMFRemoter
//
//  Created by Tony Henderson on 6/28/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation

public protocol IServiceConnectorNotification
{
    var notificationId:String { get }
    
    var result:Any? { get }
    
    var serviceKey:String { get}
    
    var resultMessage:IResultMessage? { get}
    
    var isError:Bool { get}
    
    var errorMessage:ErrorMessage? { get }

}
