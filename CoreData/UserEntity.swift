//
//  UserEntity.swift
//  Lookr
//
//  Created by renan silva on 8/7/16.
//  Copyright © 2016 rvsz. All rights reserved.
//

import Foundation
import CoreData

@objc(UserEntity)
class UserEntity: NSManagedObject {

    class func createMyUserWithObj(obj : AnyObject) -> UserEntity{
        let ctx = LKCoreDataBase.sharedInstance.managedObjectContext
        let entity = NSEntityDescription.insertNewObjectForEntityForName(NSStringFromClass(UserEntity), inManagedObjectContext: ctx) as! UserEntity
        
        entity.identifier = obj.safeStringForKey("Id")
        entity.name = obj.safeStringForKey("Name")
        entity.email = obj.safeStringForKey("Email")
        entity.facebookID = obj.safeStringForKey("IdFacebook")
        entity.birthday = obj.safeStringForKey("Birthday")
        entity.photoURI = obj.safeStringForKey("URLPhoto")
        entity.qtyPublications = obj.safeNumberForKey("LengthPublication")
        entity.qtyFollowers = obj.safeNumberForKey("LengthFollowers")
        entity.qtyFollowings = obj.safeNumberForKey("LengthFollowings")
        
        entity.isMe = NSNumber(bool: true)
        
        do{
           try ctx.save()
        }catch{
            print(error)
        }
        
        return entity
    }
    
    class func hasUserLogged() -> Bool{
        if getMyUserEntityCanBeNull() == nil{
            return false
        }
        
        return true
    }
    
    class func getMyUserEntity() -> UserEntity{
        return getMyUserEntityCanBeNull()!
    }
    
    private class func getMyUserEntityCanBeNull() -> UserEntity?{
        let predicate = NSPredicate(format: "isMe == true")
        
        let ctx = LKCoreDataBase.sharedInstance.managedObjectContext
        let entityDescription = NSEntityDescription.entityForName(NSStringFromClass(UserEntity), inManagedObjectContext: ctx)
        
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = entityDescription
        fetchRequest.predicate = predicate
        
        var users = [UserEntity]()
        
        do{
           try users = ctx.executeFetchRequest(fetchRequest) as! [UserEntity]
        }catch{
            print(error)
        }
        
        if users.count > 0 {
            return users.first!
        }
        
        return nil
    }

}
