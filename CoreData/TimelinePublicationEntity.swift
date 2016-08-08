//
//  TimelinePublicationEntity.swift
//  Lookr
//
//  Created by renan silva on 8/7/16.
//  Copyright © 2016 rvsz. All rights reserved.
//

import Foundation
import CoreData


class TimelinePublicationEntity: BasePublicationEntity {

    class func getAll() -> [TimelinePublicationEntity]{
        //todo: ordenar pela data
        return TimelinePublicationEntity.LK_FindAll() as! [TimelinePublicationEntity]
    }

}
