//
//  LKFacebookService.swift
//  Lookr
//
//  Created by renan silva on 8/6/16.
//  Copyright © 2016 rvsz. All rights reserved.
//

import UIKit


class LKFacebookService: NSObject {
    
    class func login(result : ((error : NSError?, cancelByUser : Bool, facebookUser : LKFacebookProfileModel?)->())){
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
    
    class func requestUserData(result : (userModel : LKFacebookProfileModel?, error : NSError?)->()){
        let request = FBSDKGraphRequest(graphPath: "/me?fields=id,name,first_name,last_name,email,birthday", parameters:nil, HTTPMethod: "GET")
        request.startWithCompletionHandler({ (connection, resultRequest, e) in
            if (e != nil){
                result(userModel: nil, error: e)
            }else{
                let name = resultRequest.safeStringForKey("name")
                let identifier = resultRequest.safeStringForKey("id")
                let email = resultRequest.safeStringForKey("email")
                let birthday = resultRequest.safeStringForKey("birthday")
                let facebookModel = LKFacebookProfileModel(identifier: identifier, name: name, email: email, birthday: birthday)
                
                let profileImageURI = "/\(identifier)/?fields=picture.type(large)"
                
                FBSDKGraphRequest(graphPath: profileImageURI, parameters: nil, HTTPMethod: "GET").startWithCompletionHandler({ (connection, resultRequest, e) in
                    let picDic = resultRequest.objectForKey("picture")
                    let dataDic = picDic?.objectForKey("data")
                    let imageUri = dataDic?.safeStringForKey("url")
                    facebookModel.imageURI = imageUri
                    
                    result(userModel: facebookModel, error: nil)
                })
                
                
            }
        })
    }
    
    class func isLogged() -> Bool{
        return FBSDKAccessToken.currentAccessToken() != nil ? true : false
    }

}
