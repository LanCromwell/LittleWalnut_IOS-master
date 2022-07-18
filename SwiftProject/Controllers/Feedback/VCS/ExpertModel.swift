//
//  ExpertModel.swift
//  SwiftProject
//
//  Created by YX on 2019/9/11.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit
import HandyJSON


class ExpertModel: HandyJSON {
    var add_time: String?
    var audio_numebr: String?
    var click_number: String?
    var id: String?
    var img: String?
    var is_del: String?
    var name: String?
    var pid: String?
    var update_time: String?
    var child: [ExpertModel]?

    required init() {}
}
