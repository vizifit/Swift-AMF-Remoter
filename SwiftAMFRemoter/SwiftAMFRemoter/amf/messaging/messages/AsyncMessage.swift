//
//  AsyncMessage.swift
//  WebApiPOC
//
//  Created by Tony Henderson on 6/16/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation


@objc(AsyncMessage) open class AsyncMessage : FlexMessage{
    
    
    open var correlationId:String /// Correlation id for the AsyncMessage.
    
    
    open static let  SubtopicHeader:String = "DSSubtopic"
   
    
    required public init() {
        
        self.correlationId = ""
        
        super.init()
        
        self.remoteClassAlias = "flex.messaging.messages.AsyncMessage"
        
        
    }
  
    /// <summary>
    /// Correlation id for the AsyncMessage.
    /// </summary>
//    open var correlationId:String {
//        get{ return self._correlationId }
//        set{ self._correlationId = newValue }
//    }
    
    @discardableResult
    override func copyImpl(_ clone: FlexMessage?) -> FlexMessage {
        
        var localClone = clone
        if(localClone == nil){ localClone = AsyncMessage()}
        
        localClone = super.copyImpl(localClone)
        
        (localClone as! AsyncMessage).correlationId = self.correlationId
         
        return localClone!
    }
    
    /// <summary>
    /// Returns a string that represents the current AsyncMessage object fields.
    /// </summary>
    /// <param name="indentLevel">The indentation level used for tracing the message members.</param>
    /// <returns>A string that represents the current AsyncMessage object fields.</returns>
    override func toStringFields(_ indentLevel : Int) -> String {
        
        let separator =  FlexMessage.getFieldSeparator(indentLevel)
        
        var compositeValue:String = "\(separator)clientId = \(self.clientId)"
        compositeValue+="\(separator)correlationId = \(self.correlationId)"
        compositeValue+="\(separator)destination = \(String(describing: self.destination))"
        compositeValue+="\(separator)messageId = \(self.messageId)"
        compositeValue+="\(separator)timestamp = \(self.timestamp)"
        compositeValue+="\(separator)timeToLive = \(self.timeToLive)"
        compositeValue+="\(separator)body = \(bodyToString(body!, indentLevel: indentLevel))"
        
        compositeValue+=super.toStringFields(indentLevel)
        
        return compositeValue
        
        
    } 
    
}
