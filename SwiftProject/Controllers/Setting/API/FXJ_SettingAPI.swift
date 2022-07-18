//
//  FXJ_SettingAPI.swift
//  SwiftProject
//
//  Created by 方新俊 on 2019/9/10.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit
import Moya


let settingProvider = MoyaProvider<FXJ_SettingAPI>(
    endpointClosure: endPointClosure,
    requestClosure: requestClosure,
    plugins: [networkPlugin]
)

public enum FXJ_SettingAPI {
    /// 获取角色
    case roleListAPI(phone: String, pwd: String)
     ///获取语言
    case languageListAPI(phone: String, pwd: String)
    ///编辑用户信息
    case settingUserInfoAPI(language_id: String,role_id: String,child_birthday: String,user_id: String)
    /// 提交用户反馈
    case feedbackCreateAPI(user_id: String, feedback_content: String)
    case test
}

extension FXJ_SettingAPI: TargetType{
    public var baseURL: URL {
        switch self {
        default:
            return URL.init(string: ServerAPI.host)!
        }
    }

    public var path: String {
        switch self {
        case .languageListAPI(phone: _, pwd: _):
            return ServerAPI.languageListAPI
        case .settingUserInfoAPI(language_id: _, role_id: _, child_birthday: _,user_id: _):
            return ServerAPI.editUserinfoAPI
        case .test:
            return ""
        case .roleListAPI(phone: _, pwd: _):
            return ServerAPI.roleListAPIPath
        case .feedbackCreateAPI(user_id:_, feedback_content:_):
            return ServerAPI.feedbackCreateAPIPath
        }
    }

    public var method: Moya.Method {
        switch self {
        case  .languageListAPI:
            return .post
        case  .roleListAPI:
            return .get
        default:
            return .post
        }
    }

    public var sampleData: Data {
         return "".data(using: .utf8)!
    }

    public var task: Task {
        switch self {
        case let .languageListAPI(phone, pwd):
            return .requestParameters(parameters:["phone": phone, "password":pwd], encoding: URLEncoding.httpBody)
        case let .settingUserInfoAPI(language_id, role_id, child_birthday, user_id):
            return .requestParameters(parameters:["language_id": language_id, "role_id": role_id ,"child_birthday":child_birthday,"user_id" : user_id], encoding: URLEncoding.httpBody)
        case let .roleListAPI(phone, pwd):
            return .requestParameters(parameters:["phone": phone, "password":pwd], encoding: URLEncoding.httpBody)
        case let .feedbackCreateAPI(user_id, feedback_content):
            print(user_id,feedback_content)
                return .requestParameters(parameters: ["user_id" : user_id,"feedback_content":feedback_content], encoding: URLEncoding.httpBody)
        default:
            return .requestParameters(parameters:["": ""], encoding: URLEncoding.httpBody)
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
}
