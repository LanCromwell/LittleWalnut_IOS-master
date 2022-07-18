//
//  UIView+Extension.swift
//  PromeSwift
//
//  Created by liyan on 2017/4/24.
//  Copyright © 2017年 liyan. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    
    var mt_layoutGuide: UILayoutGuide {
        if #available(iOS 11, *) {
            return safeAreaLayoutGuide
        } else {
            return layoutMarginsGuide
        }
    }
    
    var mt_layoutInsets: UIEdgeInsets {
        if #available(iOS 11, *) {
            return safeAreaInsets
        } else {
            return layoutMargins
        }
    }
    
    /// 给View加上圆角
    @IBInspectable var setCornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0
        }
    }
    
    
    
    /*
     *  //MARK:-获取view 所在的父视图控制器 （不用每次传入加载试图控制器指针）
     */
    public var ly_viewController: UIViewController? {
        get {
            var responder = self.next
            while responder != nil {
                
                if (responder!.isKind(of: UIViewController.self)) {
                    return (responder as! UIViewController)
                }
                responder = responder!.next
            }
            
            return nil
        }
    }
    
    
    /*
     * //MARK:- 清除所有子View
     */
    public func removeAllSubviews() {
        while self.subviews.count > 0 {
            let child = self.subviews.last
            child?.removeFromSuperview()
        }
    }
    
    
    
    
    /// 从xib加载当前控件
    ///
    /// - Returns: UIView 对象或者子类对象
    class func loadFromNib() -> UIView {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.first as! UIView
    }
    
    
    
    
    @discardableResult
    public func addSubviews(_ subviews: UIView...) -> UIView{
        subviews.forEach(addSubview)
        return self
    }
    
    @discardableResult
    public func addSubviews(_ subviews: [UIView]) -> UIView{
        subviews.forEach (addSubview)
        return self
    }
    
    func addTapGesture() -> UITapGestureRecognizer {
        let tapGesture = UITapGestureRecognizer()
        addGestureRecognizer(tapGesture)
        isUserInteractionEnabled = true
        return tapGesture
    }
    
    func addLongPressGesture() -> UILongPressGestureRecognizer {
        let longPressGesture = UILongPressGestureRecognizer()
        addGestureRecognizer(longPressGesture)
        isUserInteractionEnabled = true
        return longPressGesture
    }
    
    
    
   
}












//MARK:- *********************************坐标计算扩展*********************************
extension UIView {
    /*
     *  //MARK:- x 属性(可读 可写)
     */
    public var ly_x: CGFloat {
        get{
            return self.frame.origin.x
        }
        set{
            var react = self.frame
            react.origin.x = newValue
            self.frame = react
        }
    }
    
    
    /*
     *  //MARK:- y 属性(可读 可写)
     */
    public var ly_y: CGFloat {
        get{
            return self.frame.origin.y
        }
        set{
            var react = self.frame
            react.origin.y = newValue
            self.frame = react
        }
    }
    
    
    /*
     *  //MARK:- width 属性 (可读 可写)
     */
    
    public var ly_width: CGFloat {
        get{
            return self.frame.size.width;
        }
        set{
            var react = self.frame
            react.size.width = newValue
            self.frame = react
        }
    }
    
    /*
     *  //MARK:- Height 属性 (可读 可写)
     */
    
    public var ly_height: CGFloat {
        get{
            return self.frame.size.height
        }
        set{
            var react = self.frame
            react.size.height = newValue
            self.frame = react
        }
    }
    
    
    
    
    /*
     *  //MARK:- origin 属性(可读 可写)
     */
    public var ly_origin: CGPoint {
        get{
            return self.frame.origin
        }
        set{
            self.ly_x = newValue.x
            self.ly_y = newValue.y
        }
    }
    
    /*
     * //MARK:- size 属性(可读 可写)
     */
    public var ly_size: CGSize {
        get{
            return self.frame.size
        }
        set {
            self.ly_width = newValue.width
            self.ly_height = newValue.height
        }
    }
    
    
    
    /*
     * //MARK:- centerX (可读 可写)
     */
    public var ly_centerX: CGFloat {
        get{
            return self.center.x
        }
        set {
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }
    
    
    /*
     *  //MARK:- centerY (可读 可写)
     */
    public var ly_centerY: CGFloat {
        get{
            return self.center.y
        }
        set{
            self.center = CGPoint(x: self.ly_centerX, y: newValue)
        }
    }
    

}




//MARK:- *********************************动画*********************************
extension UIView {
    /// 使用视图的alpha创建一个淡出动画
    public func fadeOut(_ duration: TimeInterval = 0.4, delay: TimeInterval = 0.0, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
    
    /// 使用视图的alpha创建一个淡入动画
    public func fadeIn(_ duration: TimeInterval = 0.4, delay: TimeInterval = 0.0, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }
}





