//
//  UserInfo.swift
//  SwiftProject
//
//  Created by YX on 2019/9/5.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit
import HandyJSON

class UserInfo: HandyJSON, Codable {
    var id: String?
    var phone: String?
    var token: String?
    var avatar: String?
    var add_time: String?
    var register_data: RegisterData?
    var register_date: String?
    var role_name: String?
    var role_id: String?
    
    var language_name: String?
    var language_id: String?
    
    var is_receive_vip: String?
    var invite_info : invite_infoModel?
    var first_login : String? // 1  是首次登录
    var child_birthday : String?
    
    var youzan_info : youzan_infoModel? // 有赞信息

    var is_free: String? // 是否免费
    var remainder_days: String? // 剩余天数
    var user_share_get_day: String? // 分享获取的天数
    
    ///单例对象
    static let `default` = UserInfo()

    required init() {}
    
    func saveUserInfo() {
        let filePath = "userInfo.archiver".docDir()
//        print(filePath)
        do {
            let encodeData = try JSONEncoder().encode(self)
            NSKeyedArchiver.archiveRootObject(encodeData, toFile: filePath)
        } catch {
            
        }
    }
    
    func findUserInfo() -> UserInfo? {
        let filePath = "userInfo.archiver".docDir()
        if let data = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) {
            let userInfo = try? JSONDecoder().decode(UserInfo.self, from: data as! Data)
            return userInfo
        }
        
        return nil
    }
    
    func removeUserInfo() {
        let filePath = "userInfo.archiver".docDir()
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(atPath: filePath)
        } catch  {
            
        }
    }
}




class RegisterData: HandyJSON, Codable {
    var day: Int?
    var hour: Int?
    var min: Int?
    var sec: Int?
    
    required init() {}
}

class invite_infoModel: HandyJSON, Codable {
    var href: String?
    var title: String?
    var description: String?
    var invitation_code: String?
    
    required init() {}
}

class youzan_infoModel: HandyJSON, Codable {
    var access_token: String?
    var cookie_key: String?
    var cookie_value: String?
    var customer_service_href: String?
    var shop_href: String?

    required init() {}
}
