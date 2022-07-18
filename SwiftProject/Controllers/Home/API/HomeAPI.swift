//
//  HomeAPI.swift
//  SwiftProject
//
//  Created by YX on 2019/7/19.
//  Copyright © 2019 MT. All rights reserved.
//


import Foundation
import Moya

/**
 endpointClosure: 用于定义请求头相关信息
 requestClosure: 定制request。当 Endpoint 有问题时，提前拦截请求，即决定是否执行请求或执行什么样的请求
 stubClosure: 是否使用 SampleData 作为请求返回的数据，用于模拟网络请求
 callbackQueue: 请求所在的队列
 manager: 一般用于定制 configuration。configuration 包含了 requestCachePolicy 、 timeoutIntervalForRequest 、 httpAdditionalHeaders 、 httpCookieStorage 等设置
 plugins: 插件，遵守PluginType协议，做一些请求发送前、请求响应后的操作
 */


let homeProvider = MoyaProvider<HomeAPI>(
    endpointClosure: endPointClosure,
    requestClosure: requestClosure,
    plugins: [networkPlugin]
)


public enum HomeAPI {
    case homeContentListApi
    case homeAduioListApi(params: [String: Any])
    case homeCollectAudioAPI(params: [String: Any])
    case expertListApi                               ///严选列表
    case expertSearchApi(params: [String: Any])                            ///搜索API
    case expertAudioListApi(params: [String: Any])
    
    case expertVIPInfoAPI(params: [String : Any])      ///会员信息
    case userCollectListAPI(params: [String: Any])         ///用户搜藏
     case userHistoryNoteListAPI(params: [String: Any])         ///历史记录
    case userAddDaysAPI(params: [String: Any])         ///增加使用天数

    case homeChangeMp3StudyState(params: [String: Any])    ///mp3 播放完成后 修改状态
    case test
}


extension HomeAPI: TargetType {
    ///域名
    public var baseURL: URL {
        return URL.init(string: ServerAPI.host)!
    }
    
    ///URI
    public var path: String {
        switch self {
        case .homeContentListApi:
            return ServerAPI.homeContentAPI
        case .homeAduioListApi(params: _):
            return "api/audio/reminder_today"
        case .homeCollectAudioAPI(params: _):
            return "api/audio/user_collect_audio"
        case .expertListApi:
            return "api/category/list"
        case .expertSearchApi(params: _):
            return "api/audio/search"
        case .expertAudioListApi(params: _):
            return "api/audio/list"
        case .expertVIPInfoAPI(params: _):
            return "api/user/receive_vip"
        case .userCollectListAPI(params: _):
            return "api/audio/user_collect_audio_list"
        case .homeChangeMp3StudyState(params: _):
            return "api/audio/add_play_number"
        case .userHistoryNoteListAPI(params: _):
        return "api/audio/user_listen_audio_list"
            case .userAddDaysAPI(params: _):
                 return "api/user/add_days"
        case .test:
            return ""
        }
        
    }
   
    ///请求方式
    public var method: Moya.Method {
        switch self {
        case .homeContentListApi:
            return .post
        case .homeAduioListApi(params: _):
            return .post
//        case .expertVIPInfoAPI(params: _):
//            return .get
        default:
            return .post
        }
    }
    
    
    public var task: Task {
        switch self {
        case .homeContentListApi:
            return .requestParameters(parameters:["name": "ly"], encoding: URLEncoding.httpBody)
        case let .homeAduioListApi(params):
            return .requestParameters(parameters:params, encoding: URLEncoding.httpBody)
        case let .homeCollectAudioAPI(params):
            return .requestParameters(parameters:params, encoding: URLEncoding.httpBody)
        case let .expertSearchApi(params):
            return .requestParameters(parameters:params, encoding: URLEncoding.httpBody)
            
        case let .expertAudioListApi(params):
             return .requestParameters(parameters:params, encoding: URLEncoding.httpBody)
            
        case let .expertVIPInfoAPI(params):
            return .requestParameters(parameters:params, encoding: URLEncoding.httpBody)
        case let .userCollectListAPI(params):
            return .requestParameters(parameters:params, encoding: URLEncoding.httpBody)
        case let .homeChangeMp3StudyState(params):
            return .requestParameters(parameters:params, encoding: URLEncoding.httpBody)
        default:
            return .requestParameters(parameters:["name": "ly"], encoding: URLEncoding.httpBody)
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
