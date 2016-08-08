//
//  ProfileEntity.swift
//  Lookr
//
//  Created by renan silva on 8/7/16.
//  Copyright © 2016 rvsz. All rights reserved.
//

import Foundation
import CoreData

@objc(ProfileEntity)
class ProfileEntity: NSManagedObject {

    class func createMyProfileWithObj(obj : AnyObject) -> ProfileEntity{
        let entity = ProfileEntity.LK_CreateEntity() as! ProfileEntity
        
        entity.identifier = obj.safeStringForKey("Id")
        entity.name = obj.safeStringForKey("Name")
        entity.email = obj.safeStringForKey("Email")
        entity.facebookID = obj.safeStringForKey("IdFacebook")
        entity.birthday = obj.safeStringForKey("Birthday")
        entity.photoURI = obj.safeStringForKey("URLPhoto")
        entity.qtyPublications = obj.safeNumberForKey("LengthPublication")
        entity.qtyFollowers = obj.safeNumberForKey("LengthFollowers")
        entity.qtyFollowings = obj.safeNumberForKey("LengthFollowings")
        
        LKCoreDataBase.save()
        
        return entity
    }
    
    class func hasProfileLogged() -> Bool{
        if getMyProfileEntityCanBeNull() == nil{
            return false
        }
        
        return true
    }
    
    class func getMyProfileEntity() -> ProfileEntity{
        return getMyProfileEntityCanBeNull()!
    }
    
    private class func getMyProfileEntityCanBeNull() -> ProfileEntity?{
        return ProfileEntity.LK_FindUniqueWithPredicate(nil) as? ProfileEntity
    }

}
