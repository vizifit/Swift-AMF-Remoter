//
//  PunchJunkieModel.swift
//  PunchJunkies
//
//  Created by Tony Henderson on 6/5/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation
import UIKit


open class PunchJunkieModel : NSObject{
    
    
    public static let sharedInstance = PunchJunkieModel()

    
    //This prevents others from using the default '()' initializer for this class.
    fileprivate override init() {
         
        super.init()
        
    }
    
    public var userFacadeModel:UserFacadeModel = UserFacadeModel()

    
}
