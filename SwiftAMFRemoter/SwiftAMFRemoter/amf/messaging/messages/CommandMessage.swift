//
//  CommandMessage.swift
//  WebApiPOC
//
//  Created by Tony Henderson on 6/16/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation

open class CommandMessage : AsyncMessage{
    
    
    /// <summary>
    /// This member supports the Fluorine infrastructure and is not intended to be used directly from your code.
    /// </summary>
    open static let AuthenticationMessageRefType = "flex.messaging.messages.AuthenticationMessage";
    /// <summary>
    /// This operation is used to test connectivity over the current channel to the remote endpoint.
    /// </summary>
    open static let ClientPingOperation = 5;
    /// <summary>
    /// This operation is used to subscribe to a remote destination.
    /// </summary>
    open static let SubscribeOperation = 0;
    /// <summary>
    /// This operation is used to unsubscribe from a remote destination.
    /// </summary>
    open static let UnsubscribeOperation = 1;
    /// <summary>
    /// This is the default operation for new CommandMessage instances.
    /// </summary>
    open static let UnknownOperation = 10000;
    /// <summary>
    /// This operation is used to poll a remote destination for pending, undelivered messages.
    /// </summary>
    open static let PollOperation = 2;
    /// <summary>
    /// This operation is used by a remote destination to sync missed or cached messages back to a client as a result of a client issued poll command.
    /// </summary>
    open static let ClientSyncOperation = 4;
    /// <summary>
    /// This operation is used to request a list of failover endpoint URIs for the remote destination based on cluster membership.
    /// </summary>
    open static let ClusterRequestOperation = 7;
    /// <summary>
    /// This operation is used to send credentials to the endpoint so that the user can be
    /// logged in over the current channel. The credentials need to be Base64 encoded and
    /// stored in the body of the message.
    /// </summary>
    open static let LoginOperation = 8;
    /// <summary>
    /// This operation is used to log the user out of the current channel, and will
    /// invalidate the server session if the channel is HTTP based.
    /// </summary>
    open static let LogoutOperation = 9;
    /// <summary>
    /// This operation is used to indicate that the client's session with a remote destination has timed out.
    /// </summary>
    open static let SessionInvalidateOperation = 10;
    /// <summary>
    /// This operation is used to indicate that a channel has disconnected.
    /// </summary>
    open static let DisconnectOperation = 12;
    
    /// <summary>
    /// The name for the selector header in subscribe messages.
    /// </summary>
    open static let SelectorHeader = "DSSelector"
    
    /// <summary>
    /// The name for the selector header in subscribe messages.
    /// </summary>
    open static let MessagingVersion:String = "DSMessagingVersion"
    
    /// <summary>
    /// The name for the header used internaly on the server to indicate that an
    ///	unsubscribe message is due to a client session being invalidated.
    /// </summary>
    open static let SessionInvalidatedHeader = "DSSessionInvalidated"
    /// <summary>
    /// This member supports the Fluorine infrastructure and is not intended to be used directly from your code.
    /// </summary>
    open static let FluorineMessageClientTimeoutHeader = "FluorineMessageClientTimeout"
    /// <summary>
    /// Poll wait must be suppressed.
    /// </summary>
    internal static let FluorineSuppressPollWaitHeader = "FluorineSuppressPollWait";
    
    static let OperationNames:[String] = [ "subscribe", "unsubscribe", "poll", "unused3", "client_sync", "client_ping", "unused6", "cluster_request", "login", "logout", "subscription_invalidate", "multi_subscribe", "disconnect", "trigger_connect" ]

    
    fileprivate var messageRefType:String
    
    fileprivate var operation:Int
    
    required public init() {
        
        self.messageRefType = ""
        self.operation =  CommandMessage.UnknownOperation
        
        super.init()
        
        self.remoteClassAlias = "flex.messaging.messages.CommandMessage"
         
    }
    
//    /// <summary>
//    /// Gets or sets the operation for this CommandMessage.
//    /// </summary>
//    open var operation: Int {
//        
//        get{return self._operation}
//        set{ self._operation = newValue}
//        
//    }
//    
//    /// <summary>
//    /// Gets or sets the message reference type for the CommandMessage.
//    /// </summary>
//    open var messageRefType: String {
//        
//        get{return self._messageRefType}
//        set{ self._messageRefType = newValue}
//        
//    }
    
    override func copyImpl(_ clone: FlexMessage?) -> FlexMessage {
        
        var localClone = clone
        if(localClone == nil){ localClone = CommandMessage()}
        
        localClone = super.copyImpl(localClone)
        
        (localClone as! CommandMessage).messageRefType = messageRefType
        (localClone as! CommandMessage).operation = operation
        
        return localClone!
    }

   
    /// <summary>
    /// Converts operation code to string.
    /// </summary>
    /// <param name="operation">The operation code.</param>
    /// <returns>A string representing the operation code.</returns>
    open static func operationToString( _ operation:Int)->String
    {
        if (operation < 0 || operation >= OperationNames.count){
            
           return "invalid operation\(operation)"
        }
        
        return OperationNames[operation];
    }
    
    /// <summary>
    /// Returns a string that represents the current CommandMessage object fields.
    /// </summary>
    /// <param name="indentLevel">The indentation level used for tracing the message members.</param>
    /// <returns>
    /// A string that represents the current CommandMessage object fields.
    /// </returns>    
    override func toStringFields(_ indentLevel : Int) -> String {
        
        let separator =  FlexMessage.getFieldSeparator(indentLevel)
 
        var compositeValue:String = "\(separator)operation = \(CommandMessage.operationToString(operation))"
        
        if(operation == CommandMessage.SubscribeOperation){
            compositeValue+="\(separator)selector = \(String(describing: getHeader(CommandMessage.SelectorHeader)))"
        }
        
        if(operation != CommandMessage.LoginOperation){
            compositeValue+=super.toStringFields(indentLevel)
        }
        else{
            compositeValue+="\(separator)clientId = \(self.clientId)"
            compositeValue+="\(separator)destination = \(String(describing: self.destination))"
            compositeValue+="\(separator)messageId = \(self.messageId)"
            compositeValue+="\(separator)timestamp = \(self.timestamp)"
            compositeValue+="\(separator)timeToLive = \(self.timeToLive)"
            //compositeValue+="\(separator)timeToLive = \(self.timeToLive)"
            compositeValue+="\(separator)***not printing credentials***"
        }
        
        return compositeValue
        
    }
    
    
    open static func commandMessageFactory(destination:String, endpoint:String, timeToLive:Int=15000, connectionId:String?=nil) -> CommandMessage{
        
        let message = CommandMessage()
        message.clientId = UUID().uuidString // "D" - xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx (32 digits separated by hyphens)
        message.destination = destination
        message.messageId = UUID().uuidString
        message.timestamp = 0 //Int(Date().timeIntervalSince1970)
        message.timeToLive = timeToLive
        
        
        //            remotingMessage.SetHeader(MessageBase.EndpointHeader, endpoint)
        //            remotingMessage.SetHeader(MessageBase.FlexClientIdHeader, _netConnection.ClientId ?? "nil")
        message.setHeader(CommandMessage.MessagingVersion, value: "1")
        message.setHeader("DSId", value: "nil")
        //message.setHeader(FlexMessageHeaders.FlexClientIdHeader, value: ((clientId != nil) ? clientId : "nil")!)
        
        
        return message
        
    }


}
