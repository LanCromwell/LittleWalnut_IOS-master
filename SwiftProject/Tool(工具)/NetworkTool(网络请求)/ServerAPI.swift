//
//  ServerAPI.swift
//  SwiftProject
//
//  Created by YX on 2019/7/19.
//  Copyright © 2019 MT. All rights reserved.
//

import Foundation

struct ServerAPI {
    
    enum ServerType {
        case DevType               ///开发环境
        case ReleaseType           ///生产环境
    }
    
    static let kService = ServerType.DevType
    static var host: String {
        get {
            switch kService {
            case .DevType:
                return "http://test.api.mamaucan.cn/"
                
            case .ReleaseType:
                return "http://api.mamaucan.cn/"
                
            }
        }
    }
    
    
}



extension ServerAPI {
    //MARK:-  测试
    public static let homeContentAPI = "api/v2/login"
    //MARK:- 登录
    public static let loginAPI = "api/v2/login"
    ///MARK:- 注册
    public static let registerAPI = "api/v2/register"
    ///MARK:- 忘记密码 重置密码
    public static let resetPwdAPI = "api/login"
    ///获取首页提醒
    public static let homeAudioAPI = ""
    
    ///MARK:- 获取语言
    public static let languageListAPI = "api/language/list"
     ///MARK:- 编辑用户信息
    public static let editUserinfoAPI = "api/user/edit"
    ///MARK:- 获取角色列表
    public static let roleListAPIPath = "api/user/edit"
    ///MARK:- 意见反馈提交
    public static let feedbackCreateAPIPath = "api/feedback/create"

}
