//
//  IAMFCoder.swift
//  SwiftAMFManager
//
//  Created by Tony Henderson on 1/4/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation

public protocol IAMFCoder {
    
    var bytes:[UInt8] { get }
    var length:Int { get set }
    var position:Int { get set }
    var bytesAvailable:Int { get }
    subscript(i: Int) -> UInt8 { get set }
    
    @discardableResult
    func encode(_ value:Any?) -> Self
    func encodeValue(_ value:Any?)
    
    func decode() throws -> Any?
    func decodeMessage(_ bytes:[UInt8]?) throws -> AMFMessage
    func decodeValue(_ bytes:[UInt8]?) throws -> Any?
    
    @discardableResult
    func encodeBytes(_ value:[UInt8]) -> Self
    
    @discardableResult
    func encodeInt(_ value:Int, excludeMarker:Bool ) -> Self
    
    @discardableResult
    func encodeDate(_ value:Date) -> Self
    
    @discardableResult
    func encodeDouble(_ value:Double, excludeMarker:Bool) -> Self
    func decodeDouble() throws -> Double
    
    @discardableResult
    func encodeBool(_ value: Bool) -> Self
    
    @discardableResult
    func encodeUTFBytes(_ value:String) -> Self
    func decodeUTFBytes(_ length:Int) throws -> String
    
    @discardableResult
    func encodeBigEndian(_ bytes:[UInt8]) -> Self
    
    @discardableResult
    func clear() -> Self
   
    func resetReferences()
    func resetPosition()
    
    func addClassMap(map:ClassMap)
    
    func removeAllClassMaps()
    
    func encodeMessageHeader(header:AMFMessageHeader)
    func encodeMessage( message: AMFMessage)

}
