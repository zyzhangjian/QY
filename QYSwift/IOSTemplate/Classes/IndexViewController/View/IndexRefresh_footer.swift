//
//  IndexRefresh_footer.swift
//  QYSwift
//
//  Created by 张健 on 16/9/2.
//  Copyright © 2016年 张健. All rights reserved.
//

import UIKit

class IndexRefresh_footer: MJRefreshBackGifFooter {

    var idleImages          : NSMutableArray!
    var refreshingImages    : NSMutableArray!
    
    override func prepare() -> Void {
        
       super.prepare()
        
        // 设置普通状态的动画图片
        idleImages = NSMutableArray()
        
        for index in 1..<21 {
            
            let image = UIImage(named: "loading52－\(index)")
            idleImages.addObject(image!)
        }
        
        self.setImages(idleImages as [AnyObject], forState: MJRefreshState.Idle)
        
        
        // 设置普通状态的动画图片
        refreshingImages = NSMutableArray()
        
        for index in 1..<21 {
            
            let image = UIImage(named: "loading52－\(index)")
            refreshingImages.addObject(image!)
        }
        
        self.setImages(refreshingImages as [AnyObject], forState: MJRefreshState.Pulling)
        
        
        // 设置正在刷新状态的动画图片
        self.setImages(refreshingImages as [AnyObject], forState: MJRefreshState.Refreshing)


    }

}
