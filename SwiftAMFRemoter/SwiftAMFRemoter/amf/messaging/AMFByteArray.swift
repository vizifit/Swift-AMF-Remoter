//
//  AMFByteArray.swift
//  SwiftAMFManager
//
//  Created by Tony Henderson on 1/4/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation

open class AMFByteArray  {
    
    static let sizeOfInt8:Int = 1
    static let sizeOfInt16:Int = 2
    static let sizeOfInt24:Int = 3
    static let sizeOfInt32:Int = 4
    static let sizeOfFloat:Int = 4
    static let sizeOfDouble:Int = 8
    
    public enum Error: Swift.Error {
        case eof
        case parse
        case badResult
    }
    
    init() {
        
    }
    
    
    init(bytes:[UInt8]) {
        self._bytes = bytes
    }
    
    init(data:Data) {
        _bytes = [UInt8](repeating: 0x00, count: data.count)
        (data as NSData).getBytes(&_bytes, length: data.count)
    }
    
    open var bytes:[UInt8]{
        
        get { return _bytes }
        //set { _bytes = newValue }
    }
    
    var _bytes:[UInt8] = []
    
    public var length:Int {
        get {
            return _bytes.count
        }
        set {
            switch true {
            case (_bytes.count < newValue):
                _bytes += [UInt8](repeating: 0, count: newValue - _bytes.count)
            case (newValue < _bytes.count):
                _bytes = Array(_bytes[0..<newValue])
            default:
                break
            }
        }
    }
    
    public var position:Int = 0
    
    public var bytesAvailable:Int {
        return _bytes.count - position
    }
    
    public subscript(i: Int) -> UInt8 {
        get {
            return _bytes[i]
        }
        set {
            _bytes[i] = newValue
        }
    }
    
    
    
    
    /////////////////////////////////
    /// External methods
    /// * Credit to Shogo
    /////////////////////////////////
    @discardableResult
    public func encodeBytes(_ value:[UInt8]) -> Self {
        if (position == _bytes.count) {
            _bytes.append(contentsOf: value)
            position = _bytes.count
            return self
        }
        let length:Int = min(_bytes.count, value.count)
        _bytes[position..<position + length] = value[0..<length]
        if (length == _bytes.count) {
            _bytes.append(contentsOf: value[length..<value.count])
        }
        position += value.count
        return self
    }
    
    open func decodeUTFBytes(_ length:Int) throws -> String {
        guard length <= bytesAvailable else {
            throw AMFCoder.Error.eof
        }
        position += length
        guard let result:String = String(bytes: Array(_bytes[position - length..<position]), encoding: String.Encoding.utf8) else {
            throw AMFCoder.Error.parse
        }
        return result
    }
    
    
    open func decodeUInt8() throws -> UInt8 {
        guard AMFCoder.sizeOfInt8 <= bytesAvailable else {
            throw AMFCoder.Error.eof
        }
        defer {
            position += AMFCoder.sizeOfInt8
        }
        return _bytes[position]
    }
    
    open func decodeUInt16() throws -> UInt16 {
        guard AMFCoder.sizeOfInt16 <= bytesAvailable else {
            throw AMFCoder.Error.eof
        }
       
        position += AMFCoder.sizeOfInt16
        
        let byteArray = Array(_bytes[position - AMFCoder.sizeOfInt16..<position].reversed())
        
        let bigEndianValue = byteArray.withUnsafeBufferPointer {
            ($0.baseAddress!.withMemoryRebound(to: UInt16.self, capacity: 1) { $0 })
            }.pointee
        //let value = UInt16(bigEndian: bigEndianValue)
        
        return bigEndianValue
        
        //return _bytes[position]
    }

    open func decodeUInt32() throws -> UInt32 {
        guard AMFCoder.sizeOfInt32 <= bytesAvailable else {
            throw AMFCoder.Error.eof
        }
        
        position += AMFCoder.sizeOfInt32
        
        let byteArray = Array(_bytes[position - AMFCoder.sizeOfInt32..<position].reversed())
        
        let bigEndianValue = byteArray.withUnsafeBufferPointer {
            ($0.baseAddress!.withMemoryRebound(to: UInt32.self, capacity: 1) { $0 })
            }.pointee
        //let value = UInt16(bigEndian: bigEndianValue)
        
        return bigEndianValue
        
        //return _bytes[position]
    }
    
    open func decodeInt32() throws -> Int32 {
        guard AMFCoder.sizeOfInt32 <= bytesAvailable else {
            throw AMFCoder.Error.eof
        }
        
        position += AMFCoder.sizeOfInt32
    
        return Int32(bytes: Array(_bytes[position - AMFCoder.sizeOfInt32..<position]))
    }


    
    open func decodeDouble() throws -> Double {
        guard AMFCoder.sizeOfDouble <= bytesAvailable else {
            throw AMFCoder.Error.eof
        }
        position += AMFCoder.sizeOfDouble
        
        return Double(bytes: Array(_bytes[position - AMFCoder.sizeOfDouble..<position].reversed()))
    }
}

extension AMFByteArray: CustomStringConvertible {
    // MARK: CustomStringConvertible
    public var description:String {
        return Mirror(reflecting: self).description
    }
}
