//
//  AMFMessageBody.swift
//  SwiftAMFManager
//
//  Created by Tony Henderson on 1/2/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation


//: AMF Message Bodie
open class AMFMessageBody:BasicObject  {
    
    /// <summary>
    /// This member supports the Fluorine infrastructure and is not intended to be used directly from your code.
    /// </summary>
    public static let Recordset:String = "rs://"
    /// <summary>
    /// Suffix to denote a success.
    /// </summary>
    public static let OnResult:String  = "/onResult"
    /// <summary>
    /// Suffix to denote a failure.
    /// </summary>
    public static let OnStatus:String  = "/onStatus"
    /// <summary>
    /// This member supports the Fluorine infrastructure and is not intended to be used directly from your code.
    /// </summary>
    public static let OnDebugEvents:String  = "/onDebugEvents"
    
    
    /// <summary>
    /// The actual data associated with the operation.
    /// </summary>
    fileprivate var _content:Any?
    /// <summary>
    /// Response URI which specifies a unique operation name that will be used to match the response to the client invocation.
    /// </summary>
    fileprivate var _response:String
    /// <summary>
    /// Target URI describes which operation, function, or method is to be remotely invoked.
    /// </summary>
    fileprivate var _target:String
    /// <summary>
    /// IgnoreResults is a flag to tell the serializer to ignore the results of the body message.
    /// </summary>
    fileprivate var _ignoreResults:Bool=false
    /// <summary>
    /// This member supports the Fluorine infrastructure and is not intended to be used directly from your code.
    /// </summary>
    fileprivate var _isAuthenticationAction:Bool=false
    /// <summary>
    /// This member supports the Fluorine infrastructure and is not intended to be used directly from your code.
    /// </summary>
    fileprivate var _isDebug:Bool=false
    /// <summary>
    /// This member supports the Fluorine infrastructure and is not intended to be used directly from your code.
    /// </summary>
    fileprivate var _isDescribeService:Bool=false
    
    /// <summary>
    /// Initializes a new instance of the AMFMessageBody class.
    /// </summary>
    /// <param name="target"></param>
    /// <param name="response"></param>
    /// <param name="content"></param>
    
    
    required public init( target:String?,  response:String?,  content:Any?){
        
        
        
        self._target = target ?? "null"
        self._response = response ?? "null"
        self._content = content!
      
    }
    
    required public init() {
        fatalError("init() has not been implemented")
    }
    
    /// <summary>
    /// Gets or set the target URI.
    /// The target URI describes which operation, function, or method is to be remotely invoked.
    /// </summary>
    open var target:String
        {
        get{ return _target }
        set{ _target = newValue }
    }
    
    /// <summary>
    /// Indicates an empty target.
    /// </summary>
    open var isEmptyTarget:Bool
        {
        get
        {
            return _target.isEmpty
        }
    }
    
    /// <summary>
    /// Gets or sets the response URI.
    /// Response URI which specifies a unique operation name that will be used to match the response to the client invocation.
    /// </summary>
    open var response:String
        {
        get{ return _response }
        set{ _response = newValue }
    }
    
    /// <summary>
    /// Gets or sets the actual data associated with the operation.
    /// </summary>
    open var content:Any?
        {
        get{ return _content }
        set{ _content = newValue }
    }
    /// <summary>
    /// This member supports the Fluorine infrastructure and is not intended to be used directly from your code.
    /// </summary>
    open var isAuthenticationAction:Bool
        {
        get{ return _isAuthenticationAction }
        set{ _isAuthenticationAction = newValue }
    }
    /// <summary>
    /// This member supports the Fluorine infrastructure and is not intended to be used directly from your code.
    /// </summary>
    open var ignoreResults:Bool
        {
        get{ return _ignoreResults }
        set{ _ignoreResults = newValue }
    }
    /// <summary>
    /// This member supports the Fluorine infrastructure and is not intended to be used directly from your code.
    /// </summary>
    open var isDebug:Bool
        {
        get{ return _isDebug }
        set{ _isDebug = newValue }
    }
    
    /// <summary>
    /// This member supports the Fluorine infrastructure and is not intended to be used directly from your code.
    /// </summary>
    open var isDescribeService:Bool
        {
        get{ return _isDescribeService }
        set{ _isDescribeService = newValue }
    }
    
    /// <summary>
    /// This member supports the Fluorine infrastructure and is not intended to be used directly from your code.
    /// </summary>
    open var isWebService:Bool
        {
        get
        {
            if( self.typeName != nil )
            {
                if (self.typeName!.lowercased().endsWith(".asmx")){
                    return true
                }
            }
            return false
        }
    }
    
    /// <summary>
    /// This member supports the Fluorine infrastructure and is not intended to be used directly from your code.
    /// </summary>
    open var isRecordsetDelivery:Bool
        {
        get
        {
            if( _target.hasPrefix(AMFMessageBody.Recordset)){
                return true
            }
            
            return false
            
        }
    }
    
    /// <summary>
    /// This member supports the Fluorine infrastructure and is not intended to be used directly from your code.
    /// </summary>
    open func GetRecordsetArgs()->String
    {
        if( _target.length > 0 ){
            if( self.isRecordsetDelivery ){
                
                var args:String = _target.substring(AMFMessageBody.Recordset.length, length: _target.length )
                args = args.substring( 0, length: args.indexOf("/")! )
                
                return args
            }
        }
        
        return ""
    }
    
    /// <summary>
    /// This member supports the Fluorine infrastructure and is not intended to be used directly from your code.
    /// </summary>
    open var typeName:String?
        {
        get
        {
            if( _target != "nil" && _target.count != 0 && _target != "" ){
                
                
                if( _target.lastIndexOf(".") != -1 ){
                    var localTarget:String = _target.substring(0, length: (_target.lastIndexOf("."))!)
                    
                    if( self.isRecordsetDelivery ){
                        localTarget = localTarget.substring( AMFMessageBody.Recordset.length, length: localTarget.length )
                        localTarget = localTarget.substring( localTarget.indexOf("/")! + 1, length: localTarget.length )
                        localTarget = localTarget.substring(0, length: localTarget.lastIndexOf(".")!)
                        
                    }
                    
                    return target
                }
            }
            
            return nil
        }
    }
    
    
    /// <summary>
    /// This member supports the Fluorine infrastructure and is not intended to be used directly from your code.
    /// </summary>
    open var method:String?
        {
        get
        {
            if( (_target != "nil") && _target.length != 0 ){
                if( _target.lastIndexOf(".") != -1 ){
                    var localTarget:String = _target
                    
                    if( self.isRecordsetDelivery ){
                        localTarget = localTarget.substring( AMFMessageBody.Recordset.length, length: localTarget.length )
                        localTarget = localTarget.substring( localTarget.indexOf("/")! + 1, length: localTarget.length )
                    }
                    
                    if( self.isRecordsetDelivery ){
                        localTarget = localTarget.substring(0, length: localTarget.lastIndexOf(".")!)
                    }
                    
                    let method:String = localTarget.substring(localTarget.lastIndexOf(".")!+1, length: localTarget.length)
                    
                    return method
                }
            }
            return nil
        }
    }
    
    /// <summary>
    /// This member supports the Fluorine infrastructure and is not intended to be used directly from your code.
    /// </summary>
    open var call:String
        {
        get{ return self.typeName! + "." + self.method!}
        
    }
    
    /// <summary>
    /// This method supports the Fluorine infrastructure and is not intended to be used directly from your code.
    /// </summary>
    //    public func GetSignature()->String
    //    {
    //        var signature:String = ""
    //
    //        signature += self.target!
    //
    //        var parameterList:[AnyObject]? = getParameterList()
    //
    //
    //        for i in 0 ..< parameterList?.count {
    //
    //            var parameter:AnyObject? = parameterList[i]
    //            signature+=parameter.GetType().FullName
    //        }
    //
    //        return signature
    //    }
    
    /// This method supports the Fluorine infrastructure and is not intended to be used directly from your code.
    /// The returned IList has property IsFixedSize set to true, no new elements can be added to it.
    /// </summary>
    //    public func getParameterList()->[AnyObject]?
    //    {
    //        var list:[AnyObject]? = nil
    //
    //        //Flash RPC parameters
    //        if( !self.isEmptyTarget ){
    //            if(!(_content is [AnyObject]?)){
    //
    //                list = []
    //
    //                list?.append(_content!)
    //                //list.Add(_content )
    //            }
    //            else {
    //
    //                //TODO: Should be able to remove
    //                list = (_content as! [AnyObject]?)
    //            }
    //        }
    //        else
    //        {
    //            var localContent:AnyObject? = self.content!
    //
    //            if( localContent is [AnyObject]? ){
    //                localContent = (_content as! [AnyObject]?)![0]
    //            }
    //
    //            var message: IMessage?  = localContent as? IMessage
    //
    //            if( message != nil ){
    //                //for RemotingMessages only now
    //                if( message is RemotingMessage ){
    //                    list = message!.body as! [AnyObject]?
    //                }
    //            }
    //        }
    //
    //
    //        if( list == nil ){
    //            list = []
    //        }
    //
    //        return list
    //    }
    //    public override var description: String{
    //        get{ return "<\(self.self) = \(self) | targetURI: \(_targetURI) | responseURI: \(_responseURI)>\n\(_data)"}
    //
    //    }
    
    override open var description: String{
        get{ return "<\(self.self) = \(self) | targetURI: \(_target) | responseURI: \(_response)>\n\(String(describing: _content))"}
        
    }
    
}
