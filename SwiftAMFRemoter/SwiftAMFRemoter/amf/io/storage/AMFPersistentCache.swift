//
//  AMFPersistentCache.swift
//  SwiftAMFRemoter
//
//  Created by Tony Henderson on 10/25/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation

public class AMFPersistantCache:Codable {
    
    public init(cacheId: String, cacheData: [AMFPersistantCacheItem]) throws {
        self.cacheId = cacheId
        self.cacheData = cacheData
    }
    
    enum CodingKeys: String, CodingKey {
        case cacheData = "cacheData"
        case cacheId = "cacheId"
    }
    
    public var cacheId: String
    public var cacheData:  [AMFPersistantCacheItem]
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(cacheId, forKey: .cacheId)
        try container.encode(cacheData, forKey: .cacheData)
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cacheId = try values.decode(String.self, forKey: .cacheId)
        cacheData = try values.decode([AMFPersistantCacheItem].self, forKey: .cacheData)
        
    }
}



extension AMFPersistantCache{
    
    
    func indexOf(_ value:String ) -> Int? {
        
        for (index, cacheItem) in self.cacheData.enumerated() {
            
            if(cacheItem.cacheKey == value){
                return index
            }
            //                if let cacheItem:AMFPersistantCacheItem = object, cacheItem.cacheKey == value {
            //                    return index
            //                }
        }
        
        return nil
    }
    
    func indexOf(_ value:String, isFromClassName:Bool=false) -> Int? {

        for (index, cacheItem) in self.cacheData.enumerated() {
            
            let dataValue = (isFromClassName) ? cacheItem.objectId : cacheItem.cacheKey

            if dataValue == value  {
                return index
            }
        }
        return nil
    }
//    func indexOf(_ value:String, isFromClassName:Bool=true) -> Int? {
//
//        if(cacheData == nil)
//        {
//            return nil
//        }
//
//        let searchValue:String =  value
//
//        var index:Int = 0
//        for cacheDataItem in 0..<self.cacheData!.count  {
//
//            //print("Item \(index + 1): \(value)")
//            let dataValue = (isFromClassName) ? cacheDataItem.objectId : cacheDataItem.cacheKey
//
//            if dataValue == searchValue  {
//                return index
//            }
//        }
//        return nil
}

