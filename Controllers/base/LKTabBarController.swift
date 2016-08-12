//
//  LKTabBarController.swift
//  Lookr
//
//  Created by renan silva on 8/12/16.
//  Copyright © 2016 rvsz. All rights reserved.
//

import UIKit

class LKTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    static let tag_lookr_indicator : Int = 5

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        
        let timeLineController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LKTimeLineViewController") as!LKTimeLineViewController
        let navigationController = LKNavigationController(rootViewController: timeLineController)
        
        let controller1 = navigationController
        
        let controller2 = UIViewController()
        controller2.view.backgroundColor = UIColor.blueColor()
        
        let controller3 = UIViewController()
        controller3.view.backgroundColor = UIColor.grayColor()
        
        let controller4 = UIViewController()
        controller4.view.backgroundColor = UIColor.greenColor()
        
        let controller5 = UIViewController()
        controller5.view.backgroundColor = UIColor.yellowColor()
        
        self.viewControllers = [controller1,controller2,controller3,controller4,controller5]
        
        for (index, controller) in self.viewControllers!.enumerate(){
            var imageName = ""
            
            if index == 0 {
                imageName = "timeline_tab_icon.png"
            }else if index == 1 {
                imageName = "search_tab_icon.png"
            }else if index == 2 {
                imageName = "camera_tab_icon.png"
            }else if index == 3 {
                imageName = "notifications_tab_icon.png"
            }else if index == 4 {
                imageName = "profile_tab_icon.png"
            }
            
            let tabItem = UITabBarItem(title: nil, image: UIImage(named: imageName)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), selectedImage: nil)
            tabItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0)
            controller.tabBarItem = tabItem
        }
        
        self.tabBar.barTintColor = UIColor.whiteColor()
        self.tabBar.translucent = false
        self.tabBar.tintColor = UIColor.redColor()
        self.tabBar.barStyle = .Black
        
        self.tabBar.addSubview(createBarView())
    }
    
    func createBarView() -> UIView{
        let barView = UIView(frame: CGRectMake(0,0,self.view.widthSize(),4))
        barView.backgroundColor = UIColor(hexString: "#E4E4E4")
        barView.tag = LKTabBarController.tag_lookr_indicator
        let width = self.view.widthSize() / CGFloat(self.viewControllers!.count)
        let indicatorView = UIView(frame: CGRectMake(0,0,width,4))
        indicatorView.backgroundColor = UIColor(hexString: "#353535")
        barView.addSubview(indicatorView)
        return barView
    }

    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        let index = Float(tabBarController.viewControllers!.indexOf(viewController)!)
        let barView = self.tabBar.viewWithTag(LKTabBarController.tag_lookr_indicator)!
        let indicatorView = barView.subviews.first!
        
        UIView.animateWithDuration(0.2) {
            indicatorView.setX(index * Float(indicatorView.widthSize()))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
