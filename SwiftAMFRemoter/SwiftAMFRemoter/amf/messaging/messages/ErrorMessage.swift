//
//  ErrorMessage.swift
//  WebApiPOC
//
//  Created by Tony Henderson on 6/16/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation

@objc(ErrorMessage) open class ErrorMessage : AcknowledgeMessage{
    
 
    fileprivate var _faultCode:String
    fileprivate var _faultString:String
    fileprivate var _faultDetail:String
    fileprivate var _rootCause:AnyObject
    fileprivate var _extendedData:AnyObject
    //var _extension:ASObject
    
    /// <summary>
    /// Client authentication fault code.
    /// </summary>
    open static let ClientAuthenticationError = "Client.Authentication";
    
    /// <summary>
    /// Client authorization fault code.
    /// </summary>
    open static let ClientAuthorizationError = "Client.Authorization";
    
    required public init() {
        
         self._faultCode = ""
         self._faultString = ""
         self._faultDetail = ""
         self._rootCause = "" as AnyObject
         self._extendedData = "" as AnyObject
        
        // TODO:
         //_extension:ASObject = ""

        
        super.init()
        
        self.remoteClassAlias = "flex.messaging.messages.ErrorMessage"
    }
    /// <summary>
    /// The fault code for the error.
    /// This value typically follows the convention of "[outer_context].[inner_context].[issue]".
    ///
    /// For example: "Channel.Connect.Failed", "Server.Call.Failed"
    /// </summary>
    open var faultCode:String
    {
        get{ return _faultCode }
        set{ _faultCode = newValue }
    }
    
    /// <summary>
    /// A simple description of the error.
    /// </summary>
    open var faultString:String
    {
        get{ return _faultString }
        set{ _faultString = newValue; }
    }
    
    /// <summary>
    /// Detailed description of what caused the error. This is typically a stack trace from the remote destination
    /// </summary>
    open var faultDetail:String
    {
        get{ return _faultDetail; }
        set{ _faultDetail = newValue; }
    }
    
    /// <summary>
    /// Root cause for the error.
    /// </summary>
    open var rootCause:AnyObject
    {
        get{ return _rootCause; }
        set{ _rootCause = newValue; }
    }
    
    /// <summary>
    /// Extended data for the error.
    /// </summary>
    open var extendedData:AnyObject
        {
        get{ return _extendedData; }
        set{ _extendedData = newValue; }
    }
    
    /// <summary>
    /// Extended data that the remote destination can choose to associate with this error for custom error processing on the client.
    /// </summary>
//    public var extension:ASObject
//        {
//        get{ return _extension; }
//        set{ _extension = extension; }
//    }

    @discardableResult
    override func copyImpl(_ clone: FlexMessage?) -> FlexMessage {
        
        var localClone = clone
        if(localClone == nil){ localClone = ErrorMessage()}
        
        localClone = super.copyImpl(localClone)
        
        (localClone as! ErrorMessage).faultCode = self._faultCode
        (localClone as! ErrorMessage).faultString = self._faultString
        (localClone as! ErrorMessage).faultDetail = self._faultDetail
        (localClone as! ErrorMessage).rootCause = self._rootCause
        //(localClone as! ErrorMessage)._extendedData = _extendedData
        
        return localClone!
    }
    
    /// <summary>
    /// Returns a string that represents the current AsyncMessage object fields.
    /// </summary>
    /// <param name="indentLevel">The indentation level used for tracing the message members.</param>
    /// <returns>A string that represents the current AsyncMessage object fields.</returns>
    override func toStringFields(_ indentLevel : Int) -> String {
        
        let separator =  FlexMessage.getFieldSeparator(indentLevel)
        
        var compositeValue:String = super.toStringFields(indentLevel)
        compositeValue+="\(separator)code = \(self.faultCode)"
        compositeValue+="\(separator)message = \(self.faultString)"
        compositeValue+="\(separator)details = \(self.faultDetail)"
        compositeValue+="\(separator)rootCause "
        
        //TODO: Get rootCause to string
//        if (rootCause == null)
//        value += "null";
//        else
//        value += rootCause.ToString();
        
        compositeValue+="\(separator)body = \(bodyToString(body!, indentLevel: indentLevel))"
        
        //TODO: Extended data for ASObject
        //compositeValue+="\(separator)extendedData = \(bodyToString(extendedData!, indentLevel: indentLevel))"
  
        return compositeValue
    }
    
        
}
