//
//  MoyaPluginConfig.swift
//  SwiftProject
//
//  Created by YX on 2019/7/20.
//  Copyright © 2019 MT. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import MBProgressHUD



///设置请求头
let endPointClosure = { (target: TargetType) -> Endpoint in
    
    let url = target.baseURL.absoluteString + target.path
    var endpoint = Endpoint(
        url: url,
        sampleResponseClosure: { .networkResponse(200, target.sampleData) },
        method: target.method,
        task: target.task,
        httpHeaderFields: target.headers
    )
    
    ///可以自定义一些公用Header Demo 如下
//    endpoint = endpoint.adding(newHTTPHeaderFields: [
//        "Content-Type" : "application/x-www-form-urlencoded",
//        "ECP-COOKIE" : ""
//    ])
    
    return endpoint
}

///设置超时
let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
    do {
        var request = try endpoint.urlRequest()
        //设置请求时长
        request.timeoutInterval = 25
        // 打印请求参数
        if let requestData = request.httpBody {
            print("\(request.url!)"+"\n"+"\(request.httpMethod ?? "")"+"  发送参数  "+"\(String(data: request.httpBody!, encoding: String.Encoding.utf8) ?? "")")
        } else {
            print("\(request.url!)"+"\(String(describing: request.httpMethod))")
        }
        done(.success(request))
    } catch {
        done(.failure(MoyaError.underlying(error, nil)))
    }
}


/// NetworkActivityPlugin插件用来监听网络请求
let networkPlugin = NetworkActivityPlugin.init { (changeType, targetType) in
    
//    print("networkPlugin \(changeType)")
    //targetType 是当前请求的基本信息
    switch(changeType){
    case .began:
        mt_threadSafe {
            MBProgressHUD.showWait("加载中...")
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        print("开始请求网络")
        
    case .ended:
        mt_threadSafe {
            MBProgressHUD.hiddenHUD()
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        print("结束")
    }
}


