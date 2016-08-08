//
//  BasePublicationEntity.swift
//  Lookr
//
//  Created by renan silva on 8/7/16.
//  Copyright © 2016 rvsz. All rights reserved.
//

import Foundation
import CoreData


class BasePublicationEntity: NSManagedObject {

    class func parsePublications(obj : AnyObject){
        if !(obj is NSArray){
            return
        }
        
        let list = obj as! [NSDictionary]
        for dic in list{
            createPublicationWithDictionary(dic)
            
        }
    }
    
    class func createPublicationWithDictionary(dic : NSDictionary) -> BasePublicationEntity{
        
        let dicPublictation = dic.objectForKey("Publication")!
        
        let identifier = dicPublictation.safeStringForKey("Id")
        var entity = self.LK_FindEntityWithIdentifier(identifier) as? BasePublicationEntity
        
        if entity == nil{
            entity = self.LK_CreateEntity() as? BasePublicationEntity
            entity?.identifier = identifier
        }
        
        entity?.text = dicPublictation.safeStringForKey("Text")
        entity?.dateStr = dicPublictation.safeStringForKey("Date")
        entity?.qtyLikes = dicPublictation.safeNumberForKey("LikesLength")
        entity?.qtyDislikes = dicPublictation.safeNumberForKey("DislikesLength")
        entity?.qtyComments = dicPublictation.safeNumberForKey("CommentsLength")
        entity?.liked = dic.safeNumberForKey("Liked")
        entity?.disliked = dic.safeNumberForKey("Disliked")
        
        let userEntity = UserEntity.getOrCreateUserWithObj(dicPublictation.objectForKey("User")!)
        let images = PublicationImage.getOrCreateImageWithList(dicPublictation.objectForKey("Pictures")!, userIdentifier: userEntity.identifier)
        
        entity?.user = userEntity
        entity?.images = images
        
        return entity!
    }

}
