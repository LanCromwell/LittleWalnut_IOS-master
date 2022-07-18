//
//  Common.swift
//  SwiftDemo
//
//  Created by liyan on 2018/1/3.
//  Copyright © 2018年 liyan. All rights reserved.
//

import UIKit


public let kScreenWidth         = UIScreen.main.bounds.width                 //当前屏幕宽度
public let kScreenHeight        = UIScreen.main.bounds.height                //当前屏幕高度

public let kWIDTHBASE           = kScreenWidth / 375.00                        //宽度基本比例
public let kHHEIGHTBASE         = kScreenHeight / 667.0                      //高度基本比例

// TODO: 请填写你的 CLIENT_ID / CLIENT_SECRET / KDTID
public let CLIENT_ID = "03e3b11bd9a1ea2b97";
public let CLIENT_SECRET = "95e8099f589634db94939fb5049314cf";
public let KDT_ID = "44647412,";

//状态栏高度 兼容iPhone X 普通 20.0    iphone X 44.0
public let kStatusHeight        = UIApplication.shared.statusBarFrame.height
//导航栏高度
public let kNavBarHeight        = 44.0
//头部高度
public let kTopHeight           = kStatusHeight + 44.0

///异形屏
public let isSpecialShapedScreen = (LYUtilsDeviceType.isIphoneX || LYUtilsDeviceType.isIphoneXR) ? true : false


//tabbar高度
public let kTabBarHeight        = 49.0
//tabbar底部间距 适配iphone X
public let kBottomSpaceHeight   = isSpecialShapedScreen ? 34.0 : 0.0
//底部高度
public let kBottomHeight        = isSpecialShapedScreen ? 83.0 : 49.0

///导航坐标
let topFrame: CGRect = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kTopHeight)
///内容坐标
let contentFrame: CGRect = CGRect.init(x: 0, y: kTopHeight, width: kScreenWidth, height: kScreenHeight - kTopHeight - kBottomHeight)
///阴影坐标
let shadowFrame: CGRect =  CGRect.init(x: 20, y: kStatusHeight + 20, width: kScreenWidth - 20 * 2, height: kScreenHeight - kBottomHeight - kStatusHeight - 40)
///阴影子类坐标 (预留边距 )
let shadowContentFrame = CGRect.init(x: 5, y: 5, width: shadowFrame.width - 10, height: shadowFrame.height - 10)



//MARK:- 自定义打印方法
public func kLog<T>(_ message: T, file: String = #file, funcName: String = #function, lineNum: Int = #line) {
    
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("\(fileName):(\(lineNum))-\(message)")
        
    #endif
}


public func mt_threadSafe(closure: @escaping () -> Void) {
    if (Thread.isMainThread) {
        closure()
    } else {
        DispatchQueue.main.async {
            closure()
        }
    }
}


