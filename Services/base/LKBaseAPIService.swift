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
    
    class func requestPOST(url : String, params : [String : AnyObject]?, header : [String : String]?, isJsonSerializer : Bool, success : ((AnyObject?)->())?, error : ((NSError?, NSURLResponse?)->())?){
        
        /*
         operationManager.responseSerializer = AFJSONResponseSerializer()
         operationManager.requestSerializer = AFHTTPRequestSerializer()
         
         if isJson{
         operationManager.requestSerializer = AFJSONRequestSerializer()
         }
         
         operationManager.responseSerializer.acceptableContentTypes = NSSet(objects: "text/html", "application/json", "text/json", "application/x-www-form-urlencoded") as Set<NSObject>
         
         
         operationManager.requestSerializer.setValue(authorization, forHTTPHeaderField: "Authorization")
         operationManager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
         */
        
        let sessionManager = AFHTTPSessionManager()
        
        sessionManager.requestSerializer = AFHTTPRequestSerializer()
        
        if isJsonSerializer{
            sessionManager.requestSerializer = AFJSONRequestSerializer()
        }
        
        if header != nil{
            for key in header!.keys{
                sessionManager.requestSerializer.setValue(header![key], forHTTPHeaderField: key)
            }
        }
        
        sessionManager.POST(url, parameters: params, progress: nil, success: { (session : NSURLSessionDataTask, obj :AnyObject?) in
            
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
