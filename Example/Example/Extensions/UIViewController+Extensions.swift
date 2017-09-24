//
//  UIViewController+Extensions.swift
//  Example
//
//  Created by Tony Henderson on 6/29/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation
import UIKit
import SwiftAMFRemoter

extension UIImage {
    func resizeWithPercentage(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    
    func resizeWithWidth(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    
}

extension UIViewController {
    
     
    static private var remoteServiceManager:IRemoteServiceManager?
    
    static func getRemoteServiceManager() -> IRemoteServiceManager{
        
        if(remoteServiceManager == nil){
            remoteServiceManager = RemoteServiceManager.getInstance() { RemoteServiceManager() }
        }
        
        return remoteServiceManager!
    }
    
    open func registerServiceConnector(_ connector:IServiceConnectorView){
        UIViewController.getRemoteServiceManager().registerServiceConnector(connector)
    }
  
    open func removeServiceConnector(_ connectorId:String){
        UIViewController.getRemoteServiceManager().removeServiceConnector(connectorId)
    }
    
    open func getServiceConnector(_ connectorId:String)->IServiceConnectorView?{
        return UIViewController.getRemoteServiceManager().getServiceConnector(connectorId)
    }
    
    open func hasServiceConnector(_ connectorId:String)->Bool{
        return UIViewController.getRemoteServiceManager().hasServiceConnector(connectorId)
    }
    
        
}
