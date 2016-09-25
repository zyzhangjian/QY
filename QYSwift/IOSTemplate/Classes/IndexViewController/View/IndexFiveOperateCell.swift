//
//  IndexFiveOperateCell.swift
//  QYSwift
//
//  Created by 张健 on 16/9/2.
//  Copyright © 2016年 张健. All rights reserved.
//

import UIKit

class IndexFiveOperateCell: UITableViewCell {

    var rootImg : UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
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
     
        rootImg = UIImageView.init(frame: CGRectMake(10, 10, ScreenWidth - 20, 80))
        rootImg.backgroundColor = UIColor.redColor()
        self.contentView.addSubview(rootImg)
    }
    
    func model(model : IndexPromoModel) -> Void {
        
        rootImg.sd_setImageWithURL(NSURL.init(string: model.img!))
    }
    
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
