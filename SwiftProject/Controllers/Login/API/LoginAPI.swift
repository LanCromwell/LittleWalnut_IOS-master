//
//  LoginAPI.swift
//  SwiftProject
//
//  Created by YX on 2019/9/5.
//  Copyright © 2019 MT. All rights reserved.
//

import Foundation
import Moya



let loginProvider = MoyaProvider<LoginAPI>(
    endpointClosure: endPointClosure,
    requestClosure: requestClosure,
    plugins: [networkPlugin]
)


public enum LoginAPI {
    case loginAPI(username: String, pwd: String,operatorInfo : String,phone_brand : String,phone_model : String  )                 ///登录
    case obtainCode(phone: String)                               ///获取验证码
    case registerAPI(phone: String, code: String, pwd: String, invited: String,operatorInfo : String,phone_brand : String,phone_model : String)      ///注册
    case resetPwdAPI(phone: String, code: String, pwd: String)          ///重置密码
    case userInfoAPI(user_info: String)                              ///获取用户信息
    case thridLoginAP(third_unique_id: String, third_icon: String, third_name: String, type: Int ,operatorInfo : String,phone_brand : String,phone_model : String )   ///三方登录
    case thridBindAPI(third_unique_id: String, third_icon: String, third_name: String, type: Int, phone: String, code: String, pwd: String, invited: String)            ///三方登录 绑定
    case forgetpwdAPI(params: [String: Any])     ///忘记密码
    case test
}


extension LoginAPI: TargetType {
    ///域名
    public var baseURL: URL {
        switch self {
        case .obtainCode(phone: _):
            return URL.init(string:ServerAPI.host + "api/sms/send")!
        default:
            return URL.init(string: ServerAPI.host)!
        }
    }
    
    ///URI
    public var path: String {
        switch self {
        case .loginAPI(username: _, pwd: _, operatorInfo: _, phone_brand: _, phone_model : _):
            return ServerAPI.loginAPI
        case .obtainCode(phone: _):
            return ""
        case .registerAPI(phone: _, code: _, pwd: _, invited: _,operatorInfo: _, phone_brand: _, phone_model : _):
            return ServerAPI.registerAPI
        case .resetPwdAPI(phone: _, code: _, pwd: _):
            return ServerAPI.resetPwdAPI
        case .userInfoAPI(user_info: _):
            return "api/user/user_info"
        case .thridLoginAP(third_unique_id: _, third_icon: _, third_name: _, type: _,operatorInfo: _, phone_brand: _, phone_model : _):
            return ServerAPI.loginAPI
        case .thridBindAPI(third_unique_id: _, third_icon: _, third_name: _, type: _, phone: _, code: _, pwd: _, invited: _):
            return ServerAPI.registerAPI
        case .forgetpwdAPI(params: _):
            return "api/user/forgot_pwd"
        case .test:
            return ""
        }
        
    }
    
    ///请求方式
    public var method: Moya.Method {
        switch self {
        case .loginAPI:
            return .post
        default:
            return .post
        }
    }
    
    
    public var task: Task {
        switch self {
        case let .loginAPI(username, pwd, operatorInfo, phone_brand, phone_model ):
            return .requestParameters(parameters:["phone": username,
                                                "password":pwd,
                                                "verification_code":pwd,
                                                "operator":operatorInfo,
                                                "phone_brand":phone_brand,
                                                "phone_model":phone_model],
                                  encoding: URLEncoding.httpBody)
        case .obtainCode(let phone):
            return .requestParameters(parameters:["mobile": phone], encoding: URLEncoding.httpBody)
        case let .registerAPI(phone, code, pwd, invited,operatorInfo, phone_brand, phone_model):
            return .requestParameters(parameters:["phone": phone,
                                                  "password": pwd,
                                                  "invitation_code": invited,
                                                  "verification_code": code,
                                                  "operator":operatorInfo,
                                                  "phone_brand":phone_brand,
                                                  "phone_model":phone_model],
                                      encoding: URLEncoding.httpBody)
        case let .resetPwdAPI(phone , code , pwd ):
            return .requestParameters(parameters:["phone": phone,
                                                  "password": pwd,
                                                  "verification_code": code],
                                      encoding: URLEncoding.httpBody)
        case let .userInfoAPI(user_info):
            return .requestParameters(parameters:["user_id": user_info],
                                      encoding: URLEncoding.httpBody)
            
        case let .thridLoginAP(third_unique_id, third_icon, third_name, type , operatorInfo, phone_brand, phone_model):
            return .requestParameters(parameters:["third_unique_id": third_unique_id,
                                                  "third_icon": third_icon,
                                                  "third_name": third_name,
                                                  "type": type,
                                                  "operator":operatorInfo,
                                                  "phone_brand":phone_brand,
                                                  "phone_model":phone_model],
                                      encoding: URLEncoding.httpBody)
            
        case let .thridBindAPI(third_unique_id, third_icon, third_name, type, phone, code, pwd, invited):
            return .requestParameters(parameters:["third_unique_id": third_unique_id,
                                                  "third_icon": third_icon,
                                                  "third_name": third_name,
                                                  "type": type,
                                                  "phone": phone,
                                                  "password": pwd,
                                                  "invitation_code": invited,
                                                  "verification_code": code],
                                      encoding: URLEncoding.httpBody)
            
        case let .forgetpwdAPI(params):
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.httpBody)
            
        default:
            return .requestParameters(parameters:["": ""], encoding: URLEncoding.httpBody)
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
    

    ///单元测试
    public var sampleData: Data {
        return "".data(using: .utf8)!
    }
}
