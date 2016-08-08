//
//  LKExtensions.swift
//  Lookr
//
//  Created by renan silva on 8/7/16.
//  Copyright © 2016 rvsz. All rights reserved.
//

import UIKit
import CoreData

class LKExtensions: NSObject {

}


extension NSManagedObject{
    class func LK_CreateEntity() -> NSManagedObject{
        let ctx = LKCoreDataBase.sharedInstance.managedObjectContext
        let entity = NSEntityDescription.insertNewObjectForEntityForName(entityName(), inManagedObjectContext: ctx)
        return entity
    }
    
    private class func entityName() -> String{
        let name = NSStringFromClass(self).componentsSeparatedByString(".").last!
        return name
    }
    
    class func LK_FindAll() -> [NSManagedObject]{
        return LK_FindAllWithPredicate(nil)
    }
    
    class func LK_FindAllWithPredicate(predicate : NSPredicate?) -> [NSManagedObject]{
        let ctx = LKCoreDataBase.sharedInstance.managedObjectContext
        let entityDescription = NSEntityDescription.entityForName(entityName(), inManagedObjectContext: ctx)
        
        let fetch = NSFetchRequest()
        fetch.entity = entityDescription
        
        if predicate != nil{
            fetch.predicate = predicate!
        }
        
        var list = [NSManagedObject]()
        
        do{
            try list = ctx.executeFetchRequest(fetch) as! [NSManagedObject]
        }catch{
            print(error)
        }
        return list
    }
    
    class func LK_FindUniqueWithPredicate(predicate : NSPredicate?) -> NSManagedObject?{
        let list = LK_FindAllWithPredicate(predicate)
        if list.count == 0{
            return nil
        }
        
        return list.first
    }

    
    class func LK_FindEntityWithIdentifier(identifier : NSString) -> NSManagedObject?{
        let predicate = NSPredicate(format: "identifier == %@", identifier)
        let list = LK_FindAllWithPredicate(predicate)
        
        if list.count > 0{
            return list.first!
        }
        
        return nil
    }

}