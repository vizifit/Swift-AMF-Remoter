//
//  IServiceConfiguration.swift
//  SwiftAMFRemoter
//
//  Created by Tony Henderson on 7/17/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation

public protocol IRemoteServiceConfiguration  {
    
    func addServiceConfiguration(_ configuration:RemoteServiceConfiguration)
    
    func removeServiceConfiguration(_ key:String)
    
    func getServiceConfiguration(_ key:String)->RemoteServiceConfiguration?
    
    func hasServiceConfiguration(_ key:String)->Bool
    
}
