//
//  LKFacebookService.swift
//  Lookr
//
//  Created by renan silva on 8/6/16.
//  Copyright © 2016 rvsz. All rights reserved.
//

import UIKit


class LKFacebookService: NSObject {
    
    class func login(result : ((error : NSError?, cancelByUser : Bool, facebookUser : LKFacebookUserModel?)->())){
        let fbLoginManager = FBSDKLoginManager()
        
        fbLoginManager.logInWithReadPermissions(["public_profile"], fromViewController: nil) { (loginResult, e) in
            
            if (e != nil || loginResult.isCancelled){
                result(error: e, cancelByUser: loginResult.isCancelled, facebookUser: nil)
            }
            
            requestUserData({ (userModel, e) in
                if (e != nil){
                    result(error: e, cancelByUser: loginResult.isCancelled, facebookUser: nil)
                }else{
                    result(error: nil, cancelByUser: false, facebookUser: userModel)
                }
            })
            
        }
    }
    
    class func requestUserData(result : (userModel : LKFacebookUserModel?, error : NSError?)->()){
        let request = FBSDKGraphRequest(graphPath: "/me?fields=id,name,first_name,last_name,email", parameters:nil, HTTPMethod: "GET")
        request.startWithCompletionHandler({ (connection, resultRequest, e) in
            if (e != nil){
                result(userModel: nil, error: e)
            }else{
                let name = resultRequest.safeStringForKey("name")
                let identifier = resultRequest.safeStringForKey("id")
                let email = resultRequest.safeStringForKey("email")
                let facebookModel = LKFacebookUserModel(identifier: identifier, name: name, email: email)
                result(userModel: facebookModel, error: nil)
            }
        })
    }
    
    class func isLogged() -> Bool{
        return FBSDKAccessToken.currentAccessToken() != nil ? true : false
    }

}
