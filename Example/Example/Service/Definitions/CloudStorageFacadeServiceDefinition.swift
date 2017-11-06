
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

GetAllMediaAssetsByUser Service method

Arguments:
(0) userId: int

Service Returns: Please refer to services for return type
*/
open static let  GET_ALL_MEDIA_ASSETS_BY_USER:CloudStorageFacadeServiceDefinition = CloudStorageFacadeServiceDefinition("GET_ALL_MEDIA_ASSETS_BY_USER","GetAllMediaAssetsByUser","com.vizifit.API.Facade.CloudStorageFacade")

/**

SaveMediaAssetByUserId Service method

Arguments:
(0) token: String
 (1) userId: int
 (2) typeId: int
 (3) contentTypeId: int
 (4) name: String
 (5) description: String
 (6) filedata: String
 (7) blobContainerName: String

Service Returns: Please refer to services for return type
*/
open static let  SAVE_MEDIA_ASSET_BY_USER_ID:CloudStorageFacadeServiceDefinition = CloudStorageFacadeServiceDefinition("SAVE_MEDIA_ASSET_BY_USER_ID","SaveMediaAssetByUserId","com.vizifit.API.Facade.CloudStorageFacade")


 
		
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
 
