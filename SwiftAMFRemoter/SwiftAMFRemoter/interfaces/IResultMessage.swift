//
//  IResultMessage.swift
//  SwiftAMFRemoter
//
//  Created by Tony Henderson on 7/2/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation


public protocol IResultMessage : IMessage{

    
    var correlationId:String { get  set }
}
