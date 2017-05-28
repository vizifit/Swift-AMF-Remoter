//
//  MessageBase.swift
//  WebApiPOC
//
//  Created by Tony Henderson on 6/15/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation

open class FlexMessageHeaders
{
    /// <summary>
    /// Messages pushed from the server may arrive in a batch, with messages in the batch
    /// potentially targeted to different Consumer instances.
    /// Each message will contain this header identifying the Consumer instance that will
    /// receive the message.
    /// </summary>
    open static let DestinationClientIdHeader:String = "DSDstClientId"
    /// <summary>
    /// Messages are tagged with the endpoint id for the Channel they are sent over.
    /// Channels set this value automatically when they send a message.
    /// </summary>
    open static let  EndpointHeader:String = "DSEndpoint"
    /// <summary>
    /// Messages that need to set remote credentials for a destination carry the Base64 encoded
    /// credentials in this header.
    /// </summary>
    open static let RemoteCredentialsHeader:String = "DSRemoteCredentials"
    /// <summary>
    /// Messages sent with a defined request timeout use this header.
    /// The request timeout value is set on outbound messages by services or channels and the value
    /// controls how long the corresponding MessageResponder will wait for an acknowledgement,
    /// result or fault response for the message before timing out the request.
    /// </summary>
    open static let RequestTimeoutHeader:String = "DSRequestTimeout"
    /// <summary>
    /// This header is used to transport the global FlexClient Id value in outbound messages
    /// once it has been assigned by the server.
    /// </summary>
    open static let FlexClientIdHeader:String = "DSId"
}

@objc(FlexMessage) open class FlexMessage : BasicObject, IMessage{
    
    public var timestamp:Int
    
    public var body:Any?
    
    public var messageId:String
    
    public var timeToLive:Int
    
    public var clientId:String
    
    public var headers:DynamicObject
    
    public var destination:String?
    
  
    
    required public init() {
        self.clientId = ""
        self.destination = ""
        self.messageId = ""
        self.timestamp=0
        self.timeToLive=10000
        self.body = nil
        self.headers = DynamicObject()
    }
    
    
    
    
    
    /// <summary>
    /// Retrieves the specified header value.
    /// </summary>
    /// <param name="name">Header name.</param>
    /// <returns>The value associated with the specified header name.</returns>
    open func getHeader( _ name:String)->String?{
        
        for (key, value) in self.headers.properties {
            
            if(key == name){
                return value as? String
            }
            
            //print("\(key): \(value)")
        }
        
        return nil
        
    }
    
    /// <summary>
    /// Sets a header value.
    /// </summary>
    /// <param name="name">Header name.</param>
    /// <param name="value">Value associated with the header name.</param>
    
    open func setHeader(_ name: String, value: String) {
        
        self.headers.properties[name] = value
        
    }
    
    /// <summary>
    /// Retrieves whether for the specified header name an associated value exists.
    /// </summary>
    /// <param name="name">Header name.</param>
    /// <returns></returns>
    open func headerExists(_ name: String) -> Bool {
        
        
        if(getHeader(name) != nil){
            return true
        }
        
        return false
    }
    
    
    /// <summary>
    /// Creates a new object that is a copy of the current instance.
    /// </summary>
    /// <returns>A new object that is a copy of this instance.</returns>
    //    @objc public func copyWithZone(zone: NSZone) -> AnyObject {
    //        //let copy = Person(firstName: firstName, lastName: lastName, age: age)
    //
    //        let copy = MessageBase()
    //
    //        copy._body = _body
    //        copy._clientId = _clientId
    //        copy._destination = _destination
    //        copy._messageId = _messageId
    //        copy._timestamp = _timestamp
    //        copy._timeToLive = _timeToLive
    //        copy._headers = _headers
    //
    //        return copy
    //    }
    @discardableResult
    func copyImpl( _ clone:FlexMessage?)->FlexMessage{
        
        var localClone:FlexMessage? = clone!
        
        if(localClone == nil){
            localClone = FlexMessage()
        }
        
        localClone!.body = self.body
        localClone!.clientId = self.clientId
        localClone!.destination = self.destination
        localClone!.messageId = self.messageId
        localClone!.timestamp = self.timestamp
        localClone!.timeToLive = self.timeToLive
        localClone!.headers = self.headers
        
        
        return clone!
    }
    
    open func copy() -> IMessage {
        
        return copyImpl(nil)
    }
    
    /// <summary>
    /// Gets the Flex client id specified in the message headers ("DSId").
    /// </summary>
    /// <returns>The Flex client id.</returns>
    open func getFlexClientId() -> String? {
        
        
        if (headerExists(FlexMessageHeaders.FlexClientIdHeader)){
            return getHeader(FlexMessageHeaders.FlexClientIdHeader)
        }
        
        return nil
    }
    
    internal func setFlexClientId(value clientId:String){
        
        setHeader(FlexMessageHeaders.FlexClientIdHeader, value: clientId)
    }
    
    static let indentLevels:[String] = [ "", "  ", "    ", "      ", "        ", "          " ]
    
    
    internal static func getIndent(_ indentLevel:Int)->String{
        
        var indentLevel = indentLevel
        
        if (indentLevel < indentLevels.count){
            return indentLevels[indentLevel]
        }
        
        var traceValue:String = String()
        
        traceValue+=indentLevels[indentLevels.count-1]
        indentLevel = (indentLevel - indentLevels.count-1)
        
        for _ in 0 ..< indentLevel {
            //print(i)
            traceValue+="  "
        }
        
        return traceValue
        
    }
    
    internal static func getFieldSeparator( _ indentLevel:Int)->String
    {
        
        var indent:String  = getIndent(indentLevel)
        
        if (indentLevel > 0){
            indent = "\n" + indent
        }
        else{
            indent = " "
        }
        
        return indent
    }
    
    /// <summary>
    /// Returns a string that represents the current MessageBase object.
    /// </summary>
    /// <returns>A string that represents the current MessageBase object.</returns>
    
    open func toString()->String{
        
        return "1"
    }
    
    /// <summary>
    /// Returns a header string that represents the current MessageBase object.
    /// </summary>
    /// <param name="indentLevel">The indentation level used for tracing the message members.</param>
    /// <returns>A header string that represents the current MessageBase object.</returns>
    func toStringHeader( _ indentLevel:Int)->String
    {
        var value:String = "Flex Message"
        
        value += " (\(type(of: self) ))"
        
        return value
    }
    
    
    /// <summary>
    /// Returns a string that represents the current MessageBase object fields.
    /// </summary>
    /// <param name="indentLevel">The indentation level used for tracing the message members.</param>
    /// <returns>A string that represents the current MessageBase object fields.</returns>
    func toStringFields( _ indentLevel:Int)->String
    {
        if (self.headers.properties.count == 0)
        {
            let separator =  FlexMessage.getFieldSeparator(indentLevel)
            
            var compositeValue:String = String()
            
            for (key, value) in self.headers.properties {
                
                print("\(key): \(String(describing: value))")
                
                compositeValue += "\(separator) hdr(\(key) = "
                compositeValue += bodyToString(value as AnyObject, indentLevel: indentLevel+1)
                
            }
            
            return compositeValue
        }
        
        return String()
        
    }
    
    /// <summary>
    /// Returns a string that represents body object.
    /// </summary>
    /// <param name="body">An object to trace.</param>
    /// <param name="indentLevel">The indentation level used for tracing object members.</param>
    /// <returns>A string that represents body object.</returns>
    func bodyToString( _ body:Any,  indentLevel indentLevelLocal:Int)->String
    {
        return bodyToString(body, indentLevel: indentLevelLocal, visited: nil)
    }
    
    /// <summary>
    /// Returns a string that represents body object.
    /// </summary>
    /// <param name="body">An object to trace.</param>
    /// <param name="indentLevel">The indentation level used for tracing object members.</param>
    /// <param name="visited">Dictionary to handle circular references.</param>
    /// <returns>A string that represents body object.</returns>
    func bodyToString(_ body:Any,  indentLevel indentLevelLocal:Int, visited visitedLocal:String?)->String
    {
        var indentLevel = indentLevelLocal
        
        indentLevel += 1
        
        if(visitedLocal == nil &&  indentLevel > 18){
            
            return "\n\(FlexMessage.getFieldSeparator(indentLevel))<..max-depth-reached..>"
        }
        
        return internalBodyToString(body, indentLevel: indentLevelLocal, visited: visitedLocal)
        
        //TODO: Need exception blocks
        
    }
    
    /// <summary>
    /// Returns a string that represents body object.
    /// </summary>
    /// <param name="body">An object to trace.</param>
    /// <param name="indentLevel">The indentation level used for tracing object members.</param>
    /// <returns>A string that represents body object.</returns>
    func internalBodyToString( _ body:Any,  indentLevel indentLevelLocal:Int)->String
    {
        return internalBodyToString(body, indentLevel: indentLevelLocal, visited: nil)
    }
    
    /// <summary>
    /// Returns a string that represents body object.
    /// </summary>
    /// <param name="body">An object to trace.</param>
    /// <param name="indentLevel">The indentation level used for tracing object members.</param>
    /// <param name="visited">Dictionary to handle circular references.</param>
    /// <returns>A string that represents body object.</returns>
    func internalBodyToString( _ body:Any?,  indentLevel indentLevelLocal:Int, visited visitedLocal:String?)->String
    {
        
        if (body is [AnyObject]){
            
            //TODO: Finishe checkVisited
            //            if ((visitedLocal = checkVisited(visited: visitedLocal, obj: body)) == nil){
            //                 return "<--"
            //            }
            
            let separator:String = FlexMessage.getFieldSeparator(indentLevelLocal)
            
            var content:String = String()
            var arr:[AnyObject] = body as! [AnyObject]
            
            if(arr.count > 0){
                content+=FlexMessage.getFieldSeparator(indentLevelLocal-1)
            }
            
            content+="["
            
            if(arr.count > 0){
                
                content+=separator
                
                for i in 0 ..< arr.count {
                    
                    if (i != 0){
                        content+=","
                        content+=separator
                    }
                    
                    content+=(bodyToString(arr[i], indentLevel: indentLevelLocal, visited: visitedLocal))
                }
                content+=FlexMessage.getFieldSeparator(indentLevelLocal-1)
            }
            
            content+="]"
            
            return content
        }
        else if (body is FlexMessage){
            return ""
            //return (body as! MessageBase).ToString(indentLevelLocal)
        }
        else if (body != nil){
            
            
            //return body.toString()
        }
        
        return ""
        
    }
    
    fileprivate func checkVisited(visited visitedLocal:String?, obj:AnyObject)->String?{
        
        if(visitedLocal == nil){
            //visitedLocal = [:]
            
        }
        
        return nil
        
    }
    
    
}
