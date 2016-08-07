//
//  LKUtils.swift
//  Lookr
//
//  Created by renan silva on 8/7/16.
//  Copyright © 2016 rvsz. All rights reserved.
//

import UIKit

class LKUtils: NSObject {
    class func simpleAlert(text : String){
        let alert = UIAlertController(title: "Lookr", message: text, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        let window = UIApplication.sharedApplication().delegate?.window!
        window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }
    
    class func getCorrectInitialController() -> UIViewController{
        
        if UserEntity.hasUserLogged(){
            let timeLineController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LKTimeLineViewController") as!LKTimeLineViewController
            let navigationController = LKNavigationController(rootViewController: timeLineController)
            return navigationController
        }else{
            let loginController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LKLoginViewController") as! LKLoginViewController
            let navigationController = LKNavigationController(rootViewController: loginController)
            return navigationController
        }
        
    }
}
