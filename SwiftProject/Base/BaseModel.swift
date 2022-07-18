//
//  BaseModel.swift
//  SwiftProject
//
//  Created by YX on 2019/9/5.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit
import HandyJSON

class BaseModel: HandyJSON {
    var code: Int!
    var data: Any?
    var msg: String!
    
    required init() {}

}
