//
//  MyViewController.swift
//  QYSwift
//
//  Created by 张健 on 16/9/24.
//  Copyright © 2016年 张健. All rights reserved.
//

import UIKit

class MyViewController: BaseViewController {
    
    var tableView           : MyVCTableView!
    
    var titleViewimageView  : UIImageView!
    
    var baseTitleLabel      : UILabel!
    
    // MARK: - Navigation
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.createTitleView()
        
        self.createTableView()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.hiddenNavBar()
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.showNavBar()
    }

    func createTitleView() -> Void {
        
        titleViewimageView = UIImageView.init(frame: CGRectMake(0, -20, ScreenWidth, 64))
        titleViewimageView.image = UIImage(named: "LastMinute_TitleBar_621")
        self.navigationController?.navigationBar.insertSubview(titleViewimageView, atIndex: 0)
        
        
        baseTitleLabel = UILabel.init(frame: CGRectMake(0, 20, ScreenWidth, 44))
        baseTitleLabel.text = "我的最世界"
        baseTitleLabel.textColor = UIColor.whiteColor()
        baseTitleLabel.font = UIFont.systemFontOfSize(17)
        baseTitleLabel.textAlignment = NSTextAlignment.Center
        titleViewimageView.addSubview(baseTitleLabel)

    }
    
    func createTableView() -> Void {
        
        tableView = MyVCTableView.init(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight - 30), style: UITableViewStyle.Grouped, VC: self) { (dic : NSDictionary) in
            
            if dic.objectForKey("code")?.intValue == 2 {
                
                
                if UserInfo.instance.uid().isEmpty {

                    //解决延迟强制在主线程执行
                    GCDQueue.mainQueue().execute({
                        
                        self.presentViewController(LoginViewController(), animated: true, completion: nil)
                    })

                }
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
