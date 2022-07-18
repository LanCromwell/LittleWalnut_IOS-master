//
//  LYUtilsAPP.swift
//  PromeSwift
//
//  Created by liyan on 2017/6/9.
//  Copyright © 2017年 liyan. All rights reserved.
//

import Foundation
import UIKit

//MARK:- app 相关信息
public struct LYUtilsAPP {
    /// Info.plist
    static let infoDictionary = Bundle.main.infoDictionary!
    /// 项目名称
    static let executable = LYUtilsAPP.infoDictionary[String(kCFBundleExecutableKey)]
    /// bundle Identifier
    static let identifier = Bundle.main.bundleIdentifier!
    /// version版本号
    static let shortVersion = LYUtilsAPP.infoDictionary["CFBundleShortVersionString"]
    /// build版本号
    static let version = LYUtilsAPP.infoDictionary[String(kCFBundleVersionKey)]
    /// app名称
    static let name = LYUtilsAPP.infoDictionary[String(kCFBundleNameKey)]
    /// app定位区域
    static let localizations = LYUtilsAPP.infoDictionary[String(kCFBundleLocalizationsKey)]
}




//MARK:- 判断机型
public struct LYUtilsDeviceType {
    
    /// IPhone4
    static let isIPhone4 = LYUtilsUserInterfaceIdiom.isPhone && kScreenHeight == 480.0
    /// IPhone5
    static let isIPhone5 = LYUtilsUserInterfaceIdiom.isPhone && kScreenHeight == 568.0
    /// IPhone6 & 6s  7
    static let isIPhone6 = LYUtilsUserInterfaceIdiom.isPhone && kScreenHeight == 667.0
    /// IPhone6P & 7p
    static let isIPhone6P = LYUtilsUserInterfaceIdiom.isPhone && kScreenHeight == 736.0
    /// IPhoneX  XS  375 * 812
    static let isIphoneX = LYUtilsUserInterfaceIdiom.isPhone && kScreenHeight == 812.0
    /// IPhoneXR XS Max
    static let isIphoneXR = LYUtilsUserInterfaceIdiom.isPhone && kScreenHeight == 896.0
}




//MARK:- 判断设备类别
public struct LYUtilsUserInterfaceIdiom {
    
    /// The user interface should be designed for iPhone and iPod touch.
    static let isPhone = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
    /// The user interface should be designed for iPad.
    static let isPad = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    /// The user interface should be designed for Apple TV.
    static let isAppleTV = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.tv
    
}
