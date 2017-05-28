//
//  IPendingCallBack.swift
//  SwiftAMFManager
//
//  Created by Tony Henderson on 1/2/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation


public protocol IPendingServiceCallback {
    
    
    /// <summary>
    /// Triggered when results are recieved.
    /// </summary>
    /// <param name="call"></param>
    func resultReceived( _ call:IPendingServiceCall)
    
}
