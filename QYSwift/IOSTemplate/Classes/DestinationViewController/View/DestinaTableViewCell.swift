//
//  DestinaTableViewCell.swift
//  QYSwift
//
//  Created by 张健 on 16/9/21.
//  Copyright © 2016年 张健. All rights reserved.
//

import UIKit

class DestinaTableViewCell: UITableViewCell {

    var cityLabel  : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .None
        
        cityLabel = UILabel.init(frame: CGRectMake(0, 0, 80, 47))
        cityLabel.textAlignment = NSTextAlignment.Center
        cityLabel.textColor = UIColor.RGB(0x535354)
        cityLabel.font = UIFont.systemFontOfSize(12)
        self.contentView.addSubview(cityLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
