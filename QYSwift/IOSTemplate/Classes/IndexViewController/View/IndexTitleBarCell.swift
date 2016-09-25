//
//  IndexTitleBarCell.swift
//  QYSwift
//
//  Created by 张健 on 16/8/31.
//  Copyright © 2016年 张健. All rights reserved.
//

import UIKit

class IndexTitleBarCell: UITableViewCell {

    var rootSV          : UIScrollView!
    var isHasCreate     : Bool = false
    var iconImageView   : UIImageView!
    var bottomLabel     : UILabel!
    var pageControl     : UIPageControl?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI() -> Void {
        
        rootSV = UIScrollView.init(frame: CGRectMake(0, 0, ScreenWidth, 175))
        rootSV.showsVerticalScrollIndicator     = false
        rootSV.showsHorizontalScrollIndicator   = false
        rootSV.delegate = self
        self.contentView.addSubview(rootSV)
        
    }
    
    func createIcons(array : NSMutableArray) -> Void {

        if isHasCreate == true {return}
        
        let viewWidth : CGFloat  = ScreenWidth / 4
        let viewHeight : CGFloat = 175/2 - 20
        
        for index in 0 ..< array.count {
            
            let model : IndexTitleBarModel = array[index] as! IndexTitleBarModel
            
            let button = UIButton.init(frame: CGRectMake(index > 7 ? (CGFloat(index)%4)*viewWidth + ScreenWidth : (CGFloat(index)%4)*viewWidth, index > 7 ? 0 : CGFloat(index / 4 * 87), viewWidth, viewHeight))
            rootSV.addSubview(button)
            
            
            //icon
            iconImageView = UIImageView.init(frame: CGRectMake(0, 22, 31, 31))
            iconImageView.center = CGPointMake(viewWidth / 2, index > 3 && index <= 7 ? iconImageView.center.y - 10 : iconImageView.center.y)
            iconImageView.contentMode = UIViewContentMode.ScaleAspectFit
            iconImageView.sd_setImageWithURL(NSURL.init(string: model.icon!))
            button.addSubview(iconImageView)
            
            //label
            bottomLabel = UILabel.init(frame: CGRectMake(0, iconImageView.bottom() + 9 , button.width(), 17))
            bottomLabel.textColor = UIColor.RGB(0x242424)
            bottomLabel.font = UIFont.systemFontOfSize(14)
            bottomLabel.text = model.name
            bottomLabel.textAlignment = NSTextAlignment.Center
            button.addSubview(bottomLabel)
        }
        
        pageControl = UIPageControl.init(frame: CGRectMake(0, self.height() - 20, ScreenWidth, 21))
        pageControl!.numberOfPages = 2
        pageControl!.currentPage = 0
        pageControl!.currentPageIndicatorTintColor = UIColor.RGB(0x40c996)
        pageControl!.pageIndicatorTintColor = UIColor.RGB(0xcccccc)
        self.addSubview(pageControl!)
        
        rootSV.contentSize = CGSizeMake(array.count > 8 ? ScreenWidth * 2 :  ScreenWidth, 0)
        
        isHasCreate = true
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension IndexTitleBarCell : UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let page = Int(rootSV.contentOffset.x) / Int(ScreenWidth)
        
        pageControl!.currentPage = page
    
    }
}
