//
//  Appdelegate+Guide.swift
//  SwiftProject
//
//  Created by YX on 2019/7/25.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

extension AppDelegate {
    
    ///判断落地页
    public func loadVC() {
        UIApplication.shared.statusBarStyle = .lightContent
        if UserInfo.default.findUserInfo() != nil {
            GlobalUIManager.loadHomeVC()
        } else {
            GlobalUIManager.loadLoginVC()
        }
        
    }
    
    ///显示引导页
    public func showGuidePage() {
        if UserDefaults.standard.bool(forKey: "guideKey") == false {
            UserDefaults.standard.set(true, forKey: "guideKey")
            let guideView = HHGuidePageHUD.init(imageNameArray: ["01", "02", "03"], isHiddenSkipButton: true)
            self.window?.addSubview(guideView)
        }
        
    }
    
    ///配置键盘
    public func keyboardConfiiguration() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 80
    }
    
    ///友盟配置
    public func confitUShareSettings() {

        UMSocialManager.default()?.openLog(true)
        ///5d99ab193fc195ab2d0004f7     5c2d7732b465f529e200005a
        UMConfigure.initWithAppkey("5d99ab193fc195ab2d0004f7", channel: "App Store")
    }
    
    public func configUSharePlatforms() {
        /* 设置微信的appKey和appSecret */
        UMSocialManager.default()?.setPlaform(.wechatSession, appKey: "wxccf50f4c57ae406d", appSecret: "c104accc32cf5d1e0b61ebd7b6a8e4c4", redirectURL: "http://mobile.umeng.com/social")
        /* 设置分享到QQ互联的appID
         * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
         */
        UMSocialManager.default()?.setPlaform(.QQ, appKey: "101547696", appSecret: "24af30ae1b18c0dd48424ccecb976f47", redirectURL: "http://mobile.umeng.com/social")
    }
    
}
