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
}
