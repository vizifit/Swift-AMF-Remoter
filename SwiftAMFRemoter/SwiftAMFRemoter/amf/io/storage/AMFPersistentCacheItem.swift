//
//  AMFPersistentCacheItem.swift
//  SwiftAMFRemoter
//
//  Created by Tony Henderson on 10/25/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation
import UIKit

public class AMFPersistantCacheItem: Codable {
    
    public init(cacheKey: String, objectId: String, objectData: [UInt8]) throws {
        
        self.cacheKey = cacheKey
        self.objectId = objectId
        self.objectData = objectData
    }
    
    enum CodingKeys: String, CodingKey {
        case cacheKey = "cacheKey"
        case objectId = "objectId"
        case objectData = "objectData"
    }
    
    public var cacheKey: String
    public var objectId: String
    public var objectData: [UInt8]
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cacheKey = try values.decode(String.self, forKey: .cacheKey)
        objectId = try values.decode(String.self, forKey: .objectId)
        objectData = try values.decode([UInt8].self, forKey: .objectData)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(cacheKey, forKey: .cacheKey)
        try container.encode(objectId, forKey: .objectId)
        try container.encode(objectData, forKey: .objectData)
    }
}


