//
//  UIStoryboard+Extension.swift
//  PromeSwift
//
//  Created by liyan on 2017/6/10.
//  Copyright © 2017年 liyan. All rights reserved.
//  

import Foundation
import UIKit

extension UIStoryboard {
    
    
    /**
     根据stroyboard名称返回初始控制器
     
     - parameter identifier: 试图控制器ID
     
     - returns: 初始控制器
     */
 
    class func vcInMainSB(_ identifier: String, sbName: String = "Main") -> UIViewController {
        
        let sb = UIStoryboard(name: sbName, bundle: nil)
        
        return sb.instantiateViewController(withIdentifier: identifier)
    }
    
    
    
    
    

    
    
    
}
