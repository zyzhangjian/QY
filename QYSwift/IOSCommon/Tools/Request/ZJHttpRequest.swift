//
//  ZJHttpRequest.swift
//  textswif
//
//  Created by 张健 on 15/6/25.
//  Copyright (c) 2015年 张健. All rights reserved.
//

import Foundation
import UIKit

typealias success = (result : NSDictionary)->Void

var successBlock = success?()

typealias failure = ()->Void

var failureBlock = failure?()

typealias network = ()->Void

var noNetWorkBlock = network?()

var reach   : Reachability!

var afReach : AFNetworkReachabilityManager!

//MARK: - 单利
class ZJHttpRequest: AFHTTPSessionManager {
    
    class var sharedInstance :ZJHttpRequest {
        struct Static {
            static var onceToken:dispatch_once_t = 0
            static var instance:ZJHttpRequest? = nil
        }
        
        dispatch_once(&Static.onceToken, { () -> Void in
            //string填写相应的baseUrl即可
            let url:NSURL = NSURL(string: zjBaseURL)!
            Static.instance = ZJHttpRequest(baseURL: url)
            reach = Reachability.init(hostname: "http://www.baidu.com")
            
            
        })
        
        //返回本类的一个实例
        return Static.instance!
        
    }
}

//MARk: - 封装AFN 网络方法
extension ZJHttpRequest {
    
    /// 网络请求
    ///
    /// - parameter method:     GET / POST
    /// - parameter url       :  URLString
    /// - parameter parameters: 参数字典
    /// - parameter finished:   完成回调
//    result: AnyObject?,error: NSError?)->()
    func Request(method: String, url: String,parameters: NSDictionary, finished:success,fali :failure,noNetWork:network) {

        if method == "GET" {

            if reach.currentReachabilityStatus == .None {
                noNetWork()
                return
            }
            
            
            let date = NSDate()
            let timeInterval = date.timeIntervalSince1970 * 1000
            let time = "&app_installtime=\(timeInterval)".componentsSeparatedByString(".")[0]
            
            // 设置请求超时时间
            self.requestSerializer.timeoutInterval = 15.0;
            
            //设置反序列化数据格式 －系统会自动将OC框架中的NSSet转换成 Set
            self.responseSerializer.acceptableContentTypes?.insert("text/html")
            self.responseSerializer.acceptableContentTypes?.insert("application/json")
            self.responseSerializer.acceptableContentTypes?.insert("text/json")
            self.responseSerializer.acceptableContentTypes?.insert("text/javascript")
            self.responseSerializer.acceptableContentTypes?.insert("text/plain")

            
            GET(url + time, parameters: parameters, progress: { (downloadProgress) in
                
               
                }, success: { (_, responseObject) in
        
                    finished(result: responseObject! as! NSDictionary)
                    
                }, failure: { (_, error) in
                    
                    fali()
            })
            

        }else{

            if reach.currentReachabilityStatus == .None {
                noNetWork()
                return
            }
        
            // 设置请求超时时间
            self.requestSerializer.timeoutInterval = 10.0;
            
            //设置反序列化数据格式 －系统会自动将OC框架中的NSSet转换成 Set
            self.responseSerializer.acceptableContentTypes?.insert("text/html")
            self.responseSerializer.acceptableContentTypes?.insert("application/json")
            self.responseSerializer.acceptableContentTypes?.insert("text/json")
            self.responseSerializer.acceptableContentTypes?.insert("text/javascript")
            self.responseSerializer.acceptableContentTypes?.insert("text/plain")
            
            
            let version  = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
            let params = parameters.mutableCopy()
            
            params.setValue("ios-saler", forKey: "mark")
            
            params.setValue(("\(NSDate().timeIntervalSince1970)".componentsSeparatedByString("."))[0], forKey: "time")
            
            params.setValue("3381JKHAWVTRKHZAOPYX10VEIT4TE9C5", forKey: "key")
            
            params.setValue(version, forKey: "version")
            
            params.setValue(self.zjMD5(params as! NSDictionary)  , forKey: "sign")
            
            
            
            POST(url, parameters: params, progress: { (downloadProgress) in
                
                }, success: { (_, responseObject) in
                    
                    finished(result: responseObject! as! NSDictionary)
                    
                }, failure: { (_, error) in
                    
                   fali()
            })
        }
        
    }
    
    func zjMD5(dic : NSDictionary) -> String{
        
        var zjStr : String = ""
        
        let keys : NSArray = dic.allKeys
        let sortedArray : NSArray = keys.sortedArrayUsingComparator { (obj1 : AnyObject,obj2 : AnyObject) -> NSComparisonResult in
            return  obj1.compare(obj2 as! String, options: NSStringCompareOptions.NumericSearch)
        }
        
        let array : NSArray = sortedArray
        
        for value in array {
            
            var values : String?
            
            if ((dic.objectForKey(value)?.isKindOfClass(NSDictionary)) != nil) {
                
                let str = dic.objectForKey(value) as! String
                
                values = str
            }
            
            zjStr += values!
            
        }
        
        zjStr = zjStr.getMd5()
        return zjStr
    }


}


