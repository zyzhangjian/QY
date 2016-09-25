//
//  IndexHotCell.swift
//  QYSwift
//
//  Created by 张健 on 16/9/2.
//  Copyright © 2016年 张健. All rights reserved.
//

import UIKit

class IndexHotCell: UITableViewCell {

    var rootSV          : UIScrollView!
    var topImageView    : UIImageView!
    var price           : String!
    var noteStr         : NSMutableAttributedString!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI() -> Void {
        
        //topImageView
        topImageView = UIImageView.init(frame: CGRectMake(0, 0, ScreenWidth, 119))
        self.contentView.addSubview(topImageView)
        
        //rootSV
        rootSV = UIScrollView.init(frame: CGRectMake(0, topImageView.bottom() + 10 , ScreenWidth, 319 - (topImageView.bottom() + 10)))
        rootSV.showsVerticalScrollIndicator   = false
        rootSV.showsHorizontalScrollIndicator = false
        rootSV.delegate = self
        self.contentView.addSubview(rootSV)
        
        
        let iconImage = UIImageView.init(frame: CGRectMake(0, 111, 16, 9))
        iconImage.image = UIImage(named: "Recommand_White_ Triangle_16x9_")
        iconImage.center = CGPointMake(ScreenWidth / 2, iconImage.center.y)
        topImageView.addSubview(iconImage)
 
        for index in 0 ..< 8  {
            
            let rootView = UIView.init(frame: CGRectMake(10 + CGFloat(index) * (140 + 10), 0, 140, 319 - (iconImage.bottom() + 10)))
            rootView.tag = index + 100
            rootSV.addSubview(rootView)

                //topImagView
                let topImageView = UIImageView.init(frame: CGRectMake(0, 0, rootView.width(), 100))
                topImageView.tag = index + 200
                if index == 7 {
                    
                    topImageView.layer.borderWidth = 0.5
                    topImageView.layer.borderColor = UIColor.RGB(0xeeeeee).CGColor
                }
                rootView.addSubview(topImageView)
            
            
            if index < 7 {
                
                //textLabel
                let titleLabel = UILabel.init(frame: CGRectMake(0, topImageView.bottom() + 10, rootView.width(), 40))
                titleLabel.tag = index + 300
                titleLabel.numberOfLines = 2
                titleLabel.font = UIFont.systemFontOfSize(16)
                titleLabel.textColor = UIColor.RGB(0x242424)
                rootView.addSubview(titleLabel)
                
                //priceLabel
                let priceLabel = UILabel.init(frame: CGRectMake(0, titleLabel.bottom() + 10, rootView.width(), 21))
                priceLabel.tag = index + 400
                priceLabel.textColor = UIColor.RGB(0xb3b3b3)
                priceLabel.font = UIFont.systemFontOfSize(13)
                rootView.addSubview(priceLabel)

            }
            
            
            if index == 7 {
                
                let image = UIImageView.init(frame: CGRectMake(0, 21, 33, 33))
                image.center = CGPointMake(70, image.center.y)
                image.image = UIImage(named: "Dissertination_More_33x33_")
                topImageView.addSubview(image)
                
                let label = UILabel.init(frame: CGRectMake(0, image.bottom(), topImageView.width(), topImageView.height() - (image.bottom())))
                label.text = "查看更多"
                label.textColor = UIColor.RGB(0x25daac)
                label.textAlignment = NSTextAlignment.Center
                topImageView.addSubview(label)

            }
            
        }
        
        rootSV.contentSize = CGSizeMake((rootSV.viewWithTag(107))!.right() + 10, 0)
    }
    
    
    func model(model : IndexHotModel) -> Void {

        topImageView.sd_setImageWithURL(NSURL.init(string: model.img!))
        
        for index in 0 ..< model.eliteArray.count {

            let model : IndexHotEliteModel = model.eliteArray[index] as! IndexHotEliteModel
            
            ((rootSV.viewWithTag(index + 100))?.viewWithTag(index + 200) as! UIImageView).sd_setImageWithURL(NSURL.init(string: model.pic!))
            ((rootSV.viewWithTag(index + 100))?.viewWithTag(index + 300) as! UILabel).text = model.title!
            
            price = model.price!.stringByReplacingOccurrencesOfString("<em>", withString: "")
            price = price.stringByReplacingOccurrencesOfString("</em>", withString: "")

            
            //改变价钱颜色
            noteStr = NSMutableAttributedString.init(string: price)
            noteStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.RGB(0xf57b76), range: NSRange.init(location: 0, length: price.componentsSeparatedByString("元")[0].characters.count))
            noteStr.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFontOfSize(17), range: NSRange.init(location: 0, length: price.componentsSeparatedByString("元")[0].characters.count))
            ((rootSV.viewWithTag(index + 100))?.viewWithTag(index + 400) as! UILabel).attributedText = noteStr
        }
        
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension IndexHotCell : UIScrollViewDelegate {
    
    
}
