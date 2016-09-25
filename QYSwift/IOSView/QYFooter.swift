//
//  QYFooter.swift
//  QYSwift
//
//  Created by 张健 on 16/9/21.
//  Copyright © 2016年 张健. All rights reserved.
//

import UIKit

class QYFooter: MJRefreshAutoGifFooter {

    override func prepare() {
        super.prepare()
        
        // 设置正在刷新状态的动画图片
        let refreshingImages : NSMutableArray = NSMutableArray()
        
        for i in 1..<20 {
            
            let image = UIImage(named:"loading52－\(i)")
            refreshingImages.addObject(image!)
        }
        
        self.setImages(refreshingImages as [AnyObject], forState: MJRefreshState.Refreshing)
        
        self.setTitle("加载更多...", forState: MJRefreshState.Refreshing)
        self.setTitle("没有更多数据了", forState: MJRefreshState.NoMoreData)
        self.setTitle("点击或上拉加载更多", forState: MJRefreshState.Idle)

        self.stateLabel.textColor = UIColor.RGB(0x25daac)

    }
    
}
