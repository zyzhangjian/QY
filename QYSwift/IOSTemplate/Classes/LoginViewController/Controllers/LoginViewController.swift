//
//  LoginViewController.swift
//  QYSwift
//
//  Created by 张健 on 16/9/25.
//  Copyright © 2016年 张健. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    var segmented : UISegmentedControl!
    var rootSV    : UIScrollView!
    
    // MARK: - VC Life
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.createUI()
        
        self.createScrollView()
    }
    
    // MARK: - CreateUI
    func createUI() -> Void {
        
        let rootImageView = UIImageView.init(frame: self.view.bounds)
        rootImageView.image = UIImage(named: "Category_City_Enjoy_Button_Highlight_20x38_")
        view.addSubview(rootImageView)
        
        let titleLabel = UILabel.init(frame: CGRectMake(0, 20, ScreenWidth, 44))
        titleLabel.font = UIFont.boldSystemFontOfSize(17)
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = .Center
        titleLabel.text = "登录"
        view.addSubview(titleLabel)
        
        let dismissImageView  = UIImageView.init(frame: CGRectMake(15, 25, 30, 30))
        dismissImageView.image = UIImage(named: "My_Order_detail_30x30_")
        dismissImageView.userInteractionEnabled = true
        dismissImageView.center = CGPointMake(dismissImageView.center.x, titleLabel.center.y)
        dismissImageView.bk_whenTapped {
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        view.addSubview(dismissImageView)
        
        let rightButton = UIButton.init(frame: CGRectMake(ScreenWidth - 73, 0, 58, 22))
        rightButton.backgroundColor = UIColor.clearColor()
        rightButton.layer.borderWidth = 1
        rightButton.layer.cornerRadius = 4
        rightButton.center = CGPointMake(rightButton.center.x, dismissImageView.center.y)
        rightButton.layer.masksToBounds = true
        rightButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        rightButton.layer.borderColor = UIColor.whiteColor().CGColor
        rightButton.setTitle("注册", forState: UIControlState.Normal)
        view.addSubview(rightButton)
        

        segmented = UISegmentedControl.init(items: ["账号登录","短信验证码登录"])
        segmented.selectedSegmentIndex = 0
        segmented.addTarget(self, action: #selector(segmentedChange), forControlEvents: UIControlEvents.ValueChanged)
        segmented.tintColor = UIColor.RGB(0x2ba675)
        segmented.frame = CGRectMake(15, rightButton.bottom() + 20, ScreenWidth - 30, 34)
        let dic = NSDictionary.init(object: UIColor.RGB(0x9fffdc) , forKey: NSForegroundColorAttributeName)
        segmented.setTitleTextAttributes(dic as [NSObject : AnyObject], forState: UIControlState.Selected)
        view.addSubview(segmented)
        
        
        let otherView = OtherLoginView.init(frame: CGRectMake(0, ScreenHeight - 70, ScreenWidth, 90)) { (code) in
        
            YYNSLog("\(code)")
            
        }
        view.addSubview(otherView)
    }
    
    func segmentedChange() -> Void {
        
        rootSV.contentOffset.x = segmented.selectedSegmentIndex == 0 ? 0 : ScreenWidth
    }
    
    // MARK: - CreateScrollView
    func createScrollView() -> Void {
        
        rootSV = UIScrollView.init(frame: CGRectMake(0, segmented.bottom() , ScreenWidth, ScreenHeight - segmented.bottom() - 66))
        rootSV.bounces = false
        rootSV.pagingEnabled = true
        rootSV.delegate = self
        rootSV.showsVerticalScrollIndicator = false
        rootSV.showsHorizontalScrollIndicator = false
        rootSV.contentSize = CGSizeMake(ScreenWidth * 2, 0)
        rootSV.bk_whenTapped { 
            
            self.view.endEditing(true)
        }
        view.addSubview(rootSV)
        
        
        //账号登录
        let accountView = AccountView.init(frame: CGRectMake(0, 0, ScreenWidth, rootSV.height())) { (dic : NSDictionary) in
            
            YYNSLog("\(dic)")
        }
        rootSV.addSubview(accountView)
        
        let codeView = CodeView.init(frame: CGRectMake(ScreenWidth, 0, ScreenWidth, rootSV.height())) { (dic) in
            
            YYNSLog("\(dic)")
        }
        rootSV.addSubview(codeView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UIScrollViewDelegate
extension LoginViewController : UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        segmented.selectedSegmentIndex = scrollView.contentOffset.x == 0 ? 0 : 1
    
    }
}
