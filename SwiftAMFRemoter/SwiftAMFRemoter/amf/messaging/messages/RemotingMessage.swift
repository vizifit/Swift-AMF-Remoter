//
//  RemoteMessage.swift
//  WebApiPOC
//
//  Created by Tony Henderson on 6/15/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation


@objc(RemotingMessage) open class RemotingMessage:FlexMessage{
    
    
    public var source:String? = nil
    
    public var operation:String = ""
    
    
    required public init() {
        
        super.init()
     
        self.remoteClassAlias = "flex.messaging.messages.RemotingMessage"
    }
       
    /// <summary>
    /// Gets or sets the underlying source of a RemoteObject destination.
    /// </summary>
    /// <remarks>
    /// This property is provided for backwards compatibility. The best practice, however, is
    /// to not expose the underlying source of a RemoteObject destination on the client
    /// and only one source to a destination. Some types of Remoting Services may even ignore
    /// this property for security reasons.
    /// </remarks>
//    open var source:String?
//    {
//        get{ return self.source }
//        set{ self.source = newValue }
//    }
    /// <summary>
    /// Gets or sets the name of the remote method/operation that should be called.
    /// </summary>
//    open var operation:String
//        {
//        get{ return self._operation }
//        set{ self._operation = newValue }
//    }
    
    /// <summary>
    /// Returns a string that represents the current RemotingMessage object fields.
    /// </summary>
    /// <param name="indentLevel">The indentation level used for tracing the message members.</param>
    /// <returns>A string that represents the current RemotingMessage object fields.</returns>
    override func toStringFields(_ indentLevel: Int) -> String {
        
        let separator =  FlexMessage.getFieldSeparator(indentLevel)
        let compositeValue:String = "\(separator)operation = \(self.operation)\(super.toStringFields(indentLevel))"
        
        return compositeValue

    }
    
    override func copyImpl(_ clone: FlexMessage?) -> FlexMessage {
        
        var localClone = clone
        if(localClone == nil){
            localClone = RemotingMessage()
        }
        
        localClone = super.copyImpl(localClone)
        
        (localClone as! RemotingMessage).source = self.source
        (localClone as! RemotingMessage).operation = self.operation
        
        return localClone!
    }
    
    public static func updateRemoteMessage(message:RemotingMessage, endpoint:String?, clientId:String?){
        
        
        if(endpoint != nil){
            message.setHeader(FlexMessageHeaders.EndpointHeader, value: endpoint!)
        }
        
        if(clientId != nil){
            message.setHeader(FlexMessageHeaders.FlexClientIdHeader, value: clientId!)
        }
        
    }
    
    public static func remoteMessageFactory(destination:String, endpoint:String, timeToLive:Int=15000, connectionId:String?=nil) -> RemotingMessage{
    
        
        
        let message = RemotingMessage()
        message.clientId = UUID().uuidString // "D" - xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx (32 digits separated by hyphens)
        message.destination = destination
        message.messageId = UUID().uuidString
        message.timestamp = Int(Date().timeIntervalSince1970)
        message.timeToLive = timeToLive
        
        
        //            remotingMessage.SetHeader(MessageBase.EndpointHeader, endpoint)
        //            remotingMessage.SetHeader(MessageBase.FlexClientIdHeader, _netConnection.ClientId ?? "nil")
        message.setHeader(FlexMessageHeaders.RequestTimeoutHeader, value: String(timeToLive))
        message.setHeader(FlexMessageHeaders.FlexClientIdHeader, value: message.clientId)
        message.setHeader(FlexMessageHeaders.EndpointHeader, value: "Null")
        
        //message.setHeader(FlexMessageHeaders.FlexClientIdHeader, value: ((clientId != nil) ? clientId : "nil")!)

        
        return message
    
    }

    
}
