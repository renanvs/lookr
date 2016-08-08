//
//  UserEntity.swift
//  Lookr
//
//  Created by renan silva on 8/7/16.
//  Copyright © 2016 rvsz. All rights reserved.
//

import Foundation
import CoreData


class UserEntity: NSManagedObject {

    class func getOrCreateUserWithObj(dic : AnyObject) -> UserEntity{
        let identifier = dic.safeStringForKey("Id")
        var userEntity = UserEntity.LK_FindEntityWithIdentifier(identifier) as? UserEntity
        if userEntity == nil{
            userEntity = UserEntity.LK_CreateEntity() as? UserEntity
            userEntity?.identifier = identifier
        }
        
        userEntity?.name = dic.safeStringForKey("Name")
        userEntity?.photoURI = dic.safeStringForKey("URLPhoto")
        
        return userEntity!
    }

}
