//
//  PublicationImage.swift
//  Lookr
//
//  Created by renan silva on 8/7/16.
//  Copyright © 2016 rvsz. All rights reserved.
//

import Foundation
import CoreData


class PublicationImage: NSManagedObject {

    class func getOrCreateImageWithList(obj : AnyObject, userIdentifier : String) -> NSSet{
        
        let list = obj as! [NSDictionary]
        let listSet = NSMutableSet()
        
        for dic in list{
            let photoURI = dic.safeStringForKey("URL")
            let predicate = NSPredicate(format: "imageURI == %@", photoURI)
            var publicationImage = PublicationImage.LK_FindUniqueWithPredicate(predicate) as? PublicationImage
            if publicationImage == nil{
                publicationImage = PublicationImage.LK_CreateEntity() as? PublicationImage
                publicationImage?.imageURI = photoURI
            }
            
            publicationImage?.userIdentifier = userIdentifier
            
            listSet.addObject(publicationImage!)
        }
        
        return listSet
    }

}
