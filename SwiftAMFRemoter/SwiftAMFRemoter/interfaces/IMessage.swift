//
//  IMessage.swift
//  SwiftAMFManager
//
//  Created by Tony Henderson on 1/2/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation

public protocol IMessage {
    
    /// <summary>
    /// Gets or sets the client identity indicating which client sent the message.
    /// </summary>
    var clientId:String { get  set }
    /// <summary>
    /// Gets or sets the message destination.
    /// </summary>
    var destination:String? { get  set }
    /// <summary>
    /// Gets or sets the identity of the message.
    /// </summary>
    /// <remarks>This field is unique and can be used to correlate a response to the original request message.</remarks>
    var messageId:String { get  set }
    /// <summary>
    /// Gets or sets the time stamp for the message.
    /// </summary>
    /// <remarks>The time stamp is the date and time that the message was sent.</remarks>
    var timestamp:Int { get  set }
    /// <summary>
    /// Gets or sets the validity for the message.
    /// </summary>
    /// <remarks>Time to live is the number of milliseconds that this message remains valid starting from the specified timestamp value.</remarks>
    var timeToLive:Int { get  set }
    /// <summary>
    /// Gets or sets the body of the message.
    /// </summary>
    /// <remarks>The body is the data that is delivered to the remote destination.</remarks>
    var body:Any? { get  set }
    /// <summary>
    /// Gets or sets the headers of the message.
    /// </summary>
    /// <remarks>
    
    /// The headers of a message are an associative array where the key is the header name and the value is the header value.
    /// This property provides access to the specialized meta information for the specific message instance.
    /// Flex core header names begin with a 'DS' prefix. Custom header names should start with a unique prefix to avoid name collisions.
    /// </remarks>
    var headers:DynamicObject { get  set }
    
    
    //var dict:Dictionary<String,AnyObject> {get set}
    
    /// <summary>
    /// Retrieves the specified header value.
    /// </summary>
    /// <param name="name">Header name.</param>
    /// <returns>The value associated with the specified header name.</returns>
    func getHeader( _ name:String)->String?
    /// <summary>
    /// Sets a header value.
    /// </summary>
    /// <param name="name">Header name.</param>
    /// <param name="value">Value associated with the header name.</param>
    func setHeader(_ name:String, value:String)
    /// <summary>
    /// Retrieves whether for the specified header name an associated value exists.
    /// </summary>
    /// <param name="name">Header name.</param>
    /// <returns>The associated value with the header name.</returns>
    func headerExists(_ name:String)->Bool
    /// <summary>
    /// Gets the Flex client id specified in the message headers ("DSId").
    /// </summary>
    /// <returns>The Flex client id.</returns>
    func getFlexClientId()->String?
    
    /// <summary>
    /// Creates a new object that is a copy of the current instance.
    /// </summary>
    /// <returns>A new object that is a copy of this instance.</returns>
    //func copy()->IMessage
    
    
}
