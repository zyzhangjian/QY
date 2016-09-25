//
//  DestinaCollectionViewCell.swift
//  QYSwift
//
//  Created by 张健 on 16/9/21.
//  Copyright © 2016年 张健. All rights reserved.
//

import UIKit

class DestinaCollectionViewCell: UICollectionViewCell {
    
    var rootImageView   : UIImageView!
    var rootNameLabel   : UILabel!
    var rootEnNameLabel : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI() -> Void {
        
        rootImageView = UIImageView.init(frame: self.bounds)
        self.contentView.addSubview(rootImageView)
        
        rootNameLabel = UILabel.init(frame: CGRectMake(0, 17, self.width(), 21))
        rootNameLabel.textColor = UIColor.whiteColor()
        rootNameLabel.font = UIFont.boldSystemFontOfSize(14)
        rootNameLabel.textAlignment = .Center
        self.contentView.addSubview(rootNameLabel)
        
        rootEnNameLabel = UILabel.init(frame: CGRectMake(0, rootNameLabel.bottom(), self.width(), 21))
        rootEnNameLabel.textColor = UIColor.whiteColor()
        rootEnNameLabel.font = UIFont.boldSystemFontOfSize(13)
        rootEnNameLabel.textAlignment = .Center
        rootEnNameLabel.alpha = 0.7
        self.contentView.addSubview(rootEnNameLabel)

    }
    
    func model(model : DestinationDetailModel) -> Void {
        
        rootImageView.sd_setImageWithURL(NSURL.init(string: model.pic!), placeholderImage: UIImage(named: "placer_holder_gird"))
        rootNameLabel.text = model.name!
        rootEnNameLabel.text = model.name_en!
    }
}
