//
//  MyVCTableView.swift
//  QYSwift
//
//  Created by 张健 on 16/9/24.
//  Copyright © 2016年 张健. All rights reserved.
//

import UIKit

typealias myVCBlock = (dic : NSDictionary)->Void
var myTableBlock  = myVCBlock?()

let topImageViewHeight : CGFloat = 210

class MyVCTableView: UITableView {
    
    var headerTopView   : UIImageView!
    
    var myVC            : MyViewController!
    
    var infoView        : MyInfoView!
    
    var textArray       : NSArray!

    init(frame: CGRect, style: UITableViewStyle,VC : MyViewController, block:(dic : NSDictionary)->Void) {
        super.init(frame: frame, style: style)
        
        myTableBlock    = block
        myVC = VC
        
        textArray       = [["Mine_Coupon_20x20_","Mine_QA_20x20_","Mine_More_20x19_"],["我的优惠券","常见问题及意见反馈","更多设置"]]
        
        self.delegate   = self
        self.dataSource = self
        self.contentInset = UIEdgeInsetsMake(topImageViewHeight, 0, 0, 0)
    
        self.createSelf()
        
        VC.view.addSubview(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createSelf() -> Void {
        
        //头部背景图片
        headerTopView = UIImageView.init(frame: CGRectMake(0, -topImageViewHeight, ScreenWidth, topImageViewHeight))
        headerTopView.image = UIImage(named: "Mine_TwitterHead_1280x696_")
        self.addSubview(headerTopView)
        
        //个人信息View
        infoView  = MyInfoView.init(frame: CGRectMake(0, -138, ScreenWidth, 138), block: { (code) in

            if (myTableBlock != nil) {
                
                myTableBlock!(dic: ["code" : "1"])
            }
            
        })
        self.addSubview(infoView)
        
        //注册cell
        self.registerClass(MyOrderCell.self, forCellReuseIdentifier: "topCell")
        self.registerClass(MyOtherCell.self, forCellReuseIdentifier: "bottomCell")
    }

}

// MARK: - UITableViewDataSource、UIScrollViewDelegate
extension MyVCTableView : UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return section == 0 ? 1 : 3
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if (myTableBlock != nil) {
            
            myTableBlock!(dic: ["code" : "2","path" : "\(indexPath.row)"])
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return indexPath.section == 0 ? 110 : 55
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell : MyOrderCell = tableView.dequeueReusableCellWithIdentifier("topCell") as! MyOrderCell
            
            cell.myOrderBlock = { (code : Int) -> Void in

                if (myTableBlock != nil) {
                    
                    myTableBlock!(dic: ["code" : "1"])
                }
            }

            return cell
            
        }else{
            
            let cell : MyOtherCell = tableView.dequeueReusableCellWithIdentifier("bottomCell") as! MyOtherCell
            
            cell.model((textArray[0] as! NSArray)[indexPath.row] as! String, labelString: (textArray[1] as! NSArray)[indexPath.row] as! String)
            
            return cell
            
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
    }
    

    func scrollViewDidScroll(scrollView: UIScrollView)  {

        let y = scrollView.contentOffset.y
        let x = (y + topImageViewHeight) / 2

        if y < -topImageViewHeight {
    
            var rect = headerTopView.frame
            rect.origin.y = y
            rect.size.height = -y
            rect.origin.x = x
            rect.size.width = ScreenWidth + fabs(x) * 2
            
            headerTopView.frame = rect
            
        }
        
        let alpha = y > -64 ? 1 : (y + topImageViewHeight) / topImageViewHeight
 
        myVC.titleViewimageView.alpha = alpha

    }
    
}


