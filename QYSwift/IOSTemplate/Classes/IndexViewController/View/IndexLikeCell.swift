//
//  IndexLikeCell.swift
//  QYSwift
//
//  Created by 张健 on 16/9/2.
//  Copyright © 2016年 张健. All rights reserved.
//

import UIKit

class IndexLikeCell: UITableViewCell {

    var topImageView    : UIImageView!
    var titleLabel      : UILabel!
    var leftLabel       : UILabel!
    var priceLabel      : UILabel!
    var noteStr         : NSMutableAttributedString!
    var price           : String!
    var iconImageView   : UIImageView!
    var rightalphaButton: UIButton!
    var rightalpheLabel : UILabel!
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
        topImageView = UIImageView.init(frame: CGRectMake(10, 0, ScreenWidth - 20, 119))
        self.contentView.addSubview(topImageView)

        //textLabel
        titleLabel = UILabel.init(frame: CGRectMake(10, topImageView.bottom() + 10, ScreenWidth - 20, 40))
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.systemFontOfSize(16)
        titleLabel.textColor = UIColor.RGB(0x242424)
        self.contentView.addSubview(titleLabel)
        
        //已售数量
        leftLabel = UILabel.init(frame: CGRectMake(10, titleLabel.bottom() + 10, ScreenWidth - 20, 20))
        leftLabel.font = UIFont.systemFontOfSize(13)
        leftLabel.textColor = UIColor.RGB(0xb3b3b3)
        self.contentView.addSubview(leftLabel)

        //价钱Label
        priceLabel = UILabel.init(frame: CGRectMake(10, titleLabel.bottom() + 10, ScreenWidth - 20, 20))
        priceLabel.font = UIFont.systemFontOfSize(13)
        priceLabel.textColor = UIColor.RGB(0xb3b3b3)
        priceLabel.textAlignment = NSTextAlignment.Right
        self.contentView.addSubview(priceLabel)
        
        
        //透明View
        rightalphaButton = UIButton.init(frame: CGRectMake(ScreenWidth - 20 - 68 - 9, 9, 68, 22))
        rightalphaButton.layer.cornerRadius = 11
        rightalphaButton.layer.masksToBounds = true
        rightalphaButton.backgroundColor = UIColor.blackColor()
        rightalphaButton.alpha = 0.3
        topImageView.addSubview(rightalphaButton)
        
        
        iconImageView = UIImageView.init(frame: CGRectMake(10, 0, 11, 11))
        iconImageView.center = CGPointMake(rightalphaButton.center.x - 18, rightalphaButton.center.y)
        topImageView.addSubview(iconImageView)
        
        rightalpheLabel = UILabel.init(frame: CGRectMake(0, 0, rightalphaButton.width() - iconImageView.right(), 22))
        rightalpheLabel.textColor = UIColor.whiteColor()
        rightalpheLabel.font = UIFont.systemFontOfSize(11)
        rightalpheLabel.center = CGPointMake(rightalphaButton.center.x + 8, rightalphaButton.center.y)
        rightalpheLabel.textAlignment = NSTextAlignment.Center
        topImageView.addSubview(rightalpheLabel)
    }
    
    func model(moel : IndexLikeModel) -> Void {

        topImageView.sd_setImageWithURL(NSURL.init(string: moel.pic!), placeholderImage: UIImage(named: "Recommand_Discount_Normal_300x120_"))
        titleLabel.text = moel.title
        leftLabel.text = moel.sale_count! == "0" ? "新品上架" : "\(moel.sale_count!)已售"
        leftLabel.textColor = moel.sale_count! == "0" ? UIColor.RGB(0x25daac) : UIColor.RGB(0xb3b3b3)

        price = moel.price!.stringByReplacingOccurrencesOfString("<em>", withString: "")
        price = price.stringByReplacingOccurrencesOfString("</em>", withString: "")

        //改变价钱颜色
        noteStr = NSMutableAttributedString.init(string: price)
        noteStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.RGB(0xf57b76), range: NSRange.init(location: 0, length: price.componentsSeparatedByString("元")[0].characters.count))
        noteStr.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFontOfSize(17), range: NSRange.init(location: 0, length: price.componentsSeparatedByString("元")[0].characters.count))
        priceLabel.attributedText = noteStr
        
//        YYNSLog("\(moel.ptype_icon!)")
        iconImageView.sd_setImageWithURL(NSURL.init(string: moel.ptype_icon == nil ? "" : moel.ptype_icon!))

        
        rightalpheLabel.text = moel.cate_short_name!
        

    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
