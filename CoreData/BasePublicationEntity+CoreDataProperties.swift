//
//  BasePublicationEntity+CoreDataProperties.swift
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

extension BasePublicationEntity {

    @NSManaged var identifier: String!
    @NSManaged var text: String!
    @NSManaged var dateStr: String!
    @NSManaged var qtyLikes: NSNumber!
    @NSManaged var qtyDislikes: NSNumber!
    @NSManaged var qtyComments: NSNumber!
    @NSManaged var liked: NSNumber!
    @NSManaged var disliked: NSNumber!
    @NSManaged var user: UserEntity!
    @NSManaged var images: NSSet!

}
