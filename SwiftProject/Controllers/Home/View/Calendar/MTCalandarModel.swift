//
//  MTCalandarModel.swift
//  SwiftProject
//
//  Created by YX on 2019/7/27.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit
import JKCategories

enum MTDayType: Int {
    case currentMonth   = 0
    case perviousMonth  = 1
    case nextMonth      = 2
}


class MTCalandarModel: NSObject {
    ///日期
    var date: Date
    ///显示日期的状态
    var type: MTDayType = .currentMonth
    ///是否选中
    var isSelected: Bool = false
    ///是否是今天
    var isToday: Bool = false
    ///阴历
    var lunarStr: String = ""
    ///阳历
    var solarStr: String = ""
    ///携带数据
    var data: HomeListModel?
    
    init(_ date: Date, type: MTDayType) {
        self.date = date
        self.type = type
        self.isToday = (date as NSDate).jk_isToday()
        self.solarStr = String((date as NSDate).jk_day())
    }
    
    
}
