//
//  LKBaseViewController.swift
//  Lookr
//
//  Created by renan silva on 8/11/16.
//  Copyright © 2016 rvsz. All rights reserved.
//

import UIKit

class LKBaseViewController: UIViewController {
    
    static let tag_lookr_logo : Int = 5

    override func viewDidLoad() {
        super.viewDidLoad()

        configNavigationBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configNavigationBar(){
        if self.navigationController == nil{
            return
        }
        
        var logoView = self.navigationController?.navigationBar.viewWithTag(LKBaseViewController.tag_lookr_logo) as? UIImageView
        logoView?.removeFromSuperview()
        
        logoView = UIImageView(frame: CGRectMake(0, 0, 48, 12))
        logoView?.contentMode = .ScaleAspectFit
        //logoView?.backgroundColor = UIColor.redColor()
        logoView?.image = UIImage(named: "logo_white_topbar.png")
        self.navigationController?.navigationBar.addSubview(logoView!)
        logoView?.centerInSuperview()
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "#292929")
        self.navigationController?.navigationBar.translucent = false
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
