
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
 
class UserFacadeServiceDefinition : BaseRemoteServiceDefinition
{
// MARK: Service method definitions
	
	/**

CreateNetwork Service method

Arguments:
(0) token: String
 (1) userId: int
 (2) networkTypeId: int
 (3) networkAccountId: String
 (4) networkAuthToken: String

Service Returns: Please refer to services for return type
*/
open static let  CREATE_NETWORK:UserFacadeServiceDefinition = UserFacadeServiceDefinition("CREATE_NETWORK","CreateNetwork","com.vizifit.API.Facade.UserFacade")

/**

CreateUserByEmail Service method

Arguments:
(0) brandId: int
 (1) firstName: String
 (2) lastName: String
 (3) email: String
 (4) userTypeId: int
 (5) password: String

Service Returns: Please refer to services for return type
*/
open static let  CREATE_USER_BY_EMAIL:UserFacadeServiceDefinition = UserFacadeServiceDefinition("CREATE_USER_BY_EMAIL","CreateUserByEmail","com.vizifit.API.Facade.UserFacade")

/**

CreateUserByNetwork Service method

Arguments:
(0) brandId: int
 (1) firstName: String
 (2) lastName: String
 (3) username: String
 (4) email: String
 (5) userTypeId: int
 (6) networkTypeId: int
 (7) networkAccountId: String
 (8) networkAuthToken: String

Service Returns: Please refer to services for return type
*/
open static let  CREATE_USER_BY_NETWORK:UserFacadeServiceDefinition = UserFacadeServiceDefinition("CREATE_USER_BY_NETWORK","CreateUserByNetwork","com.vizifit.API.Facade.UserFacade")

/**

GetAppConfigurationData Service method

Arguments:
 none: There are no parameters for this service.

Service Returns: Please refer to services for return type
*/
open static let  GET_APP_CONFIGURATION_DATA:UserFacadeServiceDefinition = UserFacadeServiceDefinition("GET_APP_CONFIGURATION_DATA","GetAppConfigurationData","com.vizifit.API.Facade.UserFacade")

/**

GetBrands Service method

Arguments:
(0) token: String

Service Returns: Please refer to services for return type
*/
open static let  GET_BRANDS:UserFacadeServiceDefinition = UserFacadeServiceDefinition("GET_BRANDS","GetBrands","com.vizifit.API.Facade.UserFacade")

/**

GetException Service method

Arguments:
 none: There are no parameters for this service.

Service Returns: Please refer to services for return type
*/
open static let  GET_EXCEPTION:UserFacadeServiceDefinition = UserFacadeServiceDefinition("GET_EXCEPTION","GetException","com.vizifit.API.Facade.UserFacade")

/**

GetInstructors Service method

Arguments:
(0) token: String

Service Returns: Please refer to services for return type
*/
open static let  GET_INSTRUCTORS:UserFacadeServiceDefinition = UserFacadeServiceDefinition("GET_INSTRUCTORS","GetInstructors","com.vizifit.API.Facade.UserFacade")

/**

GetNetworkTypes Service method

Arguments:
(0) token: String

Service Returns: Please refer to services for return type
*/
open static let  GET_NETWORK_TYPES:UserFacadeServiceDefinition = UserFacadeServiceDefinition("GET_NETWORK_TYPES","GetNetworkTypes","com.vizifit.API.Facade.UserFacade")

/**

GetUserByEmail Service method

Arguments:
(0) token: String
 (1) email: String

Service Returns: Please refer to services for return type
*/
open static let  GET_USER_BY_EMAIL:UserFacadeServiceDefinition = UserFacadeServiceDefinition("GET_USER_BY_EMAIL","GetUserByEmail","com.vizifit.API.Facade.UserFacade")

/**

GetUserById Service method

Arguments:
(0) token: String
 (1) id: int

Service Returns: Please refer to services for return type
*/
open static let  GET_USER_BY_ID:UserFacadeServiceDefinition = UserFacadeServiceDefinition("GET_USER_BY_ID","GetUserById","com.vizifit.API.Facade.UserFacade")

/**

GetUserTypes Service method

Arguments:
(0) token: String

Service Returns: Please refer to services for return type
*/
open static let  GET_USER_TYPES:UserFacadeServiceDefinition = UserFacadeServiceDefinition("GET_USER_TYPES","GetUserTypes","com.vizifit.API.Facade.UserFacade")

/**

LoginByEmail Service method

Arguments:
(0) email: String
 (1) password: String

Service Returns: Please refer to services for return type
*/
open static let  LOGIN_BY_EMAIL:UserFacadeServiceDefinition = UserFacadeServiceDefinition("LOGIN_BY_EMAIL","LoginByEmail","com.vizifit.API.Facade.UserFacade")

/**

LoginByNetwork Service method

Arguments:
(0) networkTypeId: int
 (1) networkAccountId: String
 (2) networkAuthToken: String

Service Returns: Please refer to services for return type
*/
open static let  LOGIN_BY_NETWORK:UserFacadeServiceDefinition = UserFacadeServiceDefinition("LOGIN_BY_NETWORK","LoginByNetwork","com.vizifit.API.Facade.UserFacade")

/**

NetworkUserExists Service method

Arguments:
(0) email: String
 (1) networkTypeId: int
 (2) networkAccountId: String

Service Returns: Please refer to services for return type
*/
open static let  NETWORK_USER_EXISTS:UserFacadeServiceDefinition = UserFacadeServiceDefinition("NETWORK_USER_EXISTS","NetworkUserExists","com.vizifit.API.Facade.UserFacade")

/**

RemoveNetwork Service method

Arguments:
(0) token: String
 (1) userId: int
 (2) networkId: int
 (3) networkAuthToken: String

Service Returns: Please refer to services for return type
*/
open static let  REMOVE_NETWORK:UserFacadeServiceDefinition = UserFacadeServiceDefinition("REMOVE_NETWORK","RemoveNetwork","com.vizifit.API.Facade.UserFacade")

/**

ResetPassword Service method

Arguments:
(0) email: String

Service Returns: Please refer to services for return type
*/
open static let  RESET_PASSWORD:UserFacadeServiceDefinition = UserFacadeServiceDefinition("RESET_PASSWORD","ResetPassword","com.vizifit.API.Facade.UserFacade")

/**

UpdateNetwork Service method

Arguments:
(0) token: String
 (1) userId: int
 (2) networkId: int
 (3) networkAuthToken: String

Service Returns: Please refer to services for return type
*/
open static let  UPDATE_NETWORK:UserFacadeServiceDefinition = UserFacadeServiceDefinition("UPDATE_NETWORK","UpdateNetwork","com.vizifit.API.Facade.UserFacade")

/**

UpdatePassword Service method

Arguments:
(0) token: String
 (1) userId: int
 (2) password: String

Service Returns: Please refer to services for return type
*/
open static let  UPDATE_PASSWORD:UserFacadeServiceDefinition = UserFacadeServiceDefinition("UPDATE_PASSWORD","UpdatePassword","com.vizifit.API.Facade.UserFacade")

/**

UpdateProfile Service method

Arguments:
(0) token: String
 (1) profileId: int
 (2) dob: Date
 (3) gender: String
 (4) height: int
 (5) weight: int
 (6) unitOfMeasure: String
 (7) tagline: String

Service Returns: Please refer to services for return type
*/
open static let  UPDATE_PROFILE:UserFacadeServiceDefinition = UserFacadeServiceDefinition("UPDATE_PROFILE","UpdateProfile","com.vizifit.API.Facade.UserFacade")

/**

UpdateProfileImageById Service method

Arguments:
(0) token: String
 (1) profileId: int
 (2) thumbnailImageUrl: String
 (3) imageUrl: String

Service Returns: Please refer to services for return type
*/
open static let  UPDATE_PROFILE_IMAGE_BY_ID:UserFacadeServiceDefinition = UserFacadeServiceDefinition("UPDATE_PROFILE_IMAGE_BY_ID","UpdateProfileImageById","com.vizifit.API.Facade.UserFacade")

/**

UpdateUser Service method

Arguments:
(0) token: String
 (1) userId: int
 (2) firstname: String
 (3) lastname: String
 (4) username: String
 (5) email: String

Service Returns: Please refer to services for return type
*/
open static let  UPDATE_USER:UserFacadeServiceDefinition = UserFacadeServiceDefinition("UPDATE_USER","UpdateUser","com.vizifit.API.Facade.UserFacade")

/**

UserExists Service method

Arguments:
(0) email: String

Service Returns: Please refer to services for return type
*/
open static let  USER_EXISTS:UserFacadeServiceDefinition = UserFacadeServiceDefinition("USER_EXISTS","UserExists","com.vizifit.API.Facade.UserFacade")

/**

UserExistsForNetwork Service method

Arguments:
(0) email: String
 (1) networkTypeId: int
 (2) networkAccountId: String

Service Returns: Please refer to services for return type
*/
open static let  USER_EXISTS_FOR_NETWORK:UserFacadeServiceDefinition = UserFacadeServiceDefinition("USER_EXISTS_FOR_NETWORK","UserExistsForNetwork","com.vizifit.API.Facade.UserFacade")


 
		
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
 
