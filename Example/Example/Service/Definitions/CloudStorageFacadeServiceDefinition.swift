
//

//  SwiftAMFRemoter
//
//  Created by Tony Henderson on 5/16/17.
//  Copyright © 2017 Tony Henderson. All rights reserved.
//

import Foundation
import SwiftAMFRemoter
//@testable import SwiftAMFRemoter
import SwiftAMFRemoter
 
class CloudStorageFacadeServiceDefinition : BaseRemoteServiceDefinition
{
// MARK: Service method definitions
	
	/**

_generateDependencies Service method

Arguments:
 none: There are no parameters for this service.

Service Returns: Please refer to services for return type
*/
public static let  _GENERATE_DEPENDENCIES:CloudStorageFacadeServiceDefinition = CloudStorageFacadeServiceDefinition("_GENERATE_DEPENDENCIES","_generateDependencies","com.vizifit.API.Facade.CloudStorageFacade")

/**

GetAllMediaAssetsByUser Service method

Arguments:
(0) userId: int
 (1) sessionContextKey: String

Service Returns: Please refer to services for return type
*/
public static let  GET_ALL_MEDIA_ASSETS_BY_USER:CloudStorageFacadeServiceDefinition = CloudStorageFacadeServiceDefinition("GET_ALL_MEDIA_ASSETS_BY_USER","GetAllMediaAssetsByUser","com.vizifit.API.Facade.CloudStorageFacade")

/**

SaveMediaAssetByUserId Service method

Arguments:
(0) userId: int
 (1) typeId: int
 (2) contentTypeId: int
 (3) name: String
 (4) description: String
 (5) filedata: String
 (6) blobContainerName: String
 (7) sessionContextKey: String

Service Returns: Please refer to services for return type
*/
public static let  SAVE_MEDIA_ASSET_BY_USER_ID:CloudStorageFacadeServiceDefinition = CloudStorageFacadeServiceDefinition("SAVE_MEDIA_ASSET_BY_USER_ID","SaveMediaAssetByUserId","com.vizifit.API.Facade.CloudStorageFacade")


 
		
	override init(_ value:String,
                  _ methodName:String,
                  _ source:String?=nil,
                  _ modalWaitMessage:String="Loading...",
                  _ modalWait:Bool=true,
                  _ destination:String?=nil,
                  _ endpoint:String?=nil,
                  _ resultNotificationId:String?=nil,
                  _ faultNotificationId:String?=nil,
                  _ alwaysSendNotification:Bool=true) {
        
       	super.init(value,
                   methodName,
                   source,
                   modalWaitMessage,
                   modalWait,
                   destination,
                   endpoint,
                   resultNotificationId,
                   faultNotificationId,
                   alwaysSendNotification)
    }

}
 
