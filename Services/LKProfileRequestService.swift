//
//  LKProfileRequestService.swift
//  Lookr
//
//  Created by renan silva on 8/7/16.
//  Copyright © 2016 rvsz. All rights reserved.
//

import UIKit

class LKProfileRequestService: LKRequestService {
    
    class func createProfileWithFacebookModel(facebookProfileModel : LKFacebookProfileModel, success : (profileEntity : ProfileEntity)->(), error : (error : NSError)->()){
        
        var param = [String : AnyObject]()
        
        param["Name"] = facebookProfileModel.name
        param["Email"] = facebookProfileModel.email
        param["IdFacebook"] = facebookProfileModel.identifier
        param["Birthday"] = facebookProfileModel.birthday
        param["URLPhoto"] = facebookProfileModel.imageURI
        
        self.POST("USER", params: param, success: { (obj) in
            
            let statusCode = obj!.safeNumberForKey("StatusCode").intValue
            if statusCode == 200{
                let identifier = obj!.safeStringForKey("StatusDescription")
                getProfileWithIdentifier(identifier, success: { (obj) in
                    let profileEntity = ProfileEntity.createMyProfileWithObj(obj)
                    success(profileEntity: profileEntity)
                    }, error: { (e) in
                        error(error: e)
                })
            }
            
        }) { (e, response) in
            error(error: e!)
        }
        
    }
    
    private class func getProfileWithIdentifier(identifier : String, success: (AnyObject)->(), error: (NSError)->()){
        self.GET("User/\(identifier)", params: nil, success: { (obj) in
            success(obj!)
        }) { (e, response) in
            error(e!)
        }
    }
    
}
