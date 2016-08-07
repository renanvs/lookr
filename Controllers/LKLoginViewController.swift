//
//  LKLoginViewController.swift
//  Lookr
//
//  Created by renan silva on 8/6/16.
//  Copyright © 2016 rvsz. All rights reserved.
//

import UIKit

class LKLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
    }
    
    @IBAction func facebookLoginHandler(){
        if LKFacebookService.isLogged(){
            LKFacebookService.requestUserData({ (userModel, error) in
                if error != nil{
                    LKUtils.simpleAlert(error!.localizedDescription)
                }else{
                    LKUserRequestService.createUserWithFacebookModel(userModel!, success: { (userEntity) in
                        LKUtils.simpleAlert(userEntity.description)
                        }, error: { (error) in
                            LKUtils.simpleAlert(error.localizedDescription)
                    })
                }
            })
        }else{
            LKFacebookService.login({ (error, cancelByUser, facebookUser) in
                if error != nil{
                    LKUtils.simpleAlert(error!.localizedDescription)
                }else if cancelByUser{
                    LKUtils.simpleAlert("User Canceled")
                }else{
                    LKUserRequestService.createUserWithFacebookModel(facebookUser!, success: { (userEntity) in
                        LKUtils.simpleAlert(userEntity.description)
                        }, error: { (error) in
                            LKUtils.simpleAlert(error.localizedDescription)
                    })
                }
            })
        }
    }
}
