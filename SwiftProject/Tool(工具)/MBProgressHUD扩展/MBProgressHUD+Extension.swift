//
//  MBProgressHUD+Extension.swift
//  SwiftDemo
//
//  Created by liyan on 2018/9/4.
//  Copyright © 2018年 liyan. All rights reserved.
//

import Foundation
import MBProgressHUD

extension MBProgressHUD {

    //显示等待消息
    class func showWait(_ title: String = "") {
        let view = viewToShow()
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
//        hud.backgroundView.style = .blur  //模糊的遮罩背景
        hud.label.text = title
        hud.removeFromSuperViewOnHide = true
        //HUD窗口显示45秒后自动隐藏  防止出现loading不消失的bug
        hud.hide(animated: true, afterDelay: 45)
    }
    
    //显示普通消息
    class func showInfo(_ title: String) {
        let view = viewToShow()
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .customView //模式设置为自定义视图
        hud.customView = UIImageView(image: UIImage(named: "info")!) //自定义视图显示图片
        hud.label.text = title
        hud.removeFromSuperViewOnHide = true
    }
    
    ///隐藏
    class func hiddenHUD() {
        let view = viewToShow()
        MBProgressHUD.hide(for: view, animated: true)
    }

    
    //显示成功消息
    class func showSuccess(_ title: String) {
        let view = viewToShow()
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .customView //模式设置为自定义视图
        hud.customView = UIImageView(image: UIImage(named: "tick")!) //自定义视图显示图片
        hud.label.text = title
        hud.removeFromSuperViewOnHide = true
        //HUD窗口显示1秒后自动隐藏
        hud.hide(animated: true, afterDelay: 1)
    }
    
    //显示失败消息
    class func showError(_ title: String) {
        let view = viewToShow()
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .customView //模式设置为自定义视图
        hud.customView = UIImageView(image: UIImage(named: "cross")!) //自定义视图显示图片
        hud.label.text = title
        hud.removeFromSuperViewOnHide = true
        //HUD窗口显示1秒后自动隐藏
        hud.hide(animated: true, afterDelay: 1)
    }
    
    
    //MARK:- 获取用于显示提示框的view
    @discardableResult
    class func viewToShow() -> UIView {
        
        var window = UIApplication.shared.keyWindow
        
        if window?.windowLevel != UIWindow.Level.normal {
            
            let windowArray = UIApplication.shared.windows
            
            for tempWin in windowArray {
                if tempWin.windowLevel == UIWindow.Level.normal {
                    window = tempWin
                    break
                }
            }
        }
        
        return window!
        
        
    }
    
}
