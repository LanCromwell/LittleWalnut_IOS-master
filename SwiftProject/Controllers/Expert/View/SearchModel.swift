//
//  SearchModel.swift
//  SwiftProject
//
//  Created by YX on 2019/9/12.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit
import HandyJSON


class SearchModel: HandyJSON {
    var add_time: String?
    var audio_path: String?
    var category_id: Int?
    var collect_number: Int?
    var duration: String?
    var id: Int?
    var is_collect: Int?
    var is_study: Int?
    var language_id: Int?
    var play_number: Int?
    var search_content: String?
    var type: String?
    var title: String?
    var isPlaying: Bool = false
    
    required init() {}
}
