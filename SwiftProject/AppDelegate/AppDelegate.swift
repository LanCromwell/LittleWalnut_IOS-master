//
//  AppDelegate.swift
//  SwiftProject
//
//  Created by YX on 2019/1/14.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()
        ///友盟
        configUSharePlatforms()
        confitUShareSettings()
        ///判断启动页
        loadVC()
        ///添加引导页
        showGuidePage()
        ///配置键盘
        keyboardConfiiguration()
        //推送
        registerAPNS(launchOptions: launchOptions)
        
        let SCHEME = "xiaohetao2019";
       let conf = YZConfig.init(clientId: CLIENT_ID)
       conf.enableLog = true; // 关闭 sdk 的 log 输出
       conf.scheme = SCHEME; // 配置 scheme 以便微信支付完成后跳转
       YZSDK.shared.initializeSDK(with: conf);
        return true
    }
    
 
    fileprivate func registerAPNS(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        let entity = UMessageRegisterEntity.init()
        entity.types = Int(UInt8(UMessageAuthorizationOptions.badge.rawValue) | UInt8(UMessageAuthorizationOptions.alert.rawValue))
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = (self as UNUserNotificationCenterDelegate)
        } else {
            // Fallback on earlier versions
        }
        UMessage.registerForRemoteNotifications(launchOptions: launchOptions, entity: entity) { (granted, error) in }
    }
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
//        UIApplication.shared.beginReceivingRemoteControlEvents()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        //开始接受远程控制
//        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
//        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        UMessage.setBadgeClear(true)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        let result = UMSocialManager.default().handleOpen(url)
        if !result{
            
        }
        return result
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let result = UMSocialManager.default().handleOpen(url)
        if !result{
            
        }
        return result
    }

    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print(userInfo)
        UMessage.didReceiveRemoteNotification(userInfo);
    }
    
    @available(iOS 10.0, *)
    //iOS10新增：处理前台收到通知的代理方法
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        if (notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))! {
            let info = userInfo as NSDictionary
            print(info)
            //应用处于前台时的远程推送接受
            UMessage.setAutoAlert(false)
            UMessage.didReceiveRemoteNotification(userInfo)
        }else{
            //应用处于前台时的远程推送接受
        }
        completionHandler([.alert,.sound,.badge])
    }
    
    @available(iOS 10.0, *)
    //iOS10新增：处理后台点击通知的代理方法
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if (response.notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))! {
            let info = userInfo as NSDictionary
            print(info)
            //应用处于后台时的远程推送接受
            UMessage.didReceiveRemoteNotification(userInfo)
        }else{
            //应用处于前台时的远程推送接受
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let device = NSData.init(data: deviceToken)
        let device_Token = device.description.replacingOccurrences(of: "<", with: "").replacingOccurrences(of: ">", with: "").replacingOccurrences(of: " ", with: "")
        print("token == \(device_Token)")
    }
    

    

}


