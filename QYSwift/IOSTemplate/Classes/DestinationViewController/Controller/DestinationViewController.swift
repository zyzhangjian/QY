//
//  DestinationViewController.swift
//  QYSwift
//
//  Created by 张健 on 16/9/19.
//  Copyright © 2016年 张健. All rights reserved.
//

import UIKit

let topImageheight : CGFloat = 162.0

class DestinationViewController: BaseViewController {

    var tableView : DestinationTableVie!
    
    var desCollection : DestinaCollectionView!
    
    var tableDataArray = NSMutableArray()
    
    // MARK: - VC Life
    override func viewDidLoad() {
        super.viewDidLoad()

        self.createTopSearchView()
        
        self.createLeftTableView()
        
        self.createList()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.hiddenNavBar()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.showNavBar()
        
    }
    
    // MARK: - CreateTopSearchView
    func createTopSearchView() -> Void {
        
        let topImageView = UIImageView.init(frame: CGRectMake(0, 0, ScreenWidth, topImageheight))
        topImageView.image = UIImage(named: "destinationBanner")
        topImageView.userInteractionEnabled = true
        view.addSubview(topImageView)
        
        let searchLabel = UILabel.init(frame: CGRectMake(0, 65, ScreenWidth, 21))
        searchLabel.text = "选择目的地"
        searchLabel.textColor = UIColor.whiteColor()
        searchLabel.font = UIFont.boldSystemFontOfSize(21)
        searchLabel.textAlignment = NSTextAlignment.Center
        topImageView.addSubview(searchLabel)
        
      let  titleButton = UIButton.createDestinationTitleButtonView("Custom_Search_15x15_", title: "搜索国家/城市",frame: CGRectMake(23, searchLabel.bottom() + 25, ScreenWidth - 46, 30), withClickBlock: {
            
            YYNSLog("搜索国家/城市")
        })
        topImageView.addSubview(titleButton)

    }
    
    // MARK: - CreateLeftTableView
    func createLeftTableView() -> Void {
        
        tableView = DestinationTableVie.init(frame: CGRectMake(0, topImageheight, 80, ScreenHeight - topImageheight - 30), style: UITableViewStyle.Plain, VC: self ,block: { (model) in

            self.desCollection.dataArray = model.destinationsArray
            self.desCollection.reloadData()
        })
        
        let  flowLayout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        flowLayout.itemSize = CGSizeMake((ScreenWidth - tableView.right() - 45) / 2,65)
        flowLayout.sectionInset = UIEdgeInsetsMake(15,15,15,  15)

        
        desCollection = DestinaCollectionView.init(frame: CGRectMake(tableView.right() , topImageheight, ScreenWidth - tableView.right(), tableView.height()), collectionViewLayout: flowLayout, VC: self) { (model) in
            
            
            YYNSLog("\(model)")

        }
    }
    
    // MARK: - CreateList
    func createList() -> Void {
        
        HUD.instance.showGIFImage(self.view)
        
        ZJHttpRequest.sharedInstance.Request("GET", url: zjDestination, parameters: [:], finished: { (result) in
            
            HUD.instance.hiddenHUD()
            
            let dataArray : NSArray = result.objectForKey("data") as! NSArray
            
            if dataArray.count > 1 {

                for index in 0 ..< dataArray.count {
                    
                    let dic : NSDictionary = dataArray[index] as! NSDictionary
                    
                    let model =  DestinationModel()
                    
                    model.name = dic.valueForKey("name")! as? String
                    
                    let desArray = dic.objectForKey("destinations") as! NSArray
  
                    for i in 0 ..< desArray.count {
                        
                        let desDic : NSDictionary = desArray[i] as! NSDictionary

                        let desModel =  DestinationDetailModel()
                        desModel.name       = desDic.valueForKey("name")! as? String
                        desModel.city_id    = desDic.valueForKey("city_id") as? String  == nil ? "" : desDic.valueForKey("city_id") as? String
                        desModel.country_id = desDic.valueForKey("country_id") as? String == nil ? "" : desDic.valueForKey("country_id") as? String
                        desModel.pic        = desDic.valueForKey("pic")! as? String
                        desModel.name_en    = desDic.valueForKey("name_en")! as? String
                        model.destinationsArray.addObject(desModel)
                    }
                    
                    self.tableDataArray.addObject(model)
                }
                
                //刷新左侧列表
                self.tableView.dataArray = self.tableDataArray
                self.tableView.reloadData()
                
                //刷新右侧列表
                self.desCollection.dataArray = ((self.tableDataArray[0]) as! DestinationModel).destinationsArray
                self.desCollection.reloadData()
            }
            
            }, fali: {
                
                HUD.instance.hiddenHUD()
                YYNSLog("目的地请求失败")
        }) {
            
            HUD.instance.hiddenHUD()
            YYNSLog("没网")
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
