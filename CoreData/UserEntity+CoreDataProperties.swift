//
//  UserEntity+CoreDataProperties.swift
//  Lookr
//
//  Created by renan silva on 8/7/16.
//  Copyright © 2016 rvsz. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension UserEntity {

    @NSManaged var identifier: String!
    @NSManaged var name: String!
    @NSManaged var email: String!
    @NSManaged var facebookID: String!
    @NSManaged var photoURI: String?
    @NSManaged var qtyPublications: NSNumber!
    @NSManaged var qtyFollowers: NSNumber!
    @NSManaged var qtyFollowings: NSNumber!
    @NSManaged var isMe: NSNumber!

}
