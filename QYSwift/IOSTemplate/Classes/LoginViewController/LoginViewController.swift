//
//  LoginViewController.swift
//  QYSwift
//
//  Created by 张健 on 16/9/25.
//  Copyright © 2016年 张健. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    // MARK: - VC Life
    override func viewDidLoad() {
        super.viewDidLoad()

        self.createUI()
        
    }
    
    func createUI() -> Void {
        
        let rootImageView = UIImageView.init(frame: self.view.bounds)
        rootImageView.image = UIImage(named: "Category_City_Enjoy_Button_Highlight_20x38_")
        view.addSubview(rootImageView)
        
        let dismissImageView  = UIImageView.init(frame: CGRectMake(15, 35, 30, 30))
        dismissImageView.image = UIImage(named: "My_Order_detail_30x30_")
        dismissImageView.userInteractionEnabled = true
        dismissImageView.bk_whenTapped {
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        view.addSubview(dismissImageView)
        
        
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
