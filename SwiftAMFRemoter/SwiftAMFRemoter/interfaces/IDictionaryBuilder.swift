//
//  IDictionaryBuilder.swift
//  SwiftAMF
//
//  Created by Tony Henderson on 5/2/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation

public protocol IDictionaryBuilder{
    
    
    func addItem(_ item:IDictionaryItem, args:[Any]?...)
    
    func getItem(_ key:String, args:[Any]?...)-> [Any]?;

    func itemExists(_ key:String)->Bool;
    
    func removeItem(_ key:String, args:[Any]?...);
    
}
