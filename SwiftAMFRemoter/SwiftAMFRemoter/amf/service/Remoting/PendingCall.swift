//
//  PendingCall.swift
//  SwiftAMFManager
//
//  Created by Tony Henderson on 1/2/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation


//
//  PendingCall.swift
//  WebApiPOC
//
//  Created by Tony Henderson on 6/21/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation




/// <summary>
/// This type supports the Fluorine infrastructure and is not intended to be used directly from your code.
/// </summary>
open class PendingCall : Call, IPendingServiceCall{
    
    fileprivate var _result:AnyObject
    
    fileprivate var _callbacks:[IPendingServiceCallback]
    
    
    override init() {
        
        _result = "" as AnyObject
        _callbacks = []
        
        super.init()
        
    }
    
    open var result:AnyObject
        {
        get{ return self._result }
        set{ self._result = newValue }
    }
    
    open func registerCallback( _ callback:IPendingServiceCallback)
    {
        _callbacks.append(callback)
        
    }
    
    open func unregisterCallback(_ callback:IPendingServiceCallback)
    {
        // TODO: add remove func for equatable
        // _callbacks.removeObject(callback)
        
        //func delete(element: String) {
        //    _callbacks = _callbacks.filter() { $0 !== callback }
        //}
        
        
    }
    
    open func getCallbacks()->[IPendingServiceCallback]
    {
        
        return _callbacks
    }
    
}
