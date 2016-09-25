//
//  DestinationTableVie.swift
//  QYSwift
//
//  Created by 张健 on 16/9/19.
//  Copyright © 2016年 张健. All rights reserved.
//

import UIKit

typealias DesBlock = (model : DestinationModel)->Void
var desTableBlock  = DesBlock?()

class DestinationTableVie: UITableView {

    var dataArray               = NSArray()
    var select_row  : NSInteger = 0           //记录点击哪个cell
    
    init(frame: CGRect, style: UITableViewStyle, VC : DestinationViewController, block:(model : DestinationModel)->Void) {
        super.init(frame: frame, style: style)

        desTableBlock = block

        self.createUI()
        
        VC.view.addSubview(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI() -> Void {
        
        self.delegate   = self
        self.dataSource = self
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
        self.registerClass(DestinaTableViewCell.self, forCellReuseIdentifier: "desCell")
        
        //tableview分割线对齐
        if self.respondsToSelector(Selector("setSeparatorInset:")){
            self.separatorInset = UIEdgeInsetsZero
        }
        if self.respondsToSelector(Selector("setLayoutMargins:")){
            if #available(iOS 8.0, *) {
                self.layoutMargins = UIEdgeInsetsZero
            } else {
                // Fallback on earlier versions
            }
        }
    }

}

extension DestinationTableVie : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 47
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : DestinaTableViewCell = tableView.dequeueReusableCellWithIdentifier("desCell") as! DestinaTableViewCell

        let model : DestinationModel = dataArray[indexPath.row] as! DestinationModel
        
        cell.cityLabel.text = model.name

        cell.cityLabel.textColor = indexPath.row == select_row ? UIColor.RGB(0x25daac) : UIColor.RGB(0x535354)

        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let model : DestinationModel = dataArray[indexPath.row] as! DestinationModel

        select_row = indexPath.row
        
        tableView.reloadData()
        
        if desTableBlock != nil {
            
            desTableBlock!(model: model)
        }
        
        
    }
    
    //tableview分割线对齐
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if cell.respondsToSelector(Selector("setLayoutMargins:")){
            if #available(iOS 8.0, *) {
                cell.layoutMargins = UIEdgeInsetsZero
            } else {
                // Fallback on earlier versions
            }
        }
        if cell.respondsToSelector(Selector("setSeparatorInset:")){
            cell.separatorInset = UIEdgeInsetsZero
        }  
    }
    

}
