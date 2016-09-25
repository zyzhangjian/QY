//
//  UIView-Frame.swift
//  textswif
//
//  Created by 张健 on 15/6/25.
//  Copyright (c) 2015年 张健. All rights reserved.
//

import UIKit
import Foundation

// MARK: - UIView
extension UIView  {
   
    func x()->CGFloat
    {
        return self.frame.origin.x
    }
    func right()-> CGFloat
    {
        return self.frame.origin.x + self.frame.size.width
    }
    func y()->CGFloat
    {
        return self.frame.origin.y
    }
    func bottom()->CGFloat
    {
        return self.frame.origin.y + self.frame.size.height
    }
    func width()->CGFloat
    {
        return self.frame.size.width
    }
    func height()-> CGFloat
    {
        return self.frame.size.height
    }
    
    func setX(x: CGFloat)
    {
        var rect:CGRect = self.frame
        rect.origin.x = x
        self.frame = rect
    }
    
    func setSize(size : CGSize) -> Void {
        
        let size = self.frame.size
        self.frame.size = size
    }
    
    func setRight(right: CGFloat)
    {
        var rect:CGRect = self.frame
        rect.origin.x = right - rect.size.width
        self.frame = rect
    }
    
    func setY(y: CGFloat)
    {
        var rect:CGRect = self.frame
        rect.origin.y = y
        self.frame = rect
    }
    
    func setBottom(bottom: CGFloat)
    {
        var rect:CGRect = self.frame
        rect.origin.y = bottom - rect.size.height
        self.frame = rect
    }
    
    func setWidth(width: CGFloat)
    {
        var rect:CGRect = self.frame
        rect.size.width = width
        self.frame = rect
    }
    
    func setHeight(height: CGFloat)
    {
        var rect:CGRect = self.frame
        rect.size.height = height
        self.frame = rect
    }
    
    
}

// MARK: - String
extension String {
    
   static func zjSizeWithString(str : String,font : UIFont, sizeWidth : CGFloat, sizeHeight : CGFloat) -> CGFloat {

        let attributes = [NSFontAttributeName: font]
        let option = NSStringDrawingOptions.UsesLineFragmentOrigin
        let rect:CGRect = str.boundingRectWithSize(CGSizeMake(sizeWidth, 8000), options: option, attributes: attributes, context: nil)
        return sizeWidth == 0 ? rect.size.width : rect.size.height
    }
    
        
    func getMd5() -> String {
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = CUnsignedInt(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.dealloc(digestLen)
        
        return String(hash)
    }
    

     func zjMD5(dic : NSDictionary) -> String{
        
        var zjStr : String = ""
        
        let keys : NSArray = dic.allKeys
        let sortedArray : NSArray = keys.sortedArrayUsingComparator { (obj1 : AnyObject,obj2 : AnyObject) -> NSComparisonResult in
            return  obj1.compare(obj2 as! String, options: NSStringCompareOptions.NumericSearch)
        }

        let array : NSArray = sortedArray
        
        for value in array {
            
            var values : String?
            
            if ((dic.objectForKey(value)?.isKindOfClass(NSDictionary)) != nil) {
                
                let str = dic.objectForKey(value) as! String
                
                values = str
            }
            
            zjStr += values!
            
        }

        zjStr = zjStr.getMd5()
        return zjStr
}


}
// MARK: - UIImageView
extension UIImageView {
    
     func roundImageView() ->UIImageView{
        self.layer.cornerRadius = CGRectGetHeight(self.bounds)/2
        self.layer.masksToBounds = true
        return self
    }
}

extension UIButton {

    class func zjBarButtonItem(title : String,imageName : String,block:()->Void) -> UIButton {
        
        let button = UIButton.init(type: UIButtonType.Custom)
        button.adjustsImageWhenDisabled = false
        button.titleLabel?.font = UIFont.systemFontOfSize(14)
        button.setTitle(title, forState: UIControlState.Normal)
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0,0)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0)
        button.sizeToFit()
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        button.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        button.bk_whenTapped { 
            
            block()
        }
        button.frame.size = CGSizeMake(String.zjSizeWithString(title, font: UIFont.systemFontOfSize(14) , sizeWidth: 0, sizeHeight: 21) + ((button.imageView?.image?.size.width)!), 21)
        
        return button
    }
    
}

// MARK: - UIImage
extension UIImage  {
    
    //根据颜色生成图片
    class func imageWithColor(color : UIColor , size : CGSize) ->UIImage {
        
        let rect : CGRect = CGRectMake(0, 0, size.width, size.height)
        
        UIGraphicsBeginImageContext(rect.size)
        
        let context : CGContextRef = UIGraphicsGetCurrentContext()!
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        
        CGContextFillRect(context, rect)
        
        let img : UIImage =  UIGraphicsGetImageFromCurrentImageContext ()
        
        UIGraphicsEndImageContext ();
        
        return img
        
    }
    
    func zjResizeToSize(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        self.drawInRect(CGRectMake(0, 0, size.width, size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    //根据颜色生成图片
    class func createImageWithColor(color : UIColor) -> UIImage {
        
        let rect = CGRectMake(0, 0, 1, 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context,color.CGColor)
        CGContextFillRect(context, rect);
        let theImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return theImage
    }
    
     func original() ->UIImage {

        return self.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
    }

    class func imageWithURL(url : String,imgView : UIImageView) -> UIImage {
        
        imgView.contentMode = UIViewContentMode.ScaleAspectFit
        
        let request = NSURLRequest(URL: NSURL(string: url)!)
        
        let thumbQueue = NSOperationQueue()
        
        var image : UIImage?
        
        NSURLConnection.sendAsynchronousRequest(request, queue: thumbQueue, completionHandler: { response, data, error in
            
            if (error != nil) {
                
                print(error)
                
            } else {
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                    
                    image = UIImage(data: data!)
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        return image
                    })
                })
                
            }
        })

        return image!
    }
}

// MARK: - UIColor
extension UIColor {
    
   class func RGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}

// MARK: - UIViewController
extension UIViewController{
    

    func AppRootViewController() -> UIViewController? {
        var topVC = UIApplication.sharedApplication().keyWindow?.rootViewController
        while topVC?.presentedViewController != nil {
            topVC = topVC?.presentedViewController
        }
        return topVC
    }

//
//
//
//    /**
//    隐藏NavBar
//    */
//    func hideNavBar(){
//        
//        if (self.navigationController?.navigationBar .respondsToSelector(#selector(UINavigationBar.setBackgroundImage(_:forBarMetrics:))) != nil){
//            
//            let list : NSArray = self.navigationController!.navigationBar.subviews
//            
//            for obj  in list {
//                
//                if obj.isKindOfClass(UIImageView){
//                    
//                    let  imageView : UIImageView  = obj as! UIImageView
//                    
//                    UIView.animateWithDuration(0.2, animations: { () -> Void in
//                        
//                        imageView.alpha = 0.0
//                        
//                        }, completion: { (ab) -> Void in
//                            
//                            imageView.hidden = true
//                            
//                            imageView.removeFromSuperview()
//                            
//                    })
//                }
//            }
//            
//            let imageView : UIImageView = UIImageView(frame: CGRectMake(0, -20, self.view.frame.size.width, 64))
//            
//            imageView.image = UIImage.imageWithColor(UIColor .clearColor(), size: CGSizeMake(self.view.frame.size.width, 64))
//            
//            self.navigationController?.navigationBar .addSubview(imageView)
//            
//            self.navigationController?.navigationBar .sendSubviewToBack(imageView)
//        }
//    }
//    
//    /**
//     隐藏NavBar
//     */
//    func showNavBar(){
//        
//        if (self.navigationController?.navigationBar .respondsToSelector(#selector(UINavigationBar.setBackgroundImage(_:forBarMetrics:))) != nil){
//            
//            let list : NSArray = self.navigationController!.navigationBar.subviews
//            
//            for obj  in list {
//                
//                if obj.isKindOfClass(UIImageView){
//                    
//                    let  imageView : UIImageView  = obj as! UIImageView
//                    
//                    UIView.animateWithDuration(0.2, animations: { () -> Void in
//                        
//                        imageView.alpha = 1
//                        
//                        }, completion: { (ab) -> Void in
//                            
//                            imageView.hidden = false
//                    })
//                }
//            }
//
//        }
//    }
//    
//    
    
        //显示NavBar
        func showNavBar() -> Void {
            
            self.navigationController?.navigationBar.shadowImage = UIImage.createImageWithColor(UIColor.clearColor())
            self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(named: "LastMinute_TitleBar_621")
                , forBarMetrics: UIBarMetrics.Default)
            self.navigationController?.navigationBar.translucent = false;
            
        }
        
        //隐藏NavBar
        func hiddenNavBar() -> Void {
            
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.translucent = true;
            
        }
}

// MARK: - 自定义POP事件
extension UINavigationController  {
    
    class func zjPopViewControllerAnimated(nav : UINavigationController) {
        
        UIView.beginAnimations(nil, context:nil)
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
        UIView.setAnimationDuration(0.75)
        UIView.setAnimationTransition(UIViewAnimationTransition.None, forView: nav.view, cache: false)
        UIView.commitAnimations()
        
        UIView.beginAnimations(nil, context:nil)
        UIView.setAnimationDuration(0.375)
        nav.popViewControllerAnimated(false)
        UIView.commitAnimations()
        nav.popViewControllerAnimated(true)

    }
}

// MARK: - UIButton
extension UIButton {
    
    /**
    自定义返回Nav按钮
    
    - returns: 自定义按钮
    */
    class func buttonWithBackItem() -> UIButton {
        
        let btn : UIButton = UIButton(frame: CGRectMake(0, 0, 48, 20))
        
        btn.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        
        btn.setTitle("返回", forState: UIControlState.Normal)
        
        return btn
    }
    
    //主页搜索栏
    class func createTitleButtonView(imageName : String,title : String,withClickBlock:()->Void) -> UIButton {

        let button = UIButton.init(type: UIButtonType.Custom)
        button.adjustsImageWhenHighlighted = false
        button.titleLabel?.font = UIFont.systemFontOfSize(14)
        button.setImage(UIImage.init(named: imageName), forState: UIControlState.Normal)
        button.setTitle(title, forState: UIControlState.Normal)
        button.backgroundColor = UIColor.RGB(0x32b267)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0,0)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0)
        button.sizeToFit()
        button.bk_whenTapped { 
            
            withClickBlock()
        }
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center;
        button.frame.size = CGSizeMake(ScreenWidth - 60, 30)
        
        return button
        
    }
    
    class func createDestinationTitleButtonView(imageName : String,title : String,frame : CGRect , withClickBlock:()->Void) -> UIButton {
        
        let button = UIButton.init(type: UIButtonType.Custom)
        button.frame = frame
        button.setTitleColor(UIColor.RGB(0xbec2c6), forState: UIControlState.Normal)
        button.adjustsImageWhenHighlighted = false
        button.titleLabel?.font = UIFont.systemFontOfSize(14)
        button.setImage(UIImage.init(named: imageName), forState: UIControlState.Normal)
        button.setTitle(title, forState: UIControlState.Normal)
        button.backgroundColor = UIColor.RGB(0xe7f6f4)
        button.layer.cornerRadius = 15
        button.alpha = 0.9
        button.layer.masksToBounds = true
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0,0)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0)
        button.bk_whenTapped {
            
            withClickBlock()
        }
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center;
        
        return button
        
    }
}

struct Date {
   
    var timeInterval:NSTimeInterval = 0
    
    init() { self.timeInterval = NSDate().timeIntervalSince1970 }
}

extension String{
    
   static func getSeqNo() -> String{
        
        return  String(arc4random()%89999999+10000000)
    }
    

    
   static func getWeekName(englishName : String) -> String{

        switch englishName{
            
        case "Monday"   :return "星期一"
        case "Tuesday"  :return "星期二"
        case "Wednesday":return "星期三"
        case "Thursday" :return "星期四"
        case "Friday"   :return "星期五"
        case "Saturday" :return "星期六"
        case "Sunday"   :return "星期日"
        default:return""
            
        }
        
    }
    
    /**
    获取唯一标示UUID
    
    - returns: 返回UUID
    */
   static func getUUID() -> String{
    
        let uuid : NSUUID = UIDevice.currentDevice().identifierForVendor!
    
        let array : NSArray = "\(uuid)".componentsSeparatedByString(">")
        
        let arrayNext : NSArray = array[1].componentsSeparatedByString("-")

        let lastArray : NSArray = "\((arrayNext[0] as! String)+(arrayNext[1] as! String)+(arrayNext[2] as! String)+(arrayNext[3] as! String)+(arrayNext[4] as! String))".componentsSeparatedByString(" ")
        
        return "\((lastArray[0] as! String)+(lastArray[1] as! String))"
    
    }

     
    /**
    获取当前时间戳
    
    - returns: 返回当前时间戳
    */
   static func getDate() -> String{
        
         let date:NSDate = NSDate()
    
        let array : NSArray =   "\(date.timeIntervalSince1970)".componentsSeparatedByString(".")
    
        return "\(array.objectAtIndex(0))"
    }
    
    /**
    计算字符串高度
    
    - parameter text:    计算文字
    - parameter theFont: 文字大小
    - parameter width:   文字宽度
    
    - returns: 文字高度
    */
    static func contentStringFrame(label : UILabel,text : String,theFont : CGFloat,width : CGFloat , height : CGFloat) -> CGFloat{
        
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping

        label.font = UIFont.systemFontOfSize(theFont)
        
        label.numberOfLines = 0

        let options : NSStringDrawingOptions = [.UsesLineFragmentOrigin, .UsesFontLeading]
        
        let boundingRect : CGRect = text.boundingRectWithSize(CGSizeMake(CGFloat(width), 0), options: options, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(theFont)], context: nil)
        
        return width == 0 ? boundingRect.width : boundingRect.height
    }
}



// MARK: - 计算
extension Date {
    mutating func addDay(day:Int) {
        timeInterval += Double(day) * 24 * 3600
    }
    
    mutating func reduceDay(day:Int) {
        timeInterval -= Double(day) * 24 * 3600
    }
    
    mutating func addHour(hour:Int) {
        timeInterval += Double(hour) * 3600
    }
    mutating func addMinute(minute:Int) {
        timeInterval += Double(minute) * 60
    }
    mutating func addSecond(second:Int) {
        timeInterval += Double(second)
    }
    mutating func addMonth(month m:Int) {
        let (year, month, day) = getDay()
        let (hour, minute, second) = getTime()
        let era = year / 100
        if #available(iOS 8.0, *) {
            if let date = NSCalendar.currentCalendar().dateWithEra(era, year: year, month: month + m, day: day, hour: hour, minute: minute, second: second, nanosecond: 0) {
                timeInterval = date.timeIntervalSince1970
            } else {
                timeInterval += Double(m) * 30 * 24 * 3600
            }
        } else {
            // Fallback on earlier versions
        }
    }
    mutating func addYear(year y:Int) {
        let (year, month, day) = getDay()
        let (hour, minute, second) = getTime()
        let era = year / 100
        if #available(iOS 8.0, *) {
            if let date = NSCalendar.currentCalendar().dateWithEra(era, year: year + y, month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: 0) {
                timeInterval = date.timeIntervalSince1970
            } else {
                timeInterval += Double(y) * 365 * 24 * 3600
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    // for example : let (year, month, day) = date.getDay()
    func getDay() -> (year:Int, month:Int, day:Int) {
        var year:Int = 0, month:Int = 0, day:Int = 0
        let date = NSDate(timeIntervalSince1970: timeInterval)
        if #available(iOS 8.0, *) {
            NSCalendar.currentCalendar().getEra(nil, year: &year, month: &month, day: &day, fromDate: date)
        } else {
            // Fallback on earlier versions
        }
        return (year, month, day)
    }
    
    // for example : let (hour, minute, second) = date.getTime()
    func getTime() -> (hour:Int, minute:Int, second:Int) {
        var hour:Int = 0, minute:Int = 0, second:Int = 0
        let date = NSDate(timeIntervalSince1970: timeInterval)
        if #available(iOS 8.0, *) {
            NSCalendar.currentCalendar().getHour(&hour, minute: &minute, second: &second, nanosecond: nil, fromDate: date)
        } else {
            // Fallback on earlier versions
        }
        return (hour, minute, second)
    }
}

// MARK: - NSObject
extension NSObject
{
    
    
    func performSelectorOnMainThread(selector aSelector: Selector,withObject object:AnyObject! ,waitUntilDone wait:Bool)
    {
        if self.respondsToSelector(aSelector)
        {
            var continuego = false
            let group = dispatch_group_create()
            let queue = dispatch_queue_create("com.fsh.dispatch", nil)
            dispatch_group_async(group,queue,{
                dispatch_async(queue ,{
                    //做了个假的
                    NSThread.detachNewThreadSelector(aSelector, toTarget:self, withObject: object)
                    continuego = true
                })
            })
            dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
            
            if wait
            {
                let ret = NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate.distantFuture() )
                while (!continuego && ret)
                {
                    
                }
            }
        }
    }
    
}


