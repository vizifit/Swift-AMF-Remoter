//
//  ASArray.swift
//  SwiftAMFManager
//
//  Created by Tony Henderson on 12/30/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation

// MARK: -
public struct ASArray {
    fileprivate(set) var data:[Any?]
    fileprivate(set) var dict:[String: Any?] = [:]
    
    public var length:Int {
        return data.count
    }
    
    public init(count:Int) {
        self.data = [Any?](repeating: kASUndefined, count: count)
    }
    
    public init(data:[Any?]) {
        self.data = data
    }
}

extension ASArray: ExpressibleByArrayLiteral {
    // MARK: ExpressibleByArrayLiteral
    public init (arrayLiteral elements: Any?...) {
        self = ASArray(data: elements)
    }
    
    public subscript(i: Any) -> Any? {
        get {
            if let i:Int = i as? Int {
                return i < data.count ? data[i] : kASUndefined
            }
            if let i:String = i as? String {
                if let i:Int = Int(i) {
                    return i < data.count ? data[i] : kASUndefined
                }
                return dict[i]!
            }
            return nil
        }
        set {
            if let i:Int = i as? Int {
                if (data.count <= i) {
                    data += [Any?](repeating: kASUndefined, count: i - data.count + 1)
                }
                data[i] = newValue
            }
            if let i:String = i as? String {
                if let i:Int = Int(i) {
                    if (data.count <= i) {
                        data += [Any?](repeating: kASUndefined, count: i - data.count + 1)
                    }
                    data[i] = newValue
                    return
                }
                dict[i] = newValue
            }
        }
    }
}

extension ASArray: CustomStringConvertible {
    // MARK: CustomStringConvertible
    public var description:String {
        return data.description
    }
}

extension ASArray: Equatable {
    // MARK: Equatable
}

public func ==(lhs: ASArray, rhs: ASArray) -> Bool {
    return (lhs.data.description == rhs.data.description) && (lhs.dict.description == rhs.dict.description)
}
