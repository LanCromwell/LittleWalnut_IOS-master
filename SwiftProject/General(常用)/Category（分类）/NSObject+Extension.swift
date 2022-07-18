//
//  NSObject+Extension.swift
//  SwiftDemo
//
//  Created by liyan on 2018/4/21.
//  Copyright © 2018年 liyan. All rights reserved.
//

import Foundation
import UIKit


public extension NSObject {
    
    //获取类名
    class var mt_className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last! as String
    }
    
}
