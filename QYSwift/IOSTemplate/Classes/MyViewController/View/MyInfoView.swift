//
//  MyInfoView.swift
//  QYSwift
//
//  Created by 张健 on 16/9/24.
//  Copyright © 2016年 张健. All rights reserved.
//

import UIKit

class MyInfoView: UIView {

    var iconImageView : UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.createSelf()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func createSelf() -> Void {
        
        iconImageView = UIImageView.init(frame: CGRectMake(30, 0, 60, 60))
        iconImageView.image = UIImage(named: "Mine_Avatar_280x280_")
        iconImageView.layer.borderWidth = 3
        iconImageView.layer.cornerRadius = 30
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.borderColor = UIColor.RGB(0x50b678).CGColor
        self.addSubview(iconImageView)
        
        let loginLabel = UILabel.init(frame: CGRectMake(iconImageView.right() + 20 , 0, ScreenWidth - (iconImageView.right() + 20), 21))
        loginLabel.text = "点击登录 ，体验更多"
        loginLabel.font = UIFont.systemFontOfSize(17)
        loginLabel.center = CGPointMake(loginLabel.center.x, iconImageView.center.y)
        loginLabel.textColor = UIColor.whiteColor()
        self.addSubview(loginLabel)
        
        
        let infoLabel = UILabel.init(frame: CGRectMake(0 , iconImageView.bottom() , ScreenWidth - 30, 21))
        infoLabel.text = "个人信息管理等 >"
        infoLabel.font = UIFont.systemFontOfSize(13)
        infoLabel.textAlignment = NSTextAlignment.Right
        infoLabel.textColor = UIColor.whiteColor()
        self.addSubview(infoLabel)
        
        let bottomView = UIView.init(frame: CGRectMake(0, 88, ScreenWidth, 50))
        bottomView.backgroundColor = UIColor.clearColor()
        self.addSubview(bottomView)
        

        let bgView = UIView.init(frame: bottomView.bounds)
        bgView.alpha = 0.1
        bgView.backgroundColor = UIColor.blackColor()
        bottomView.addSubview(bgView)
        
        for index in 0 ..< 3 {
            
            let label = UILabel.init(frame: CGRectMake(CGFloat(index) * (ScreenWidth / 3), 5, ScreenWidth / 3, 18))
            label.text = "0"
            label.textAlignment = NSTextAlignment.Center
            label.textColor = UIColor.whiteColor()
            label.font = UIFont.boldSystemFontOfSize(14)
            bottomView.addSubview(label)
            
            let nameLabel = UILabel.init(frame: CGRectMake(CGFloat(index) * (ScreenWidth / 3), label.bottom(), ScreenWidth / 3, 21))
            nameLabel.text = index == 0 ? "我的订阅" : index == 2 ? "我的收藏" : "我的咨询"
            nameLabel.textAlignment = NSTextAlignment.Center
            nameLabel.textColor = UIColor.whiteColor()
            nameLabel.font = UIFont.systemFontOfSize(14)
            bottomView.addSubview(nameLabel)
            
            if index < 2 {
                
                let lineView = UIView.init(frame: CGRectMake(index == 0 ? ScreenWidth / 3 : ScreenWidth / 3 * 2, 0, 1, 28))
                lineView.backgroundColor = UIColor.RGB(0x25daac)
                lineView.alpha = 0.2
                lineView.center = CGPointMake(lineView.center.x, 25)
                bottomView.addSubview(lineView)
            }
        }
    }
}
