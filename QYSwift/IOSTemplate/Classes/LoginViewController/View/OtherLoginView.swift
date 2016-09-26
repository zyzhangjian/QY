//
//  OtherLoginView.swift
//  QYSwift
//
//  Created by 张健 on 16/9/26.
//  Copyright © 2016年 张健. All rights reserved.
//

import UIKit

let otherViewWidth : CGFloat = 41

typealias otherBlock = (code  : Int)->Void
var OtherLoginBlock  = otherBlock?()

class OtherLoginView: UIView {

   init(frame: CGRect, block:(code  : Int)->Void) {
        super.init(frame: frame)

        OtherLoginBlock = block
        
        self.createSelf()
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createSelf() -> Void {
        
        let label = UILabel.init(frame: CGRectMake(0, 0, ScreenWidth, 17))
        label.text = "第三方账号登录"
        label.font = UIFont.systemFontOfSize(12)
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center
        self.addSubview(label)
        
        let iconView = UIView.init(frame: CGRectMake(0, label.bottom() + 15, otherViewWidth * 3 + 30, 50))
        iconView.center = CGPointMake(ScreenWidth / 2, iconView.center.y)
        self.addSubview(iconView)
        
        let imageArray = ["Third_Weibo_50x50_","Third_QQ_50x50_","Third_WeiXin_50x50_"]
        
        for index in 0 ..< 3 {
            
            let imageView = UIImageView.init(frame: CGRectMake(CGFloat(index) * otherViewWidth + CGFloat(index) * 15, 0, otherViewWidth, otherViewWidth))
            imageView.image = UIImage(named: imageArray[index])
            imageView.tag = index
            imageView.userInteractionEnabled = true
            imageView.bk_whenTapped({ 
                
                OtherLoginBlock!(code: imageView.tag)
            })
            iconView.addSubview(imageView)
            
        }
    }
    
}
