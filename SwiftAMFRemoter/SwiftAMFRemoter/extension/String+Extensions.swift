//
//  UtilExtensions.swift
//  WebApiPOC
//
//  Created by Tony Henderson on 6/18/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation


extension String {
    var length : Int {
        return self.count
    }
    
    func replaceCharacters(target: String, withString: String, range:Range<String.Index>? = nil) -> String{
        return self.replacingOccurrences(of: target, with: withString, options: .literal, range: range)
    }
    
    func endsWith(_ suffix: String) -> Bool {
        return hasSuffix(suffix)
    }
    
    public func indexOf(_ char: Character) -> Int? {
    
        if let idx = characters.index(of: char) {
            return characters.distance(from: startIndex, to: idx)
        }
        return nil
    }
    
    func lastIndexOf(_ target: String) -> Int? {
        if let range = self.range(of: target, options: .backwards) {
            return characters.distance(from: startIndex, to: range.lowerBound)
        } else {
            return nil
        }
    }
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(_ from: Int) -> String {
        let start = index(startIndex, offsetBy: from)
        return String(self[start ..< endIndex])
    }
    
//    func substring(from: Int) -> String {
//        let fromIndex = index(from: from)
//        return substring(from: fromIndex)
//    }
    
    func substring(to: Int) -> String {
        let start = index(startIndex, offsetBy: 0)
        let toIndex = index(from: to)
        return String(self[start ..< toIndex])
        
        //return substring(to: toIndex)
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        
        return String(self[startIndex ..< endIndex])
        
        //return substring(with: startIndex..<endIndex)
    }
    
    func substring(_ startIndex: Int, length: Int) -> String {
        let start = self.characters.index(self.startIndex, offsetBy: startIndex)
        let end = self.characters.index(self.startIndex, offsetBy: startIndex + length)
        return String(self[start..<end])
    }

}


 
