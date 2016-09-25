//
//  IndexLabelCell.swift
//  QYSwift
//
//  Created by 张健 on 16/9/2.
//  Copyright © 2016年 张健. All rights reserved.
//

import UIKit

class IndexLabelCell: UITableViewCell {

    var topLabel : UILabel!
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
    
        topLabel = UILabel.init(frame: CGRectMake(0, 0, ScreenWidth, 50))
        topLabel.textColor = UIColor.RGB(0x242424)
        topLabel.textAlignment = NSTextAlignment.Center
        topLabel.font = UIFont.boldSystemFontOfSize(16)
        self.contentView.addSubview(topLabel)

    }
    
    func showLabelText(text : String) -> Void {
        
        topLabel.text = text
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
