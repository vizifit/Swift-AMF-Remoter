//
//  IRemoteServiceManager.swift
//  SwiftAMFRemoter
//
//  Created by Tony Henderson on 7/17/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation

public protocol IRemoteServiceManager : IServiceConnector, IRemoteServiceConfiguration  {

    func addClassMap(_ map:ClassMap)
    
    func removeAllClassMaps()
    
    func invokeServiceCall(_ serviceConfigKey:String, serviceDefinition:IAMFServiceDefinition, args:Any?... )
    
    func invokeGroupedServiceCall(_ serviceConfigKey:String, requestGroup:AMFServiceRequestGroup)
    
    func toggleDebugMode(_ isEnabled:Bool)
    
     var debugMode:Bool { get  }
}
