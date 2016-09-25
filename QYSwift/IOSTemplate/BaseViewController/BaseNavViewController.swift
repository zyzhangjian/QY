//
//  BaseNavViewController.swift
//  QYSwift
//
//  Created by 张健 on 16/8/30.
//  Copyright © 2016年 张健. All rights reserved.
//

import UIKit

class BaseNavViewController: UINavigationController {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.RGB(0x242424) ,NSFontAttributeName : UIFont.systemFontOfSize(16)]
        
        self.tabBarController!.tabBar.tintColor = UIColor.RGB(0x25daac)
        self.navigationBar.translucent = false
        
        self.navigationBar.shadowImage = UIImage.createImageWithColor(UIColor.clearColor())
        self.navigationBar.setBackgroundImage(UIImage.init(named: "LastMinute_TitleBar_621")
            , forBarMetrics: UIBarMetrics.Default)
        
        self.navigationBar.barTintColor = UIColor.clearColor()
        self.navigationBar.translucent = false
        self.interactivePopGestureRecognizer?.delegate = self
        let item = UIBarButtonItem.appearance()
        item .setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.RGB(0xFFFFFF),NSFontAttributeName : UIFont.boldSystemFontOfSize(14)], forState: UIControlState.Normal)

    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        
        if self.childViewControllers.count > 0 {
            
            let button = UIButton.init(type: UIButtonType.Custom)
            button.setImage(UIImage(named: "Green_Back_30x30_"), forState: UIControlState.Normal)
            button.setImage(UIImage(named: "Green_Back_Press_30x30_"), forState: UIControlState.Highlighted)
            button.frame = CGRectMake(0, 0, 30, 30)
            button.bk_whenTapped({
                
                self.popViewControllerAnimated(true)
            })
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: button)
            viewController.hidesBottomBarWhenPushed = true
            
        }
        
        super.pushViewController(viewController, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension BaseNavViewController : UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return self.childViewControllers.count > 1
    }
}
