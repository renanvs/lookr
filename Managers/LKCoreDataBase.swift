//
//  LKCoreDataBase.swift
//  Lookr
//
//  Created by renan silva on 8/7/16.
//  Copyright © 2016 rvsz. All rights reserved.
//

import UIKit
import CoreData

class LKCoreDataBase: NSObject {
    static let sharedInstance = LKCoreDataBase()
    
    lazy var applicationDocumentDirectory : NSURL = {
        var urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask)
        return urls.last!
    }()
    
    lazy var manageObjectModel : NSManagedObjectModel = {
        let modelURL = NSBundle.mainBundle().URLForResource("Lookr", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator:NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.manageObjectModel)
        let url = self.applicationDocumentDirectory.URLByAppendingPathComponent("Lookr.sqlite")
        
        do{
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options:nil)
        }catch{
            print(error)
        }
        
        return coordinator
        
    }()
    
    lazy var managedObjectContext:NSManagedObjectContext = {
        let coodinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coodinator
        return managedObjectContext
    }()
}
