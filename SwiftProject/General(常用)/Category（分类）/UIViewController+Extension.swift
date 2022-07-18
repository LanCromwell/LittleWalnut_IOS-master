//
//  UIViewController+Extension.swift
//  SwiftDemo
//
//  Created by liyan on 2018/1/12.
//  Copyright © 2018年 liyan. All rights reserved.
//

import Foundation
import UIKit


public extension UIViewController {
    
    class func mt_initFromNib() -> UIViewController {
        let hasNib: Bool = Bundle.main.path(forResource: self.mt_className, ofType: "nib") != nil
        guard hasNib else {
            assert(!hasNib, "Invalid parameter")
            return UIViewController()
        }
        return self.init(nibName: self.mt_className, bundle: nil)
    }

    
}
