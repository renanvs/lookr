//
//  LKUserRequestService.swift
//  Lookr
//
//  Created by renan silva on 8/7/16.
//  Copyright © 2016 rvsz. All rights reserved.
//

import UIKit

class LKUserRequestService: LKRequestService {

    class func createUserWithFacebookModel(facebookUserModel : LKFacebookUserModel, success : (userEntity : UserEntity)->(), error : (error : NSError)->()){
        
        var param = [String : AnyObject]()
        
        param["Name"] = facebookUserModel.name
        param["Email"] = facebookUserModel.email
        param["IdFacebook"] = facebookUserModel.identifier
        param["Birthday"] = facebookUserModel.birthday
        param["URLPhoto"] = facebookUserModel.imageURI
        
        self.POST("USER", params: param, success: { (obj) in
            
            let statusCode = obj!.safeNumberForKey("StatusCode").intValue
            if statusCode == 200{
                let identifier = obj!.safeStringForKey("StatusDescription")
                getUserWithIdentifier(identifier, success: { (obj) in
                    let userEntity = UserEntity.createMyUserWithObj(obj)
                    success(userEntity: userEntity)
                    }, error: { (e) in
                    error(error: e)
                })
            }
            
            }) { (e, response) in
                error(error: e!)
        }
        
    }
    
    private class func getUserWithIdentifier(identifier : String, success: (AnyObject)->(), error: (NSError)->()){
        self.GET("User/\(identifier)", params: nil, success: { (obj) in
                success(obj!)
            }) { (e, response) in
                error(e!)
        }
    }
    
}
