//
//  BinaryUtils.swift
//  AmfWriterTest
//
//  Created by Tony Henderson on 7/18/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation


open class BinaryUtils{
    
    
//    func binarytotype <T> (_ value: [UInt8], _: T.Type) -> T {
//        
//        return value.withUnsafeBufferPointer {
//            UnsafeRawPointer($0.baseAddress!).load(as: T.self)
//        }
//    }
    
    public static func toByteArray<T>(_ value: T) -> [UInt8] {
        var data = [UInt8](repeating: 0, count: MemoryLayout<T>.size)
        data.withUnsafeMutableBufferPointer {
            UnsafeMutableRawPointer($0.baseAddress!).storeBytes(of: value, as: T.self)
        }
        return data
    }
    
 
    public static func fromByteArray<T>(_ value: ArraySlice<UInt8>, _: T.Type) -> T {
        return value.withUnsafeBufferPointer {
            return UnsafeRawPointer($0.baseAddress!).load(as: T.self)
        }
    }
    
    public static func fromByteArray<T>(_ value: [UInt8], _: T.Type) -> T {
        return value.withUnsafeBufferPointer {
            return UnsafeRawPointer($0.baseAddress!).load(as: T.self)
        }
    }
 
    public static func swiftByteArray(_ data:Data)->[UInt8]
    {
        var bytes = [UInt8](repeating: 0, count: data.count)
        CFDataGetBytes(data as CFData!, CFRangeMake(0, data.count), &bytes)
        return bytes
    }
}
