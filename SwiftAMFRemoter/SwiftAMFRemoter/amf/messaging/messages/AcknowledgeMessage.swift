//
//  AcknowledgeMessage.swift
//  WebApiPOC
//
//  Created by Tony Henderson on 6/16/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation

@objc(AcknowledgeMessage) open class AcknowledgeMessage : AsyncMessage, IResultMessage{
    
    
    required public init() {
        
        super.init()
        
        self.remoteClassAlias = "flex.messaging.messages.AcknowledgeMessage"
        
//        _messageId = ""
//        _timestamp = 0

    }
    
    override func copyImpl(_ clone: FlexMessage?) -> FlexMessage {
        
        var localClone = clone
        if(localClone == nil){localClone = AcknowledgeMessage() }
        
        return super.copyImpl(localClone)
    }
    
    
}
