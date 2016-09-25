//
//  IndexActivityCell.swift
//  QYSwift
//
//  Created by 张健 on 16/9/1.
//  Copyright © 2016年 张健. All rights reserved.
//

import UIKit

class IndexActivityCell: UITableViewCell {

    var leftImage           : UIImageView!
    var rightImage          : UIImageView!
    var rightTopImage       : UIImageView!
    var rightBottomImage    : UIImageView!
    
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
        
        leftImage = UIImageView.init(frame: CGRectMake(0, 0, ScreenWidth / 3,145))
        leftImage.contentMode = UIViewContentMode.ScaleAspectFit
        self.contentView.addSubview(leftImage)
        
        let lineView = UIView.init(frame: CGRectMake(ScreenWidth / 3, 0, 0.5, 145))
        lineView.backgroundColor = UIColor.RGB(0xeeeeee)
        self.contentView.addSubview(lineView)
        
        rightImage = UIImageView.init(frame: CGRectMake(leftImage.right() + 1, 0, ScreenWidth - leftImage.width() + 1 ,73))
        rightImage.contentMode = UIViewContentMode.ScaleAspectFit
        self.contentView.addSubview(rightImage)
        
        let lineTopView = UIView.init(frame: CGRectMake(ScreenWidth / 3, 70,ScreenWidth - ScreenWidth / 3, 0.5))
        lineTopView.backgroundColor = UIColor.RGB(0xeeeeee)
        self.contentView.addSubview(lineTopView)

        
        rightTopImage = UIImageView.init(frame: CGRectMake(leftImage.right() + 1, 74, rightImage.width() / 2 ,72))
        rightTopImage.contentMode = UIViewContentMode.ScaleAspectFit
        self.contentView.addSubview(rightTopImage)

        
        let lineBottomView = UIView.init(frame: CGRectMake(ScreenWidth / 3 + rightImage.width() / 2, 70,0.5, 76))
        lineBottomView.backgroundColor = UIColor.RGB(0xeeeeee)
        self.contentView.addSubview(lineBottomView)
        
        rightBottomImage = UIImageView.init(frame: CGRectMake(rightTopImage.right() + 1, 74,rightImage.width() / 2 ,72))
        rightBottomImage.contentMode = UIViewContentMode.ScaleAspectFit
        self.contentView.addSubview(rightBottomImage)

    }
    
    func model(array : NSMutableArray) -> Void {
        
        for index in 0 ..< array.count {
            
            let model : IndexPromoModel = array[index] as! IndexPromoModel
            
            if index == 0 {
                
                leftImage.sd_setImageWithURL(NSURL.init(string:"\(model.img!)"))
                
            }else if index == 1 {
                
                rightImage.sd_setImageWithURL(NSURL.init(string:"\(model.img!)"))
                
            }else if index == 2 {
                
                rightTopImage.sd_setImageWithURL(NSURL.init(string:"\(model.img!)"))
                
            }else if index == 3 {
                
                rightBottomImage.sd_setImageWithURL(NSURL.init(string:"\(model.img!)"))
                
            }
        }
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
