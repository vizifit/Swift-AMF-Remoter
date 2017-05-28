//
//  IDictionaryItem.swift
//  SwiftAMF
//
//  Created by Tony Henderson on 5/1/16.
//  Copyright © 2016 Tony Henderson. All rights reserved.
//

import Foundation

public protocol IDictionaryItem{
    
    
    var key:String {get}
    
    var isUpdateable:Bool {get}
    
}