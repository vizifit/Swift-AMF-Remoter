//
//  AMFMessageHeader.swift
//  SwiftAMFManager
//
//  Created by Tony Henderson on 1/2/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation

/// <summary>
/// This type supports the Fluorine infrastructure and is not intended to be used directly from your code.
/// </summary>
open class AMFMessageHeader:BasicObject
{
    /// <summary>
    /// This member supports the Fluorine infrastructure and is not intended to be used directly from your code.
    /// </summary>
    public static let CredentialsHeader = "Credentials"
    /// <summary>
    /// This member supports the Fluorine infrastructure and is not intended to be used directly from your code.
    /// DSid stands for Data Set Identification. It represents a Guid used to identify the remote client.
    /// </summary>
    public static let AMFDSIdHeader = "DSId"
    /// <summary>
    /// This member supports the Fluorine infrastructure and is not intended to be used directly from your code.
    /// </summary>
    public static let DebugHeader = "amf_server_debug"
    /// <summary>
    /// This member supports the Fluorine infrastructure and is not intended to be used directly from your code.
    /// </summary>
    public static let ServiceBrowserHeader = "DescribeService"
    /// <summary>
    /// This member supports the Fluorine infrastructure and is not intended to be used directly from your code.
    /// </summary>
    public static let ClearedCredentials = "ClearedCredentials"
    /// <summary>
    /// This member supports the Fluorine infrastructure and is not intended to be used directly from your code.
    /// </summary>
    public static let CredentialsIdHeader = "CredentialsId"
    /// <summary>
    /// This member supports the Fluorine infrastructure and is not intended to be used directly from your code.
    /// </summary>
    public static let RequestPersistentHeader = "RequestPersistentHeader"
    /// <summary>
    /// This member supports the Fluorine infrastructure and is not intended to be used directly from your code.
    /// </summary>
    public static let UrlAppendHeader = "AppendToGatewayUrl"
    
    fileprivate var _content: AnyObject? // Maybe NSObject?
    
    fileprivate var _mustUnderstand: Bool = false
    
    fileprivate var _name: String?
    
    /// <summary>
    /// Initializes a new instance of the AMFMessageHeader class.
    /// </summary>
    /// <param name="name"></param>
    /// <param name="mustUnderstand"></param>
    /// <param name="content"></param>
    
    init( name:String, mustUnderstand:Bool, content:AnyObject){
        
        self._name = name;
        self._mustUnderstand = mustUnderstand;
        self._content = content;
    }
    
    required public init() {
        fatalError("init() has not been implemented")
    }
    
    open var content:AnyObject? {
        
        get{return self._content}
        
    }
    
    open var name:String? {
        
        get{return self._name}
        
    }
    
    open var mustUnderstand:Bool {
        
        get{return self._mustUnderstand}
        
    }
    
    /// <summary>
    /// This member supports the Fluorine infrastructure and is not intended to be used directly from your code.
    /// </summary>
    open var isClearedCredentials:Bool
        {
        get
        {
            if( _content is String ){
                
                return (_content as! String) == AMFMessageHeader.ClearedCredentials
            }
            
            return false;
        }
    }
    
    
    override open var description: String{
        get{return "<\(self.self) = \(self) | name: \(String(describing: _name)) | mustUnderstand: \(_mustUnderstand)>\n\(String(describing: _content))"}
        
    }
   }
