//
//  #ReplaceClassName#.swift
//  SwiftAMFRemoter
//
//  Created by #ReplaceCompany# on #ReplaceDate#.
//  Copyright © #ReplaceYear# by #ReplaceCompany#. All rights reserved.
//

import Foundation
import SwiftAMFRemoter


open class DataTypeInitializer  {
 
 	open static func registerClassAliases(){
 	
 		
		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "ConfigurationData", classAlias: "com.vizifit.API.Common.ConfigurationData"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzException", classAlias: "com.vizifit.API.Common.VzException"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "ActivityFacadeModel", classAlias: "com.vizifit.API.Facade.ActivityFacadeModel"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "CloudStorageFacadeModel", classAlias: "com.vizifit.API.Facade.CloudStorageFacadeModel"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "UserFacadeModel", classAlias: "com.vizifit.API.Facade.UserFacadeModel"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "ActivityConfigurationData", classAlias: "com.vizifit.API.Model.Activity.ActivityConfigurationData"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzActivity", classAlias: "com.vizifit.API.Model.Activity.VzActivity"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzActivityAttributeType", classAlias: "com.vizifit.API.Model.Activity.VzActivityAttributeType"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzActivityEquipmentType", classAlias: "com.vizifit.API.Model.Activity.VzActivityEquipmentType"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzActivityGoalType", classAlias: "com.vizifit.API.Model.Activity.VzActivityGoalType"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzActivityItem", classAlias: "com.vizifit.API.Model.Activity.VzActivityItem"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzActivityItemList", classAlias: "com.vizifit.API.Model.Activity.VzActivityItemList"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzActivityItemListAssignment", classAlias: "com.vizifit.API.Model.Activity.VzActivityItemListAssignment"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzActivityItemThemeType", classAlias: "com.vizifit.API.Model.Activity.VzActivityItemThemeType"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzActivityLevelType", classAlias: "com.vizifit.API.Model.Activity.VzActivityLevelType"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzActivityScheduleItem", classAlias: "com.vizifit.API.Model.Activity.VzActivityScheduleItem"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzActivityThemeType", classAlias: "com.vizifit.API.Model.Activity.VzActivityThemeType"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzActivityType", classAlias: "com.vizifit.API.Model.Activity.VzActivityType"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "BaseContent", classAlias: "com.vizifit.API.Model.Base.BaseContent"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "BaseContentType", classAlias: "com.vizifit.API.Model.Base.BaseContentType"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "BaseMedia", classAlias: "com.vizifit.API.Model.Base.BaseMedia"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "BaseMediaContent", classAlias: "com.vizifit.API.Model.Base.BaseMediaContent"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "BaseScheduleItem", classAlias: "com.vizifit.API.Model.Base.BaseScheduleItem"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "EntityBase", classAlias: "com.vizifit.API.Model.Base.EntityBase"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzBrand", classAlias: "com.vizifit.API.Model.Brand.VzBrand"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzBrandMembership", classAlias: "com.vizifit.API.Model.Brand.VzBrandMembership"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "UnitMetricEnum", classAlias: "com.vizifit.API.Model.Common.Enum.enum.UnitMetricEnum"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzServiceError", classAlias: "com.vizifit.API.Model.Common.VzServiceError"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzMediaAsset", classAlias: "com.vizifit.API.Model.Media.VzMediaAsset"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzMediaAssetType", classAlias: "com.vizifit.API.Model.Media.VzMediaAssetType"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzMediaCategoryType", classAlias: "com.vizifit.API.Model.Media.VzMediaCategoryType"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzMediaContentType", classAlias: "com.vizifit.API.Model.Media.VzMediaContentType"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzNetworkAccount", classAlias: "com.vizifit.API.Model.Network.VzNetworkAccount"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzNetworkMessage", classAlias: "com.vizifit.API.Model.Network.VzNetworkMessage"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzNetworkMessageType", classAlias: "com.vizifit.API.Model.Network.VzNetworkMessageType"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzNetworkRelationship", classAlias: "com.vizifit.API.Model.Network.VzNetworkRelationship"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzNetworkRelationshipType", classAlias: "com.vizifit.API.Model.Network.VzNetworkRelationshipType"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzNetworkType", classAlias: "com.vizifit.API.Model.Network.VzNetworkType"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzProgram", classAlias: "com.vizifit.API.Model.Program.VzProgram"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzProgramActivityAssignment", classAlias: "com.vizifit.API.Model.Program.VzProgramActivityAssignment"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzProgramStatusType", classAlias: "com.vizifit.API.Model.Program.VzProgramStatusType"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzScheduleDayType", classAlias: "com.vizifit.API.Model.Schedule.VzScheduleDayType"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzScheduleTimeType", classAlias: "com.vizifit.API.Model.Schedule.VzScheduleTimeType"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "UserContext", classAlias: "com.vizifit.API.Model.User.UserContext"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzAccount", classAlias: "com.vizifit.API.Model.User.VzAccount"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzProfile", classAlias: "com.vizifit.API.Model.User.VzProfile"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzSession", classAlias: "com.vizifit.API.Model.User.VzSession"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzUser", classAlias: "com.vizifit.API.Model.User.VzUser"))

		SwiftAMFRemoterManager.sharedInstance.addClassMap( ClassMap(className: "VzUserType", classAlias: "com.vizifit.API.Model.User.VzUserType"))

 	}

    
}
