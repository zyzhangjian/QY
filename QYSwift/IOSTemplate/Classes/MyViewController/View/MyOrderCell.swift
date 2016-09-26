//
//  MyOrderCell.swift
//  QYSwift
//
//  Created by 张健 on 16/9/24.
//  Copyright © 2016年 张健. All rights reserved.
//

import UIKit



class MyOrderCell: UITableViewCell {

    typealias orderBlock = (code : Int)->Void
    var myOrderBlock  = orderBlock?()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .None

        self.createSelf()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSelf() -> Void {
        
        let topView = UIView.init(frame: CGRectMake(0, 0, ScreenWidth , 40))
        self.contentView.addSubview(topView)
        

        let myOrderLabel = UILabel.init(frame: CGRectMake(10, 0, ScreenWidth - 10, 40))
        myOrderLabel.text = "我的订单"
        myOrderLabel.textColor = UIColor.RGB(0xaaaaaa)
        myOrderLabel.font = UIFont.systemFontOfSize(14)
        myOrderLabel.textAlignment = NSTextAlignment.Left
        topView.addSubview(myOrderLabel)
        
        let myAllOrderLabel = UILabel.init(frame: CGRectMake(0, 0, ScreenWidth - 21, 40))
        myAllOrderLabel.text = "查看全部订单 >"
        myAllOrderLabel.textColor = UIColor.RGB(0x25daac)
        myAllOrderLabel.bk_whenTapped({
            
            if self.myOrderBlock != nil {
                
                self.myOrderBlock!(code: 0)
            }
        })
        myAllOrderLabel.font = UIFont.systemFontOfSize(14)
        myAllOrderLabel.textAlignment = NSTextAlignment.Right
        topView.addSubview(myAllOrderLabel)
        
        let topLineView = UIView.init(frame: CGRectMake(0, myOrderLabel.bottom(), ScreenWidth, 0.5))
        topLineView.backgroundColor = UIColor.RGB(0xe6e6e6)
        topView.addSubview(topLineView)

        
        let bottomView = UIView.init(frame: CGRectMake(0, topView.bottom(), ScreenWidth , 70))
        self.contentView.addSubview(bottomView)
        
        let imageArray = ["Mine_Pay_25x25_","Mine_Information_25x25_","Mine_Trip_25x25_","Mine_exchange_25x25_"]
        
        let textArray = ["待付款","待补充","待出行","退款/售后"]
        
        for index in 0 ..< 4 {
            
            let button = UIButton.init(frame: CGRectMake(CGFloat(index) * (ScreenWidth / 4), 0, ScreenWidth / 4, 70))
            button.tag = index
            button.bk_whenTapped({ 
                
                if self.myOrderBlock != nil {
                    
                    self.myOrderBlock!(code: index + 1)
                }
            })
            bottomView.addSubview(button)
            
            let imageView = UIImageView.init(frame: CGRectMake(0, 14, 25, 25))
            imageView.image = UIImage(named: imageArray[index])
            imageView.center = CGPointMake(ScreenWidth / 4 / 2, imageView.center.y)
            button.addSubview(imageView)
            
            
            let myOrderNameLabel = UILabel.init(frame: CGRectMake(0, imageView.bottom() + 5, ScreenWidth / 4, 21))
            myOrderNameLabel.text = textArray[index]
            myOrderNameLabel.textColor = UIColor.RGB(0x505050)
            myOrderNameLabel.font = UIFont.systemFontOfSize(14)
            myOrderNameLabel.textAlignment = NSTextAlignment.Center
            button.addSubview(myOrderNameLabel)

        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
