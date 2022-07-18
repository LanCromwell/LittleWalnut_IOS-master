//
//  UIFont+Extension.swift
//  SwiftProject
//
//  Created by YX on 2019/7/26.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit
// 字体宽度枚举
enum fontWeight {
    case thin
    case regular
    case medium
    case semibold
    case bold
    
    @available(iOS 8.2, *)
    func systemWeight() -> UIFont.Weight {
        switch self {
        case .thin:
            return UIFont.Weight.thin
        case .regular:
            return UIFont.Weight.regular
        case .medium:
            return UIFont.Weight.medium
        case .semibold:
            return UIFont.Weight.semibold
        case .bold:
            return UIFont.Weight.bold
        }
    }
}

// UIFont + Extension
extension UIFont {
    /// 系统字体，默认字号16，Weight为regular
    class func font(size: CGFloat = 16, weight: fontWeight = .regular) -> UIFont! {
        if #available(iOS 8.2, *) {
            return UIFont.systemFont(ofSize: size * kWIDTHBASE, weight: weight.systemWeight())
        } else {
            return UIFont.systemFont(ofSize: size * kWIDTHBASE)
        }
    }
}
