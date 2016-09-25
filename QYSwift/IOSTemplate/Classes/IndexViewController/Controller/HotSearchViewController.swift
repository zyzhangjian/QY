//
//  HotSearchViewController.swift
//  QYSwift
//
//  Created by 张健 on 16/9/22.
//  Copyright © 2016年 张健. All rights reserved.
//

import UIKit

class HotSearchViewController: BaseViewController {

    var rootSV          : UIScrollView!
    
    var searchBar       : UISearchBar!
    
    var hotSearchArray  : NSArray!
    
    // MARK: - VC Life
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createTopView()
        
        self.createBottomView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        searchBar.becomeFirstResponder()
    }
    
    // MARK: - CreateTopView
    func createTopView() -> Void {
        
        let topView = UIView.init(frame: CGRectMake(0, 0, ScreenWidth, 64))
        topView.backgroundColor = UIColor.RGB(0xffffff)
        view.addSubview(topView)
        
        
        //取消按钮
        let cancelButton = UIButton.init(frame: CGRectMake(ScreenWidth - 60, 22, 60, 42))
        cancelButton.setTitle("取消", forState: UIControlState.Normal)
        cancelButton.titleLabel?.font = UIFont.systemFontOfSize(15)
        cancelButton.bk_whenTapped { 
            
            //关闭键盘
            self.view.endEditing(true)
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
            //状态栏白色文字
            UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        }
        cancelButton.setTitleColor(UIColor.RGB(0x25daac), forState: UIControlState.Normal)
        topView.addSubview(cancelButton)
        
        //搜索框
        searchBar = UISearchBar.init(frame: CGRectMake(15, 22, ScreenWidth - 75, 30))
        searchBar.placeholder = "搜索 目的地/折扣/关键字"
        searchBar.layer.cornerRadius = 15
        searchBar.layer.masksToBounds = true
        searchBar.center = CGPointMake(searchBar.center.x, cancelButton.center.y)
        searchBar.layer.borderWidth = 1.2
        searchBar.becomeFirstResponder()
        searchBar.layer.borderColor = UIColor.RGB(0xcccccc).CGColor
        searchBar.backgroundColor = UIColor.RGB(0xffffff)
        searchBar.backgroundImage = UIImage.createImageWithColor(UIColor.RGB(0xffffff))
        topView.addSubview(searchBar)
        
    }
    
    // MARK: - CreateBottomView
    func createBottomView() -> Void {
        
        rootSV = UIScrollView.init(frame: CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64))
        rootSV.backgroundColor = UIColor.RGB(0xf5f5f5)
        rootSV.delegate = self
        view.addSubview(rootSV)
        
        
        //热门搜索
        let hotImage = UIImageView.init(frame: CGRectMake(15, 22, 20, 20))
        hotImage.image = UIImage(named: "sgk_course_sort_hot_selected")
        rootSV.addSubview(hotImage)
        
        let hotLabel = UILabel.init(frame: CGRectMake(hotImage.right(), 22, ScreenWidth - hotImage.right(), 18))
        hotLabel.text = "热门搜索"
        hotLabel.textColor = UIColor.RGB(0xb7b7b7)
        hotLabel.font = UIFont.systemFontOfSize(15)
        rootSV.addSubview(hotLabel)
        
        let lineView = UIView.init(frame: CGRectMake(15, hotImage.bottom() + 15, ScreenWidth - 30, 0.5))
        lineView.backgroundColor = UIColor.RGB(0xdfdfdf)
        rootSV.addSubview(lineView)
        
        //城市按钮
        var w : CGFloat = 0
        
        var h : CGFloat = lineView.bottom() + 20
        
        for index in 0 ..< hotSearchArray.count {
            
            let buttonWidth = String.zjSizeWithString(hotSearchArray[index] as! String, font: UIFont.systemFontOfSize(15), sizeWidth: 0, sizeHeight: 26) + 40
            
            let cityButton = UIButton.init(type: UIButtonType.System)
            cityButton.setTitle(hotSearchArray[index] as? String, forState: UIControlState.Normal)
            cityButton.layer.borderWidth = 0.5
            cityButton.layer.cornerRadius = 4
            cityButton.layer.borderColor = UIColor.RGB(0x757575).CGColor
            cityButton.backgroundColor = UIColor.clearColor()
            cityButton.setTitleColor(UIColor.RGB(0x757575), forState: UIControlState.Normal)
            cityButton.titleLabel?.font = UIFont.systemFontOfSize(15)
            cityButton.frame = CGRectMake(15 + w , h, buttonWidth, 26)
            
            if (15 + w + buttonWidth > ScreenWidth) {
                w = 0;
                h = h + 26 + 15
                cityButton.frame = CGRectMake(15 + w, h, buttonWidth, 26)
            }
            
            w = cityButton.frame.size.width + cityButton.frame.origin.x
            rootSV.addSubview(cityButton)
        
        }
        
        
        rootSV.contentSize = CGSizeMake(0, ScreenHeight)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension HotSearchViewController : UIScrollViewDelegate {

    func scrollViewDidScroll(scrollView: UIScrollView){
        
        self.view.endEditing(true)
        
    }
}
