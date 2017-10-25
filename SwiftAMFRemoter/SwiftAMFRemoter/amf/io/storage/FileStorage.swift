//
//  FileStorage.swift
//  SwiftAMFRemoter
//
//  Created by Tony Henderson on 10/24/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//
// Ex:
//    var byteArray:[UInt8] = [1,22,3,4]
//    var cache: AMFPersistantCache = AMFPersistantCache(cacheId: "TestCache", cacheData: [])
//
//    cache.cacheData.append(AMFPersistantCacheItem(cacheKey: "test1", objectId: "testObject", objectData: [1,22,3,4]))
//    cache.cacheData.append(AMFPersistantCacheItem(cacheKey: "test1", objectId: "testObject", objectData: [1,23,3,4]))
//    cache.cacheData.append(AMFPersistantCacheItem(cacheKey: "test1", objectId: "testObject", objectData: [1,24,3,4]))
//
//    let encoder = PropertyListEncoder()
//    encoder.outputFormat = .binary
//
//    let data = try encoder.encode(cache)
//    print(data.count)
//
//    let decoder = PropertyListDecoder()
//    let decodedValue = try decoder.decode(AMFPersistantCache.self, from: data)
//
//    print(decodedValue.cacheId)
//    print(decodedValue.cacheData.count)

import Foundation
import UIKit

public struct AMFPersistantCacheItem {
    
    public enum CodingKeys: String, CodingKey {
        case cacheKey = "cacheKey"
        case objectId = "objectId"
        case objectData = "objectData"
    }
    
    init(cacheKey: String, objectId: String, objectData: [UInt8]) throws {
        
        self.cacheKey = cacheKey
        self.objectId = objectId
        self.objectData = objectData
    }
    
    var cacheKey: String
    var objectId: String
    var objectData: [UInt8]
    
}

extension AMFPersistantCacheItem: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(cacheKey, forKey: .cacheKey)
        try container.encode(objectId, forKey: .objectId)
        try container.encode(objectData, forKey: .objectData)
    }
}

extension AMFPersistantCacheItem: Decodable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cacheKey = try values.decode(String.self, forKey: .cacheKey)
        objectId = try values.decode(String.self, forKey: .objectId)
        objectData = try values.decode([UInt8].self, forKey: .objectData)
    }
}


public struct AMFPersistantCache {
    public enum CodingKeys: String, CodingKey {
        case cacheData = "cacheData"
        case cacheId = "cacheId"
    }
    
    init(cacheId: String, cacheData: [AMFPersistantCacheItem]?) throws { 
        self.cacheId = cacheId
        self.cacheData = cacheData
    }
    
    var cacheId: String
    var cacheData:  [AMFPersistantCacheItem]?
}

extension AMFPersistantCache: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(cacheId, forKey: .cacheId)
        try container.encode(cacheData, forKey: .cacheData)
    }
}

extension AMFPersistantCache: Decodable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cacheId = try values.decode(String.self, forKey: .cacheId)
        cacheData = try values.decode([AMFPersistantCacheItem].self, forKey: .cacheData)
        
    }
}

extension AMFPersistantCache{
    
    func indexOf(_ value:String, isFromClassName:Bool=true) -> Int? {
        
        if(cacheData == nil)
        {
            return nil
        }
        
        let searchValue:String =  value
        
        for (index, data) in (self.cacheData?.enumerated())! {
            
            let dataValue = (isFromClassName) ? data.objectId : data.cacheKey
            
            if dataValue == searchValue  {
                return index
            }
        }
        return nil
    }
//    func indexOf(_ value:String) -> Int? {
//
//        for (index, object) in cacheData {
//            if let cacheItem:AMFPersistantCacheItem = object, object.cacheKey == value {
//                return index
//            }
//        }
//
//        return nil
//    }
}
