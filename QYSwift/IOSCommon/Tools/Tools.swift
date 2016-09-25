//
//  Tools.swift
//  HHXCSwift
//
//  Created by 张健 on 16/6/16.
//  Copyright © 2016年 张健. All rights reserved.
//

import Foundation
import UIKit


let ScreenWidth =  UIScreen.mainScreen().applicationFrame.width

let ScreenHeight =  UIScreen.mainScreen().applicationFrame.height

let bgColor : UIColor =  UIColor(red: 0/255.0, green: 175/255.0, blue: 240/255.0, alpha: 1)

let KEYWINDOW = UIApplication.sharedApplication().keyWindow!

let  autoSizeScaleWidth = ScreenWidth / 375
let  autoSizeScaleHeight  = ScreenHeight / 667

// 设备
let iPhone4S = ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Phone) && ScreenHeight < 568.0)


/**
 swift自定义Log
 - parameter message:    需要打印的内容
 - parameter file:     获取方法调用者所在的文件路径
 - parameter function: 获取方法调用者所在的方法名
 - parameter line:     获取所在的行数
 */

func YYNSLog<T>(message: T, fileName: String = #file, methodName: String =  #function, lineNumber: Int = #line)
{
    #if DEBUG
        let str : String = (fileName as NSString).pathComponents.last!.stringByReplacingOccurrencesOfString("swift", withString: "")
        print("当前类名称：\(str)当前方法名：\(methodName)[当前行数：\(lineNumber)]:打印内容：\(message)")
    #endif
}