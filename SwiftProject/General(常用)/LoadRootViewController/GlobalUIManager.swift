//
//  GlobalUIManager.swift
//  SwiftDemo
//
//  Created by liyan on 2018/1/11.
//  Copyright © 2018年 liyan. All rights reserved.
//

import UIKit

class GlobalUIManager {
    class func loadHomeVC() {
        let kWindow: UIWindow = UIApplication.shared.keyWindow!
        let rootVC = BaseTabBarViewController()
        rootVC.modalTransitionStyle = .crossDissolve
        UIView.transition(with: kWindow,
                          duration: 0.25,
                          options: .transitionCrossDissolve,
                          animations: {
                            let oldState = UIView.areAnimationsEnabled
                            UIView.setAnimationsEnabled(false)
                            kWindow.rootViewController = rootVC
                            kWindow.makeKeyAndVisible()
                            UIView.setAnimationsEnabled(oldState)
                            
        }, completion: nil)
    }
    
    class func loadLoginVC() {
        
        let kWindow: UIWindow = UIApplication.shared.keyWindow!
        let rootVC = BaseNavigationViewController.init(rootViewController: LoginViewController())
        rootVC.view.alpha = 1
        rootVC.modalTransitionStyle = .crossDissolve
        UIView.transition(with: kWindow,
                          duration: 0.25,
                          options: .transitionCrossDissolve,
                          animations: {
                            let oldState = UIView.areAnimationsEnabled
                            UIView.setAnimationsEnabled(false)
                            kWindow.rootViewController = rootVC
                            kWindow.makeKeyAndVisible()
                            UIView.setAnimationsEnabled(oldState)
        })
    }
}
