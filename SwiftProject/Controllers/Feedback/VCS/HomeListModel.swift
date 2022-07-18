//
//  HomeListModel.swift
//  SwiftProject
//
//  Created by YX on 2019/9/11.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit
import HandyJSON


class HomeListModel: HandyJSON {
    
    var add_time : Int?
    var audio_path : String?
    var category_id : Int?
    var collect_number : Int?
    var day : Int?
    var duration : String?
    var id : Int?
    var is_collect : Int?
    var is_study : Int?
    var language_id : Int?
    var play_number : Int?
    var remind_date : Int?
    var search_content : Int?
    var sort : Int?
    var title : String?
    var type : Int?
    var description_href : String?

    required init() {}
}
