//
//  UILabel+Extension.swift
//  SwiftDemo
//
//  Created by liyan on 2018/4/28.
//  Copyright © 2018年 liyan. All rights reserved.
//

import UIKit


extension UILabel {
    //字体大小
    var fontSize: CGFloat {
        get {
            return self.font.pointSize
        }
        set {
            font = UIFont.systemFont(ofSize: fontSize)
        }
    }
    
}
