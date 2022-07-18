//
//  NSDate+Extension.swift
//  PromeSwift
//
//  Created by liyan on 2017/6/9.
//  Copyright © 2017年 liyan. All rights reserved.
//

import Foundation


enum dateFormatStyle: String {
    case y_M_d = "yyyy-MM-dd"
    case y_M_d_H_m_s = "yyyy-MM-dd HH:mm:ss"
}

extension Date {
    
    //MARK:- 实例化一个 DateFormatter 对象
    static func formatterWithStyle(withStyle style: dateFormatStyle) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = style.rawValue
        return formatter
    }
    
    
    //MARK: - <eg:时间戳 -> String>根据时间戳返回日期 （可以通过泛型优化）
    /*
     *  参数类型     时间戳 -> String
     *  返回类型     Date？
     */
    static func toDateWithTimeStamp(_ timeStamp: String) -> Date? {
        if let  interval = TimeInterval(timeStamp) {
            return Date(timeIntervalSince1970: interval / 1000.0)
        }
        
        return nil;
    }
    
    
    //MARK:- <eg:Date -> String>  根据日期返回字符串
    /*
     *  returns： String类型
     */
    func toString(_ style: dateFormatStyle) -> String {
        let formatter = Date.formatterWithStyle(withStyle: style)
        return formatter.string(from: self)
    }
    
    //MARK:- <eg:Date -> Bool> 根据时间判断是否是今天
    /*
     * return:  true  or false
     */
    func isToday() -> Bool {
        let calendar = Calendar.current
        let unit: NSCalendar.Unit = [.day, .month, .year]
        
        let nowCmps = (calendar as NSCalendar).components(unit, from: Date())
        let fromCmps = (calendar as NSCalendar).components(unit, from: self)
        return nowCmps.day == fromCmps.day && nowCmps.month == fromCmps.month && nowCmps.year == fromCmps.year
    }
}
