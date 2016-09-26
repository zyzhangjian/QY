
//
//  AccountView.swift
//  QYSwift
//
//  Created by 张健 on 16/9/26.
//  Copyright © 2016年 张健. All rights reserved.
//

import UIKit

typealias accountBlock = (dic : NSDictionary)->Void
var userIDBlock  = accountBlock?()

class AccountView: UIView {

    var userIDTextField     : UITextField!
    var userPWDTextField    : UITextField!
    
    init(frame: CGRect,block:(dic : NSDictionary)->Void) {
        super.init(frame: frame)
        
        userIDBlock = block
        
        self.createSelf()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSelf() -> Void {
        
        //用户名
        userIDTextField = UITextField.init(frame: CGRectMake(15, 40, ScreenWidth - 30, 40))
        userIDTextField.placeholder = "输入邮箱/用户名"
        userIDTextField.font = UIFont.systemFontOfSize(14)
        userIDTextField.textColor  = UIColor.whiteColor()
        userIDTextField.clearButtonMode = .Always
        userIDTextField.placeholderColor(UIColor.RGB(0xb6ffdf))
        self.addSubview(userIDTextField)
        
        let userIDLineView = UIView.init(frame: CGRectMake(15, userIDTextField.bottom() , ScreenWidth - 30, 1))
        userIDLineView.backgroundColor = UIColor.RGB(0xf7fff9)
        self.addSubview(userIDLineView)
        
        //用户密码
        userPWDTextField = UITextField.init(frame: CGRectMake(15, userIDLineView.bottom() , ScreenWidth - 30, 40))
        userPWDTextField.placeholder = "输入密码"
        userPWDTextField.font = UIFont.systemFontOfSize(14)
        userPWDTextField.textColor  = UIColor.whiteColor()
        userPWDTextField.secureTextEntry = true
        userPWDTextField.clearButtonMode = .Always
        userPWDTextField.placeholderColor(UIColor.RGB(0xb6ffdf))
        self.addSubview(userPWDTextField)
        
        let userPWDLineView = UIView.init(frame: CGRectMake(15, userPWDTextField.bottom() , ScreenWidth - 30, 1))
        userPWDLineView.backgroundColor = UIColor.RGB(0xf7fff9)
        self.addSubview(userPWDLineView)
        
        
        //忘记密码 
        let forgetPwd = UILabel.init(frame: CGRectMake(0, userPWDLineView.bottom() + 17, String.zjSizeWithString("忘记密码?", font: UIFont.systemFontOfSize(14), sizeWidth: 0, sizeHeight: 21) , 21))
        forgetPwd.center = CGPointMake(self.center.x, forgetPwd.center.y)
        forgetPwd.font = UIFont.systemFontOfSize(14)
        forgetPwd.bk_whenTapped { 
            
            if (userIDBlock != nil) {
                
                userIDBlock!(dic: ["code" : "0"])
            }
        }
        forgetPwd.bottomLine("忘记密码?")
        forgetPwd.textColor = UIColor.RGB(0x80ffcd)
        self.addSubview(forgetPwd)
        
        //登录按钮
        let loginButton = UIButton.init(frame: CGRectMake(0, forgetPwd.bottom() + 55, 120, 32))
        loginButton.center(self)
        loginButton.backgroundColor = UIColor.whiteColor()
        loginButton.setTitle("登录", forState: UIControlState.Normal)
        loginButton.setTitleColor(UIColor.RGB(0x25daac), forState: UIControlState.Normal)
        loginButton.bk_whenTapped { 
            
            if (userIDBlock != nil) {
                
                userIDBlock!(dic: ["code" : "1","userID" : self.userIDTextField.text!,"pwd" : self.userPWDTextField.text!])

            }
        }
        loginButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        self.addSubview(loginButton)
        
        //手机号登录
        let phoneLogin = UILabel.init(frame: CGRectMake(0, loginButton.bottom() + 18, ScreenWidth, 21))
        phoneLogin.font = UIFont.systemFontOfSize(14)
        phoneLogin.text = "手机号登录"
        phoneLogin.bk_whenTapped { 
            
            if (userIDBlock != nil) {
                
                userIDBlock!(dic: ["code" : "2"])
            }
        }
        phoneLogin.textAlignment = NSTextAlignment.Center
        phoneLogin.textColor = UIColor.whiteColor()
        self.addSubview(phoneLogin)

        
    }

}
