//
//  LKBaseAPIService.swift
//  Lookr
//
//  Created by renan silva on 8/6/16.
//  Copyright © 2016 rvsz. All rights reserved.
//

import UIKit


class LKBaseAPIService: NSObject {
    
    class func requestGET(url : String, params : [String : AnyObject]?, header : [String : String]?, success : ((AnyObject?)->())?, error : ((NSError?, NSURLResponse?)->())?){
        
        let sessionManager = AFHTTPSessionManager()
        sessionManager.requestSerializer.HTTPRequestHeaders
        if header != nil{
            for key in header!.keys{
                sessionManager.requestSerializer.setValue(header![key], forHTTPHeaderField: key)
            }
        }
        
        sessionManager.GET(url, parameters: params, progress: nil, success: { (session : NSURLSessionDataTask, obj :AnyObject?) in
            
            if (success != nil){
                success!(obj)
            }
            
        }) { (session : NSURLSessionDataTask?, e : NSError) in
            if (error != nil){
                error!(e, session?.response)
            }
        }
    }
}
