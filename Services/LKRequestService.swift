//
//  LKRequestService.swift
//  Lookr
//
//  Created by renan silva on 8/6/16.
//  Copyright © 2016 rvsz. All rights reserved.
//

import UIKit

class LKRequestService: LKBaseAPIService{

    class func GET(service: String, params : [String : AnyObject]?, success : ((AnyObject?)->())?, error : ((NSError?, NSURLResponse?)->())?){
        
        let url = "\(baseAPIPath())\(service)"
        let header = ["Token" : "804160e1-ab06-4fdb-8823-53c6948eafad"]
        
        LKBaseAPIService.requestGET(url, params: params, header: header, success: success, error: error)
        
    }
    
    class func baseAPIPath() -> String{
        return "http://lookr.azurewebsites.net/Api/"
    }
    
}
