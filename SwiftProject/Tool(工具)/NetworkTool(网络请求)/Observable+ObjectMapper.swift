//
//  Observable+ObjectMapper.swift
//  SwiftProject
//
//  Created by YX on 2019/1/17.
//  Copyright © 2019 MT. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxSwift


///定义数据转Json协议
public protocol Mapable {
    init(fromJson json: JSON!)
}


///定义错误
enum MapError: Swift.Error {
    case MapNoMoyaResponse                //不是一个Response
    case MapFailureHTTP                   //失败的网络请求
    case MapNoData                        //没有数据
    case MapNotMakeObjectError            //非对象
    case MapMsgError(statusCode: Int?, errorMsg: String?)    //其余错误(例如表单验证错误，有错误提示)
}



