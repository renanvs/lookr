//
//  LKFacebookUserModel.swift
//  Lookr
//
//  Created by renan silva on 8/7/16.
//  Copyright © 2016 rvsz. All rights reserved.
//

import UIKit

class LKFacebookUserModel: NSObject {
    var name : String!
    var email : String!
    var identifier : String!
    var birthday : String!
    var imageURI : String!
    
    init(identifier : String, name : String, email : String, birthday : String?) {
        self.name = name
        self.email = email
        self.identifier = identifier
        
        self.birthday = birthday
        
        if birthday == nil{
            self.birthday = ""
        }
        
        imageURI = ""
        
    }
    
    override var description: String{
        let dic = ["identifier" : identifier, "name" : name, "email" : email, "birthday" : birthday, "imageURI" : imageURI];
        return dic.description as NSString as String
    }
}
