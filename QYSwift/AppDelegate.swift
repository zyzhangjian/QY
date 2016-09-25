//
//  AppDelegate.swift
//  QYSwift
//
//  Created by 张健 on 16/8/30.
//  Copyright © 2016年 张健. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var conn: Reachability?
    
    
    func NetworkStatusListener() {
        // 1、设置网络状态消息监听
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.networkStatusChange), name: ReachabilityChangedNotification, object: nil);
        // 2、获得网络Reachability对象
        // Reachability必须一直存在，所以需要设置为全局变量
        conn = Reachability.reachabilityForInternetConnection()!;
        // 3、开启网络状态消息监听
        conn!.startNotifier();
    }
    
    func networkStatusChange() {
        checkNetworkStatus();
    }
    
    /**
     移除消息通知
     */
    deinit {
        // 关闭网络状态消息监听
        conn!.stopNotifier();
        // 移除网络状态消息通知
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    /**
     主动检测网络状态
     */
    func checkNetworkStatus() {
        let reachability = Reachability.reachabilityForInternetConnection() // 准备获取网络连接信息
        
        if reachability!.isReachable() { // 判断网络连接状态
            print("网络连接：可用")
            if reachability!.isReachableViaWiFi() { // 判断网络连接类型
                print("连接类型：WiFi")
            } else if reachability!.isReachableViaWWAN() {
                print("连接类型：移动网络")
            }
        }else{
            print("网络连接：不可用")
            print("连接类型：没有网络连接")
        }
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //状态栏文字白色
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)

        checkNetworkStatus()        // 启动时判断一次网络连接状态
        NetworkStatusListener()     // 开启网络状态监听
//        
//        [[UITableView appearance] setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
//        
//        [[UITableView appearance] setSeparatorInset:UIEdgeInsetsZero];
//        
//        [[UITableViewCell appearance] setSeparatorInset:UIEdgeInsetsZero];
//        
//        if ([UITableView instancesRespondToSelector:@selector(setLayoutMargins:)]) {
//            
//            [[UITableView appearance] setLayoutMargins:UIEdgeInsetsZero];
//            
//            [[UITableViewCell appearance] setLayoutMargins:UIEdgeInsetsZero];
//            
//            [[UITableViewCell appearance] setPreservesSuperviewLayoutMargins:NO];
//            
//        }
        
        
        return true
    }


    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

