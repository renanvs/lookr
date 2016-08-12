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
        
        if ProfileEntity.hasProfileLogged(){
            return LKTabBarController()
        }else{
            let loginController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LKLoginViewController") as! LKLoginViewController
            let navigationController = LKNavigationController(rootViewController: loginController)
            return navigationController
        }
    }
    
    class func reizeImageToScreenWidth(image : UIImage, result : (newImage:UIImage)->()){
        let screenSize = Utils.screenBoundsOnCurrentOrientation().size
        let imageCurrentSize = image.size
        
        let factorWidth = screenSize.width/imageCurrentSize.width
        let newSize = CGSizeMake(imageCurrentSize.width*factorWidth, imageCurrentSize.height*factorWidth)
        
        var nImage = image
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        nImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        result(newImage: nImage)
        
    }
    
    class func reizeImageToThum(image : UIImage, result : (newImage:UIImage)->()){
        let imageCurrentSize = image.size
        
        let factorWidth = 80/imageCurrentSize.width
        let newSize = CGSizeMake(imageCurrentSize.width*factorWidth, imageCurrentSize.height*factorWidth)
        
        var nImage = image
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        nImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        result(newImage: nImage)
        
    }
    
    class func downloadAndGenerateImages(url:String?, identifier : String, success : (identifier : String)->(), error : (identifier : String) -> ()){
        
        LKDownloadManager.downloadWith(url, identifier: identifier, success: { (identifier) in
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                
                let image = LKDownloadManager.imageFromUrl(url, appendName: nil)
                
                LKUtils.reizeImageToScreenWidth(image!, result: { (newImage) in
                    let dataScreen = UIImageJPEGRepresentation(newImage, 1)!
                    let pathScreen = LKDownloadManager.getFullPath(url!, appendName: "_screen")
                    dataScreen.writeToFile(pathScreen.path!, atomically: true)
                    
                    LKUtils.reizeImageToThum(newImage, result: { (thumbImage) in
                        
                        let dataThumb = UIImageJPEGRepresentation(newImage, 1)!
                        let pathThumb = LKDownloadManager.getFullPath(url!, appendName: "_thumb")
                        dataThumb.writeToFile(pathThumb.path!, atomically: true)
                        
                        dispatch_async(dispatch_get_main_queue(), {
                            success(identifier: identifier)
                        })
                        
                    })
                })
                
            })
            
            
            
            
            
            }, error: error)
    }
}
