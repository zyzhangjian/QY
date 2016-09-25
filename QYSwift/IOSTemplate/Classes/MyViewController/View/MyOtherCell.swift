//
//  MyOtherCell.swift
//  QYSwift
//
//  Created by 张健 on 16/9/24.
//  Copyright © 2016年 张健. All rights reserved.
//

import UIKit

class MyOtherCell: UITableViewCell {

    var iconImageView : UIImageView!
    var label         : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .None
        
        self.createSelf()
        
        self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSelf() -> Void {
        
        iconImageView = UIImageView.init(frame: CGRectMake(10, 20, 20, 20))
        iconImageView.center = CGPointMake(iconImageView.center.x , 55 / 2)
        self.contentView.addSubview(iconImageView)
        
        label = UILabel.init(frame: CGRectMake(iconImageView.right() + 5 , 0, ScreenWidth - (iconImageView.right() + 5), 55))
        label.textColor = UIColor.RGB(0x505050)
        label.font = UIFont.systemFontOfSize(14)
        label.textAlignment = NSTextAlignment.Left
        self.contentView.addSubview(label)
    }
    
    func model(iconImageName : String , labelString : String) -> Void {
        
        iconImageView.image = UIImage(named: iconImageName)
        label.text = labelString
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
