//
//  DestinaCollectionView.swift
//  QYSwift
//
//  Created by 张健 on 16/9/21.
//  Copyright © 2016年 张健. All rights reserved.
//

import UIKit

typealias collectionBlock = (code : Int)->Void
var desCollectionBlock  = collectionBlock?()

class DestinaCollectionView: UICollectionView{

    
    var dataArray = NSArray()
    
    init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout,VC : DestinationViewController, block:(code : Int)->Void) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        desCollectionBlock = block
        
        self.backgroundColor = UIColor.RGB(0xf5f5f5)
        
        self.delegate = self
        self.dataSource = self
        
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
        self.registerClass(DestinaCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        VC.view.addSubview(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension DestinaCollectionView : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataArray.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell : DestinaCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! DestinaCollectionViewCell
        
        let model : DestinationDetailModel = dataArray[indexPath.row] as! DestinationDetailModel
        
        cell.model(model)
        
        return cell
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }

}