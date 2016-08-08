//
//  LKTimelineRequestService.swift
//  Lookr
//
//  Created by renan silva on 8/7/16.
//  Copyright © 2016 rvsz. All rights reserved.
//

import UIKit

class LKTimelineRequestService: LKRequestService {

    class func getTimeline(success : ()->(), error : (error: NSError?, response: NSURLResponse?)->()){
        self.GET("Timeline", params: nil, success: { (any) in
            
            TimelinePublicationEntity.parsePublications(any!)
            success()
            
        }) { (e, response) in
                error(error: e, response: response)
        }
    }
    
}
