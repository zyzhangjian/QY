//
//  ViewController.swift
//  QYSwift
//
//  Created by 张健 on 16/8/30.
//  Copyright © 2016年 张健. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    
    var titleButton         : UIButton!
    var titleViewimageView  : UIImageView!
    var bannerView          : SDCycleScrollView!
    var bannerModel         : IndexBannerModel!
    var tableView           : IndexTableView!
    var mjFooterView        : QYFooter!
    var bannerArray         = NSMutableArray()
    var bannerImageArray    = NSMutableArray()
    var titleBarModelArray  = NSMutableArray()
    var promoModelArray     = NSMutableArray()
    var travelModelArray    = NSMutableArray()
    var hotModelArray       = NSMutableArray()
    var likeModelArray      = NSMutableArray()
    var eliteModelArray     = NSMutableArray()
    var page                = 1                              //当前页数
    var hotSearchArray      = NSArray()                      //热门搜索数组
    var hotSearchVC         = HotSearchViewController()
    
    // MARK: - VC Life
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.createTitleView()

        self.createTableView()
        
        self.createList()
        
        self.createHotSearch()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.hiddenNavBar()
        
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.showNavBar()
    }

    func createHotSearch() -> Void {
        
        ZJHttpRequest.sharedInstance.Request("GET", url: zjIndexHotSearch , parameters: [:], finished: { (result) in
            
            if result.objectForKey("status")?.intValue == 1 {
                
                self.hotSearchArray = result.objectForKey("data") as! NSArray
            
            }

            }, fali: {
                
                HUD.instance.hiddenHUD()
                
                self.mjFooterView.endRefreshing()
        }) {
            
            HUD.instance.hiddenHUD()
            
            self.mjFooterView.endRefreshing()
            
        }

    }
    
    // MARK: - CreateTableView
    func createTableView() -> Void {
        
        tableView = IndexTableView.init(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight + 20), style: UITableViewStyle.Grouped, VC: self, block: { (code,bannerURL : String) in
            
            if code == 1 {   //banner
                
                YYNSLog("点击Banner")
            }
            
        })

        //添加刷新控件
        tableView.addRefreshWithBlock {
            
             self.createList()
        }
        
        //添加动画加载更多控件
        mjFooterView =  QYFooter.init(refreshingTarget: self, refreshingAction: #selector(ViewController.loadMore))
        mjFooterView.automaticallyHidden = true
        tableView.tableFooterView = mjFooterView
        
        //添加普通加载更多控件
//        mjFooterView =  MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(ViewController.loadMore))
//        mjFooterView.automaticallyHidden = true
//        tableView.tableFooterView = mjFooterView
        self.view.addSubview(tableView)
    }
    
    func loadMore() -> Void {
        
        page += 1
        
        self.createBottomList()
       
    }
    
    // MARK: - CreateTitleView
    func createTitleView() -> Void {

        titleButton = UIButton.createTitleButtonView("White_Search_15x15_", title: "搜索 目的地/折扣/关键字", withClickBlock: {
            
            //状态栏黑色文字
            UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.Default, animated: true)
            
            if self.hotSearchArray.count <= 0 {return}
            self.hotSearchVC.hotSearchArray = self.hotSearchArray
            
            //解决延迟强制在主线程执行
            GCDQueue.mainQueue().execute({
                
                self.presentViewController(self.hotSearchVC, animated: true, completion: nil)
            })

            
        })

        titleViewimageView = UIImageView.init(frame: CGRectMake(0, -20, ScreenWidth, 64))
        titleViewimageView.image = UIImage(named: "LastMinute_TitleBar_621")
        self.navigationController?.navigationBar.insertSubview(titleViewimageView, atIndex: 0)
        
        self.navigationItem.titleView = titleButton
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "Recommand_Code_Scan_30x30_")?.original(), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ViewController.leftBarScan))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "Message_None_30x30_")?.original(), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ViewController.rightBarMessage))

    }
    
    func leftBarScan() -> Void {
        
        YYNSLog("扫码")
    }
    
    func rightBarMessage() -> Void {
        
        YYNSLog("消息")
    }

    
    // MARK: - CreateList
    func createList() -> Void {
        
        HUD.instance.showGIFImage(self.view)

        ZJHttpRequest.sharedInstance.Request("GET", url: zjIndex, parameters: [:], finished: { (result) in
            
            HUD.instance.hiddenHUD()
            
            self.page = 1
            
            self.createBottomList()
            
            self.tableView.endRefreshingFail()
            
            let data = result.objectForKey("data")
 
            if result["status"]?.intValue == 1 {
                
                self.tableView.hidden = false
                
                //banner
                let head_slide  = data!.objectForKey("head_slide")
                
                let slide_dataArray = head_slide?.objectForKey("slide_data") as! NSArray
                
                if head_slide?.objectForKey("count")?.intValue > 0 {

                    self.bannerImageArray = NSMutableArray()
                    
                    self.tableView.bannerArray      = IndexBannerModel.mj_objectArrayWithKeyValuesArray(slide_dataArray)
                    
                    for index in 0 ..< slide_dataArray.count {
                       
                        let dic : NSDictionary = slide_dataArray[index] as! NSDictionary
                        self.bannerImageArray.addObject((dic["cover"]! as? String)!)
                        
                    }
                    
                    self.tableView.bannerView.imageURLStringsGroup = self.bannerImageArray as [AnyObject]
                }
                
                
                //titleBar
                let titleBarArray = (data?.objectForKey("bar"))! as! NSArray
                
                self.tableView.titleBarModelArray = IndexTitleBarModel.mj_objectArrayWithKeyValuesArray(titleBarArray)


                //惠玩、天天特价
                let promoArray = (data?.objectForKey("promo"))! as! NSArray

                self.tableView.promoModelArray = IndexPromoModel.mj_objectArrayWithKeyValuesArray(promoArray)
                

                
                //出行必备
                let gearsArray = (data?.objectForKey("gears"))! as! NSArray
                
                self.tableView.travelModelArray = IndexTravelModel.mj_objectArrayWithKeyValuesArray(gearsArray)
                
                
                //当季热门
                self.hotModelArray = NSMutableArray()
                
                let hotArray = (data?.objectForKey("hot_topic"))! as! NSArray

                for index in 0 ..< hotArray.count {
                    
                    let dic : NSDictionary = hotArray[index] as! NSDictionary

                    let hotModel : IndexHotModel = IndexHotModel()
                    hotModel.title = dic.objectForKey("title")! as? String
                    hotModel.url = dic.objectForKey("url")! as? String
                    hotModel.img = dic.objectForKey("img")! as? String
                    
                    if (dic.valueForKey("elite") != nil) {
                        
                        let eliteArray : NSArray = (dic.valueForKey("elite")) as! NSArray
                        
                        for index in 0 ..< eliteArray.count {
                            
                            let dic : NSDictionary = eliteArray[index] as! NSDictionary

                            let model : IndexHotEliteModel = IndexHotEliteModel()
                            model.title = dic.objectForKey("title")! as? String
                            model.pic = dic.objectForKey("pic")! as? String
                            model.price = dic.objectForKey("price")! as? String
                            hotModel.eliteArray.addObject(model)
                        }
                        
                    }
                    
                    self.hotModelArray.addObject(hotModel)
                }
                
                self.tableView.hotModelArray =  self.hotModelArray
        
                self.tableView.reloadData()
                
            }
         
            }, fali: {
                
                HUD.instance.hiddenHUD()
                YYNSLog("主页请求失败")
        }) {
            
            HUD.instance.hiddenHUD()
            YYNSLog("没网")
            
        }

    }
    
    
    func createBottomList() -> Void {
    
        ZJHttpRequest.sharedInstance.Request("GET", url: zjIndexLike + "\(page)", parameters: [:], finished: { (result) in
            
            self.tableView.endRefreshingFail()

            let dataArray = result.objectForKey("data") as! NSArray


            if result["status"]?.intValue == 1 {
    
                self.mjFooterView.state = dataArray.count > 0 ? MJRefreshState.Idle :  MJRefreshState.Refreshing
                
                if dataArray.count > 0 {
                    
                    //猜你喜欢
                    if self.page == 1 {
                        
                        self.tableView.likeModelArray = IndexLikeModel.mj_objectArrayWithKeyValuesArray(dataArray)
                        
                    }else{
                        
                        for index in 0 ..< IndexLikeModel.mj_objectArrayWithKeyValuesArray(dataArray).count {
                            
                            let model : IndexLikeModel = IndexLikeModel.mj_objectArrayWithKeyValuesArray(dataArray)[index] as! IndexLikeModel
                            
                            self.tableView.likeModelArray.addObject(model)
                            
                            
                        }
                        
                    }
                    
                    self.mjFooterView.endRefreshing()
                    
                }else{
                    
                    
                    self.mjFooterView.state = MJRefreshState.NoMoreData
                   
                }

                self.tableView .reloadData()
                
            }
            
            }, fali: {
                
                HUD.instance.hiddenHUD()
                
                self.mjFooterView.endRefreshing()
        }) {
            
            HUD.instance.hiddenHUD()
            
            self.mjFooterView.endRefreshing()
            
        }
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
