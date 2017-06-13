//
//  IMessageQueue.swift
//  SwiftAMFRemoter
//
//  Created by Tony Henderson on 6/11/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation

public protocol IMessageQueue: IDictionaryItem {
//    
//    function get defaultTimeout():int;
//    
//    function hasMessage(key:String):Boolean;
//    
//    function get onMessageReLoop():ISignal;
//    
//    function get onMessageRetry():ISignal;
//    
//    function get onMessageRetryFailed():ISignal;
//    
//    function get pollingInterval():int;
//    
//    function initialize(queueItem:MessageQueueItemSO):void;
//    
//    function dispose():void;
//    
//    function popMessage(key:String):void;
//    
//    function pushMessage(queueItem:MessageQueueItemSO):void;
//    
    
    func initialize(queueItem:MessageQueueItem)
    
    func hasMessage(key:String)
    
    func popMessage(key:String)
    
    func pushMessage(queueItem:MessageQueueItem)
    
    func dispose()
    
    var defaultTimeout:Int {get}
    
    var onMessageReLoop:String? {get}
    
    var onMessageRetry:String{get}
    
    var onMessageRetryFailed:Bool{get}
    
    var pollingInterval:Int {get}
    
  
}
