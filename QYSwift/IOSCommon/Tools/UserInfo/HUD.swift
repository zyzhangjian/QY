//
//  HUD.swift
//  HHXCSwift
//
//  Created by 张健 on 16/6/22.
//  Copyright © 2016年 张健. All rights reserved.
//

import Foundation
import UIKit

class HUD: NSObject {

    internal static let instance = HUD()
    
    var hud             : MBProgressHUD!
    
    var view            : UIView!
    
    var gifImageView    : UIImageView!
    
    var imageArray      : NSMutableArray!

    private override init(){

        hud = MBProgressHUD()
        
        gifImageView = UIImageView.init(frame: CGRectMake(0, 0, 60, 60))
        
        imageArray = NSMutableArray()
        
        for i in 1..<21 {
            
            let image = UIImage(named:"loading160-\(i)")
            imageArray.addObject(image!)
        }

        
    }
}
extension HUD {
    
    func showHUDForView(view : UIView) -> Void {
  
        self.hiddenHUD()
        self.view = view
        MBProgressHUD.hideAllHUDsForView(view, animated: false)
        self.hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
         
    }
    
    func showGIFImage(view : UIView) -> Void {
        
        self.hiddenHUD()
        self.view = view
        self.hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        self.hud.color = UIColor.clearColor()
        self.hud.mode =  MBProgressHUDMode.CustomView
        
        gifImageView.animationImages = imageArray as? [UIImage]
        gifImageView.animationDuration = 1
        gifImageView.startAnimating()
        self.hud.customView = gifImageView

    }
    
    func showTextHUDForView(str : String,view : UIView) -> Void {
        
        self.hiddenHUD()
        self.view = view
        self.hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        self.hud.mode = MBProgressHUDMode.Text
        self.hud.labelText = str
        self.hud.animationType = MBProgressHUDAnimation.Zoom
        
        self.hud.hide(true, afterDelay: 2)
    }
    
    func hiddenHUD() -> Void {
  
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        
    }
    
}
