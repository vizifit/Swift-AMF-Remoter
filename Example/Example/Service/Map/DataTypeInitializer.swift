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
 	
        let mgr = RemoteServiceManager.getInstance() { RemoteServiceManager() }
        
		mgr.addClassMap( ClassMap(className: "ConfigurationData", classAlias: "com.vizifit.API.Common.ConfigurationData"))

		mgr.addClassMap( ClassMap(className: "VzException", classAlias: "com.vizifit.API.Common.VzException"))

		mgr.addClassMap( ClassMap(className: "ActivityFacadeModel", classAlias: "com.vizifit.API.Facade.ActivityFacadeModel"))

		mgr.addClassMap( ClassMap(className: "CloudStorageFacadeModel", classAlias: "com.vizifit.API.Facade.CloudStorageFacadeModel"))

		mgr.addClassMap( ClassMap(className: "UserFacadeModel", classAlias: "com.vizifit.API.Facade.UserFacadeModel"))

		mgr.addClassMap( ClassMap(className: "ActivityConfigurationData", classAlias: "com.vizifit.API.Model.Activity.ActivityConfigurationData"))

		mgr.addClassMap( ClassMap(className: "VzActivity", classAlias: "com.vizifit.API.Model.Activity.VzActivity"))

		mgr.addClassMap( ClassMap(className: "VzActivityAttributeType", classAlias: "com.vizifit.API.Model.Activity.VzActivityAttributeType"))

		mgr.addClassMap( ClassMap(className: "VzActivityEquipmentType", classAlias: "com.vizifit.API.Model.Activity.VzActivityEquipmentType"))

		mgr.addClassMap( ClassMap(className: "VzActivityGoalType", classAlias: "com.vizifit.API.Model.Activity.VzActivityGoalType"))

		mgr.addClassMap( ClassMap(className: "VzActivityItem", classAlias: "com.vizifit.API.Model.Activity.VzActivityItem"))

		mgr.addClassMap( ClassMap(className: "VzActivityItemList", classAlias: "com.vizifit.API.Model.Activity.VzActivityItemList"))

		mgr.addClassMap( ClassMap(className: "VzActivityItemListAssignment", classAlias: "com.vizifit.API.Model.Activity.VzActivityItemListAssignment"))

		mgr.addClassMap( ClassMap(className: "VzActivityItemThemeType", classAlias: "com.vizifit.API.Model.Activity.VzActivityItemThemeType"))

		mgr.addClassMap( ClassMap(className: "VzActivityLevelType", classAlias: "com.vizifit.API.Model.Activity.VzActivityLevelType"))

		mgr.addClassMap( ClassMap(className: "VzActivityScheduleItem", classAlias: "com.vizifit.API.Model.Activity.VzActivityScheduleItem"))

		mgr.addClassMap( ClassMap(className: "VzActivityThemeType", classAlias: "com.vizifit.API.Model.Activity.VzActivityThemeType"))

		mgr.addClassMap( ClassMap(className: "VzActivityType", classAlias: "com.vizifit.API.Model.Activity.VzActivityType"))

		mgr.addClassMap( ClassMap(className: "BaseContent", classAlias: "com.vizifit.API.Model.Base.BaseContent"))

		mgr.addClassMap( ClassMap(className: "BaseContentType", classAlias: "com.vizifit.API.Model.Base.BaseContentType"))

		mgr.addClassMap( ClassMap(className: "BaseMedia", classAlias: "com.vizifit.API.Model.Base.BaseMedia"))

		mgr.addClassMap( ClassMap(className: "BaseMediaContent", classAlias: "com.vizifit.API.Model.Base.BaseMediaContent"))

		mgr.addClassMap( ClassMap(className: "BaseScheduleItem", classAlias: "com.vizifit.API.Model.Base.BaseScheduleItem"))

		mgr.addClassMap( ClassMap(className: "EntityBase", classAlias: "com.vizifit.API.Model.Base.EntityBase"))

		mgr.addClassMap( ClassMap(className: "VzBrand", classAlias: "com.vizifit.API.Model.Brand.VzBrand"))

		mgr.addClassMap( ClassMap(className: "VzBrandMembership", classAlias: "com.vizifit.API.Model.Brand.VzBrandMembership"))

		mgr.addClassMap( ClassMap(className: "UnitMetricEnum", classAlias: "com.vizifit.API.Model.Common.Enum.enum.UnitMetricEnum"))

		mgr.addClassMap( ClassMap(className: "VzServiceError", classAlias: "com.vizifit.API.Model.Common.VzServiceError"))

		mgr.addClassMap( ClassMap(className: "VzMediaAsset", classAlias: "com.vizifit.API.Model.Media.VzMediaAsset"))

		mgr.addClassMap( ClassMap(className: "VzMediaAssetType", classAlias: "com.vizifit.API.Model.Media.VzMediaAssetType"))

		mgr.addClassMap( ClassMap(className: "VzMediaCategoryType", classAlias: "com.vizifit.API.Model.Media.VzMediaCategoryType"))

		mgr.addClassMap( ClassMap(className: "VzMediaContentType", classAlias: "com.vizifit.API.Model.Media.VzMediaContentType"))

		mgr.addClassMap( ClassMap(className: "VzNetworkAccount", classAlias: "com.vizifit.API.Model.Network.VzNetworkAccount"))

		mgr.addClassMap( ClassMap(className: "VzNetworkMessage", classAlias: "com.vizifit.API.Model.Network.VzNetworkMessage"))

		mgr.addClassMap( ClassMap(className: "VzNetworkMessageType", classAlias: "com.vizifit.API.Model.Network.VzNetworkMessageType"))

		mgr.addClassMap( ClassMap(className: "VzNetworkRelationship", classAlias: "com.vizifit.API.Model.Network.VzNetworkRelationship"))

		mgr.addClassMap( ClassMap(className: "VzNetworkRelationshipType", classAlias: "com.vizifit.API.Model.Network.VzNetworkRelationshipType"))

		mgr.addClassMap( ClassMap(className: "VzNetworkType", classAlias: "com.vizifit.API.Model.Network.VzNetworkType"))

		mgr.addClassMap( ClassMap(className: "VzProgram", classAlias: "com.vizifit.API.Model.Program.VzProgram"))

		mgr.addClassMap( ClassMap(className: "VzProgramActivityAssignment", classAlias: "com.vizifit.API.Model.Program.VzProgramActivityAssignment"))

		mgr.addClassMap( ClassMap(className: "VzProgramStatusType", classAlias: "com.vizifit.API.Model.Program.VzProgramStatusType"))

		mgr.addClassMap( ClassMap(className: "VzScheduleDayType", classAlias: "com.vizifit.API.Model.Schedule.VzScheduleDayType"))

		mgr.addClassMap( ClassMap(className: "VzScheduleTimeType", classAlias: "com.vizifit.API.Model.Schedule.VzScheduleTimeType"))

		mgr.addClassMap( ClassMap(className: "UserContext", classAlias: "com.vizifit.API.Model.User.UserContext"))

		mgr.addClassMap( ClassMap(className: "VzAccount", classAlias: "com.vizifit.API.Model.User.VzAccount"))

		mgr.addClassMap( ClassMap(className: "VzProfile", classAlias: "com.vizifit.API.Model.User.VzProfile"))

		mgr.addClassMap( ClassMap(className: "VzSession", classAlias: "com.vizifit.API.Model.User.VzSession"))

		mgr.addClassMap( ClassMap(className: "VzUser", classAlias: "com.vizifit.API.Model.User.VzUser"))

		mgr.addClassMap( ClassMap(className: "VzUserType", classAlias: "com.vizifit.API.Model.User.VzUserType"))

 	}

    
}
