//
//  IndexTravelCell.swift
//  QYSwift
//
//  Created by 张健 on 16/9/1.
//  Copyright © 2016年 张健. All rights reserved.
//

import UIKit

class IndexTravelCell: UITableViewCell {

    var rootSV          : UIScrollView!
    var isHasCreate     : Bool = false
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
        
        rootSV = UIScrollView.init(frame: CGRectMake(0, 0, ScreenWidth, 175))
        rootSV.showsVerticalScrollIndicator = false;
        rootSV.showsHorizontalScrollIndicator = false;
        rootSV.delegate = self
        self.contentView.addSubview(rootSV)
        
        let topLabel = UILabel.init(frame: CGRectMake(0, 0, ScreenWidth, 50))
        topLabel.textColor = UIColor.RGB(0x242424)
        topLabel.text = "出行必备"
        topLabel.textAlignment = NSTextAlignment.Center
        topLabel.font = UIFont.boldSystemFontOfSize(16)
        self.contentView.addSubview(topLabel)
        
    }
    
    func createSlideView(array : NSMutableArray) -> Void {
        
        if isHasCreate {return}

        let viewWidth  : CGFloat  = 105
        let viewHeight : CGFloat = 60

        for index in 0 ..< array.count {
            
            let model : IndexTravelModel = array[index] as! IndexTravelModel
            
            let imageView = UIImageView.init(frame: CGRectMake(10 + CGFloat(index) * (viewWidth + 5), 50, viewWidth, viewHeight))
            imageView.tag = index + 100
            imageView.sd_setImageWithURL(NSURL.init(string: model.cover!))
            rootSV.addSubview(imageView)
        }
        
        rootSV.contentSize = CGSizeMake((rootSV.viewWithTag(array.count - 1 + 100) as! UIImageView).right() + 10, 0)

        isHasCreate = true
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension IndexTravelCell : UIScrollViewDelegate {
    
    
}
