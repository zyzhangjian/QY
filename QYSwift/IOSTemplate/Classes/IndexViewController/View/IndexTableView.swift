//
//  IndexTableView.swift
//  QYSwift
//
//  Created by 张健 on 16/9/3.
//  Copyright © 2016年 张健. All rights reserved.
//

import UIKit

typealias block = (code : Int,bannerURL : String)->Void
var tableBlock  = block?()
var alpha               : CGFloat!
var rootVC              : ViewController!

class IndexTableView: UITableView,SDCycleScrollViewDelegate,UIScrollViewDelegate {
    
    var bannerArray         = NSMutableArray()
    var bannerImageArray    = NSMutableArray()
    var titleBarModelArray  = NSMutableArray()
    var promoModelArray     = NSMutableArray()
    var travelModelArray    = NSMutableArray()
    var hotModelArray       = NSMutableArray()
    var likeModelArray      = NSMutableArray()
    var bannerView          : SDCycleScrollView!
    
    
    init(frame: CGRect, style: UITableViewStyle,VC : ViewController, block:(code : Int,bannerURL : String)->Void) {
        super.init(frame: frame, style: style)
        
        tableBlock = block
        
        rootVC     = VC
        
        self.createSelf()
        
        self.createBannerView()
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createBannerView() -> Void {
        
        bannerView = SDCycleScrollView.init(frame: CGRectMake(0, 0,ScreenWidth, 160 * autoSizeScaleHeight), delegate: self, placeholderImage: UIImage(named: "Recommand_Discount_Normal_300x120_"))
        bannerView.autoScrollTimeInterval = 5;
        bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter
        self.tableHeaderView = bannerView

    }
    
    func createSelf() -> Void {
        
        self.backgroundColor = UIColor.redColor()
        self.delegate = self
        self.dataSource = self
        self.hidden = true
        self.separatorStyle = UITableViewCellSeparatorStyle.None
        self.backgroundColor = UIColor.whiteColor()
        self.contentInset = UIEdgeInsetsMake(-64, 0, -50, 0)
        
        
        //注册Cell
        self.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.registerClass(IndexTitleBarCell.self, forCellReuseIdentifier: "titleCell")
        self.registerClass(IndexActivityCell.self, forCellReuseIdentifier: "ActivityCell")
        self.registerClass(IndexTravelCell.self, forCellReuseIdentifier: "travelCell")
        self.registerClass(IndexFiveOperateCell.self, forCellReuseIdentifier: "fiveOperateCell")
        self.registerClass(IndexHotCell.self, forCellReuseIdentifier: "hotCell")
        self.registerClass(IndexLabelCell.self, forCellReuseIdentifier: "labelCell")
        self.registerClass(IndexLikeCell.self, forCellReuseIdentifier: "likeCell")
    

    }
}

extension IndexTableView : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 || section == 1 || section == 2 {
            
            return 1
            
        }else if section == 3 {
            
            if  self.promoModelArray
                .count > 4 {
                
                return 1
                
            }else{
                
                return self.hotModelArray.count + 1
            }
            
        }else if section == 4 {
            
            if  self.promoModelArray.count > 4 {
                
                return self.hotModelArray.count + 1
                
            }else{
                
                return self.likeModelArray.count + 1
            }
            
        }else if section == 5 {
            
            return self.likeModelArray.count + 1
        }
        
        
        return 5
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            return 175
            
        }else if indexPath.section == 1 {
            
            return 145
            
        }else if indexPath.section == 2 {
            
            return 125
            
        }else if indexPath.section == 3 {
            
            return self.promoModelArray.count > 4 ? 100 : (indexPath.row == 0 ? 50 : 319)
            
        }else if indexPath.section == 4 {
            
            return self.promoModelArray.count > 4 ? (indexPath.row == 0 ? 50 : 319) : (indexPath.row == 0 ? 50 : 210)
            
        }else if indexPath.section == 5 {
            
            return indexPath.row == 0 ? 50 : 210
        }
        
        return 44
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView.init(frame: CGRectMake(0, 0, ScreenWidth, 10))
        headerView.backgroundColor = UIColor.RGB(0xf0f0f0)
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 10
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell : IndexTitleBarCell = tableView.dequeueReusableCellWithIdentifier("titleCell") as! IndexTitleBarCell
            
            if self.titleBarModelArray.count > 0 {
                
                cell.createIcons(self.titleBarModelArray)
                
            }
            return cell
            
        }else if indexPath.section == 1 {
            
            let cell : IndexActivityCell = tableView.dequeueReusableCellWithIdentifier("ActivityCell") as! IndexActivityCell
            
            if self.promoModelArray.count > 0 {
                
                cell.model(self.promoModelArray)
                
            }
            return cell
            
        }else if indexPath.section == 2 {
            
            let cell : IndexTravelCell = tableView.dequeueReusableCellWithIdentifier("travelCell") as! IndexTravelCell
            
            if self.travelModelArray.count > 0 {
                
                cell.createSlideView(self.travelModelArray)
                
            }
            
            return cell
            
        }else if indexPath.section == 3 {
            
            if self.promoModelArray.count > 4 {
                
                let cell : IndexFiveOperateCell = tableView.dequeueReusableCellWithIdentifier("fiveOperateCell") as! IndexFiveOperateCell
                
                let model : IndexPromoModel = self.promoModelArray[4] as! IndexPromoModel
                
                cell.model(model)
                
                return cell
                
            }else{
                
                if indexPath.row == 0 {
                    
                    let cell : IndexLabelCell = tableView.dequeueReusableCellWithIdentifier("labelCell") as! IndexLabelCell
                    
                    cell.showLabelText("当季热门")
                    
                    return cell
                    
                }else {
                    
                    let cell : IndexHotCell = tableView.dequeueReusableCellWithIdentifier("hotCell") as! IndexHotCell
                    
                    let model : IndexHotModel = self.hotModelArray[indexPath.row - 1] as! IndexHotModel
                    
                    cell.model(model)
                    
                    return cell
                    
                }
                
                
            }
            
        }else if indexPath.section == 4 {
            
            if self.promoModelArray.count > 4 {
                
                if indexPath.row == 0 {
                    
                    let cell : IndexLabelCell = tableView.dequeueReusableCellWithIdentifier("labelCell") as! IndexLabelCell
                    
                    cell.showLabelText("当季热门")
                    
                    return cell
                    
                }else {
                    
                    let cell : IndexHotCell = tableView.dequeueReusableCellWithIdentifier("hotCell") as! IndexHotCell
                    
                    let model : IndexHotModel = self.hotModelArray[indexPath.row - 1] as! IndexHotModel
                    
                    cell.model(model)
                    
                    return cell
                    
                }
                
                
            }else{
                
                
                if indexPath.row == 0 {
                    
                    let cell : IndexLabelCell = tableView.dequeueReusableCellWithIdentifier("labelCell") as! IndexLabelCell
                    
                    cell.showLabelText("猜你喜欢")
                    
                    return cell
                    
                }else {
                    
                    let cell : IndexLikeCell = tableView.dequeueReusableCellWithIdentifier("likeCell") as! IndexLikeCell
                    
                    let model : IndexLikeModel = self.likeModelArray[indexPath.row - 1] as! IndexLikeModel
                    
                    cell.model(model)
                    
                    return cell
                    
                }
                
            }
            
            
        }else{
            
            if indexPath.row == 0 {
                
                let cell : IndexLabelCell = tableView.dequeueReusableCellWithIdentifier("labelCell") as! IndexLabelCell
                
                cell.showLabelText("猜你喜欢")
                
                return cell
                
            }else {
                
                let cell : IndexLikeCell = tableView.dequeueReusableCellWithIdentifier("likeCell") as! IndexLikeCell
                
                let model : IndexLikeModel = self.likeModelArray[indexPath.row - 1] as! IndexLikeModel
                
                cell.model(model)
                
                return cell
                
            }
        }
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return self.promoModelArray.count > 4 ? 6 : 5
    }

    // MARK: - SDCycleScrollViewDelegate
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        
        let model = self.bannerArray[index] as! IndexBannerModel
        
        if tableBlock != nil {
            
            tableBlock!(code: 1,bannerURL: model.url!)
        }
        
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.y

        if offset <= 0 || offset == 64 {

            rootVC.navigationController?.navigationBarHidden = offset < 0

            if offset >= 0 && offset != 64 {

                rootVC.titleViewimageView.alpha = 0

                rootVC.titleButton.backgroundColor = UIColor.blackColor() .colorWithAlphaComponent(0.3)
            }

        }else{

            rootVC.navigationController?.navigationBarHidden = false

            let alpha = 1-((64-offset)/64)

            rootVC.titleViewimageView.alpha = alpha
            rootVC.titleButton.backgroundColor = UIColor.RGB(0x32b267) .colorWithAlphaComponent(alpha)
        }
    }

    
}

