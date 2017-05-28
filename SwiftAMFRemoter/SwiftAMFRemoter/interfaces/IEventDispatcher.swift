//
//  IEventDispatcher.swift
//  SwiftAMFManager
//
//  Created by Tony Henderson on 1/4/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation

/**
 flash.events.IEventDispatcher for Swift
 */
public protocol IEventDispatcher: class {
    func addEventListener(_ type:String, selector:Selector, observer:AnyObject?, useCapture:Bool)
    func removeEventListener(_ type:String, selector:Selector, observer:AnyObject?, useCapture:Bool)
    func dispatch(event:Event)
    func dispatch(_ type:String, bubbles:Bool, data:Any?)
}

