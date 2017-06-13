//
//  MessageQueueItem.swift
//  SwiftAMFRemoter
//
//  Created by Tony Henderson on 6/11/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation

open class MessageQueueItem: IDictionaryItem{
    
    
    private var _key:String = String()
    
    private var _isUpdateable:Bool = false
    
    
    private var _retryInterval:Int = 0
    
    private var _message:Any? = nil
    
    private var _timeStamp:Date? = nil
    
    private var _sender:String = String()
    
    private var _lastRetry:Date? = nil
    
    private var _args:[Any?]?
    
    public var status:String = String() //MessageQueue.MSG_STATUS_PENDING;
    
    public var key:String { get {return _key} }
    
    public var isUpdateable:Bool {get { return _isUpdateable } }
    
}
