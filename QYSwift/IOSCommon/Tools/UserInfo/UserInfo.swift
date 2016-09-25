
//
//  UserInfo.swift
//  QYSwift
//
//  Created by 张健 on 16/9/25.
//  Copyright © 2016年 张健. All rights reserved.
//

import UIKit

class UserInfo: NSObject {

    internal static let instance = UserInfo()
    
    func saveUserInfoWithDict(dic : NSDictionary) -> Void {

        let keys : NSArray = dic.allKeys
        let sortedArray = keys.sortedArrayUsingComparator { (obj1, obj2) -> NSComparisonResult in
            
            return obj1.compare(obj2 as! String, options: NSStringCompareOptions.NumericSearch)
        }
        
        for str in sortedArray {
            
            if ((dic.objectForKey(str)?.isKindOfClass(NSDictionary)) != nil) {
                
                let result = dic.objectForKey(str)
                let keys : NSArray  = (result?.allValues)!
                let values : NSArray = (result?.allKeys)!
                
                for index in 0 ..< keys.count {
                    
                    TMCache.sharedCache().setObject("\(keys[index])".isEmpty == true ? "" : "\(keys[index])", forKey: "\(values[index])")
                }
            
            }else{
            
                TMCache.sharedCache().setObject(dic.objectForKey(str) as! String , forKey: str as! String)
            
            }
        }
    }
    
    func logout() -> Void {
        
        TMCache.sharedCache().removeAllObjects()
        
    }
    
    
    func uid() -> String {

        return (TMCache.sharedCache().objectForKey("uid") == nil ? "" : TMCache.sharedCache().objectForKey("uid")) as! String
    }
}
