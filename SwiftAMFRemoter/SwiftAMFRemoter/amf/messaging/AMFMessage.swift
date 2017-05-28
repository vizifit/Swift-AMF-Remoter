//
//  AMFMessage.swift
//  SwiftAMFManager
//
//  Created by Tony Henderson on 1/2/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation

//: AMF Message Class
open class AMFMessage: BasicObject {
    
    
    fileprivate var _version:ObjectEncoding
    fileprivate var _headers:[AMFMessageHeader]
    fileprivate var _bodies:[AMFMessageBody]
    
    open var remoteConfigurationKey:String?
    open var serviceDefinition:IAMFServiceDefinition?
    
    public enum ResultType : Int {
        case success = 0
        case serverError = 1
        case clientError = 2
        case unknownError = 3
    }
    
    convenience required public init() {
        
        self.init()
        
    }
    
    /// <summary>
    /// Initializes a new instance of the AMFMessage class.
    /// </summary>
    /// <param name="version"></param>
    init(version encoding:ObjectEncoding) {
        
        _version = encoding
        //_data = nil
        _headers = []
        _bodies = []
        
        super.init()
        
    }
    
    
    /// <summary>
    /// Adds a body to the AMF packet.
    /// </summary>
    /// <param name="body">The body object to add.</param>
    open func addBody(_ body:AMFMessageBody)
    {
        self._bodies.append(body)
    }
    /// <summary>
    /// Adds a header to the AMF packet.
    /// </summary>
    /// <param name="header">The header object to add.</param>
    open func addHeader(_ header:AMFMessageHeader )
    {
        self._headers.append(header)
    }
    
    /// <summary>
    /// Gets the AMF packet version.
    /// </summary>
    open var version:ObjectEncoding{
        
        get{return self._version}
        set{ self._version = newValue}
        
    }
    
    /// <summary>
    /// Gets the body count.
    /// </summary>
    open func bodyCount() -> Int {
        return _bodies.count
    }
    
    /// <summary>
    /// Gets a readonly collection of AMF bodies.
    /// </summary>
    open var bodies:[AMFMessageBody] {
        
        get{
            
            return self._bodies
            
        }
        //set{ self._bodies = newValue}
        
    }
    
    /// <summary>
    /// Gets the header count.
    /// </summary>
    open func headerCount() -> Int {
        return _headers.count
    }
    
    //: TODO Make read-only
    //    public var headers:[AMFMessageHeader]? {
    //
    //        get{return self._headers}
    //        //set{ self._headers = newValue}
    //
    //    }
    
    
    /// <summary>
    /// Gets a single AMF body object by index.
    /// </summary>
    /// <param name="index">The numerical index of the body.</param>
    /// <returns>The body referenced by index.</returns>
    open func getBodyAt(_ index: Int) -> AMFMessageBody {
        
        return (_bodies[index] as AMFMessageBody?)!
    }
    
    /// <summary>
    /// Gets a single AMF header object by index.
    /// </summary>
    /// <param name="index">The numerical index of the header.</param>
    /// <returns>The header referenced by index.</returns>
    open func getHeaderAt(_ index: Int) -> AMFMessageHeader? {
        
        // we behave nicely if everyhing seems to be inside the valid bounds
        if (index >= _headers.count && index < self.bodyCount()) {
            return nil
        }
        
        return (_headers[index] as AMFMessageHeader?)
    }
    
    /// <summary>
    /// Gets the value of a single AMF header object by name.
    /// </summary>
    /// <param name="header">The name of the header.</param>
    /// <returns>The header referenced by name.</returns>
    open func getHeader(_ key: String) -> AMFMessageHeader? {
        
        return AMFMessageUtil.getHeader(key, headers: self._headers)
        //        for header in self._headers!{
        //
        //            if(header.name == key){
        //
        //                return header
        //            }
        //        }
        //
        //        return nil
    }
    
    /// <summary>
    /// Removes the named header from teh AMF packet.
    /// </summary>
    /// <param name="header">The name of the header.</param>
    open func removeHeader(_ key: String){
        
        var index:Int = 0
        
        for header in self._headers{
            
            index += 1
            
            if(header.name == key){
                
                _headers.remove(at: index)
                
                return
            }
        }
        
    }
    
    
    open func getResult(_ index: Int = 0) throws -> (ResultType, Any?) {
        
        var result:Any? = nil
        var type:ResultType = .unknownError
        
        if(_bodies.count > 0 && ((_bodies.count-1) >= index)){
            
            let messageBody = getBodyAt(index)
            
            guard let messageResultSet:[Any?] = messageBody.content! as? [Any?] else {
                throw AMFCoder.Error.badResult
            }
            
            if(messageResultSet.count == 0){
                throw AMFCoder.Error.badResult
            }
            
            let messageResult = messageResultSet[0]!
            switch messageResult
            {
                
            case _ as AcknowledgeMessage:
                type = .success
                result = (messageResult as? AcknowledgeMessage)?.body
                break
                
            case _ as ErrorMessage:
                type = .serverError
                result = (messageResult as? ErrorMessage)?.body
                break
                
            default:
                result = messageResult
                type = .unknownError
                break

            }
        }
       
        return (type, result)
        
    
    }
    
    //    public func addBodyWithTargetURI(targetURI: String, responseURI: String, data: AnyObject) {
    //        let body: AMFMessageBody = AMFMessageBody()
    //        body.targetURI = targetURI
    //        body.responseURI = responseURI
    //        body.data = data as? NSData
    //
    //        _bodies?.append(body)
    //    }
    //
    //    public func addHeaderWithName(name: String, mustUnderstand: Bool, data: AnyObject) {
    //        let header: AMFMessageHeader = AMFMessageHeader()
    //        header.name = name
    //        header.mustUnderstand = mustUnderstand
    //        header.data = data as? NSData
    //
    //        _headers?.append(header)
    //    }
    
    
    
    //    public func mergeActionMessage(message: AMFActionMessage) {
    ////        _headers.addObjectsFromArray(message.headers)
    ////        _bodies.addObjectsFromArray(message.bodies)
    //    }
    
    
    
}
