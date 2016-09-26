//
//  CodeView.swift
//  QYSwift
//
//  Created by 张健 on 16/9/26.
//  Copyright © 2016年 张健. All rights reserved.
//

import UIKit

typealias phoneBlock = (dic : NSDictionary)->Void
var PhoneBlock  = phoneBlock?()

class CodeView: UIView {

    var phoneTextField : UITextField!
    init(frame: CGRect,block:(dic : NSDictionary)->Void) {
        super.init(frame: frame)
        
        PhoneBlock = block
        
        self.createSelf()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSelf() -> Void {
        
        
        //区号
        let leftLabel = UILabel.init(frame: CGRectMake(25, 40, String.zjSizeWithString("+86", font: UIFont.systemFontOfSize(14), sizeWidth: 0, sizeHeight: 18) , 18))
        leftLabel.text = "+86"
        leftLabel.font = UIFont.systemFontOfSize(14)
        leftLabel.textColor = UIColor.whiteColor()
        self.addSubview(leftLabel)
        
        //区号图标
        let imageView = UIImageView.init(frame: CGRectMake(leftLabel.right() + 10, 0, 5, 5))
        imageView.image = UIImage(named: "Phone_Arrow_5x5_")
        self.addSubview(imageView)
        
        //用户名
        phoneTextField = UITextField.init(frame: CGRectMake(imageView.right() + 15 , 40, ScreenWidth - (imageView.right() + 30), 40))
        phoneTextField.placeholder = "填写您的手机号"
        phoneTextField.font = UIFont.systemFontOfSize(14)
        phoneTextField.textColor  = UIColor.whiteColor()
        phoneTextField.clearButtonMode = .Always
        phoneTextField.keyboardType = .NumberPad
        phoneTextField.placeholderColor(UIColor.RGB(0xb6ffdf))
        self.addSubview(phoneTextField)
        
        
        leftLabel.center = CGPointMake(leftLabel.center.x, phoneTextField.center.y)
        imageView.center = CGPointMake(imageView.center.x, leftLabel.center.y)
        
        let phoneLineView = UIView.init(frame: CGRectMake(15, phoneTextField.bottom() , ScreenWidth - 30, 1))
        phoneLineView.backgroundColor = UIColor.RGB(0xf7fff9)
        self.addSubview(phoneLineView)

        //发送验证码
        let getCodeButton = UIButton.init(frame: CGRectMake(0, phoneLineView.bottom() + 85, 120, 32))
        getCodeButton.center = CGPointMake(ScreenWidth / 2, getCodeButton.center.y)
        getCodeButton.backgroundColor = UIColor.whiteColor()
        getCodeButton.setTitle("发送验证码", forState: UIControlState.Normal)
        getCodeButton.layer.cornerRadius = 4
        getCodeButton.setTitleColor(UIColor.RGB(0x25daac), forState: UIControlState.Normal)
        getCodeButton.bk_whenTapped {
            
            if (PhoneBlock != nil) {
                
                PhoneBlock!(dic: ["phone" : self.phoneTextField.text!])
                
            }
        }
        getCodeButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        self.addSubview(getCodeButton)
    }

}
