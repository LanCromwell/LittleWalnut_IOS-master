//
//  UserDefaults+Extension.swift
//  SwiftDemo
//
//  Created by liyan on 2018/1/8.
//  Copyright © 2018年 liyan. All rights reserved.
//

import UIKit

extension UserDefaults {
    
    
    /// 存储键值对
    ///
    /// - Parameters:
    ///   - key: key
    ///   - value: value
    class func setDefault(key: String, value: Any?) {
        
        if value == nil {
            
            UserDefaults.standard.removeObject(forKey: key)
            
        } else {
            
            UserDefaults.standard.set(value, forKey: key)
            
            UserDefaults.standard.synchronize() //同步
            
        }
    }
    
    
    ///移除键值对
    class func removeUserDefault(key: String?) {
        
        if key != nil {
            
            UserDefaults.standard.removeObject(forKey: key!)
            
            UserDefaults.standard.synchronize()
            
        }
    }
    
    ///获取键值对
    class func getDefault(key: String) -> Any? {
        
        return UserDefaults.standard.value(forKey: key)
    }
    
    
        
}
