//
//  UIColor+Extension.swift
//  PromeSwift
//
//  Created by liyan on 2017/5/31.
//  Copyright © 2017年 liyan. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    /*
     *  支持十六进制数值
     *  prama  hexValue  例如 0xDDAA88
     */
    
    class func hexInt(_ hexValue: Int) -> UIColor {
        return UIColor(red: ((CGFloat)((hexValue & 0xFF0000) >> 16)) / 255.0,
                       
                       green: ((CGFloat)((hexValue & 0xFF00) >> 8)) / 255.0,
                       
                       blue: ((CGFloat)(hexValue & 0xFF)) / 255.0,
                       
                       alpha: 1.0)
    }
    
    
    /*
     *  支持十六进制数值
     *  prama  hexValue  例如 0xDDAA88
     *  prama  alpha     例如 0.0 ~ 1.0参数
     */
    class func hexInt(_ hexValue: Int, _ alpha: CGFloat) -> UIColor {
        return UIColor(red: ((CGFloat)((hexValue & 0xFF0000) >> 16)) / 255.0,
                       
                       green: ((CGFloat)((hexValue & 0xFF00) >> 8)) / 255.0,
                       
                       blue: ((CGFloat)(hexValue & 0xFF)) / 255.0,
                       
                       alpha: alpha)
    }
    

    /*
     *  支持十六进制字符串
     *  prama  hexString  例如 "0xDDAA88" "#DDAA88" 或者 “DDAA88”
     */
    
    class func hexString(hexString: String) -> UIColor{
       
        var cString: String = String(hexString.filter{$0 != " "})
        
        if cString.count < 6 {return UIColor.black}
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.hasPrefix("0x") || cString.hasPrefix("0X") {
            cString.removeSubrange((cString.startIndex ..< cString.index(cString.startIndex, offsetBy: 2)))
        }
        //过期API 
        if cString.count != 6 {return UIColor.black}
        
        var range: NSRange = NSMakeRange(0, 2)
        
        let rString = (cString as NSString).substring(with: range)
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        
        var r: UInt32 = 0x0
        var g: UInt32 = 0x0
        var b: UInt32 = 0x0
        Scanner.init(string: rString).scanHexInt32(&r)
        Scanner.init(string: gString).scanHexInt32(&g)
        Scanner.init(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(1))
        
    }
    
    /*
     *  随机色
     */
    
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
    
    
}


extension UIColor {
    /*
     *   传入 0 - 255 之间的值
     */
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255.0 ,green: g/255.0 ,blue: b/255.0 ,alpha:1.0)
    }
    /// 纯色（用于灰色）
    convenience init(gray: CGFloat) {
        self.init(red: gray/255.0 ,green: gray/255.0 ,blue: gray/255.0 ,alpha:1.0)
    }
    

}



