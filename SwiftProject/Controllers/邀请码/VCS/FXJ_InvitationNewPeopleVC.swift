//
//  FXJ_InvitationNewPeopleVC.swift
//  SwiftProject
//
//  Created by 方新俊 on 2019/9/9.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit

class FXJ_InvitationNewPeopleVC: BaseViewController {

    ///contentView
    lazy var contentView: UIImageView = {
        let contentView = UIImageView()
        contentView.image = UIImage.init(named: "新人红包")
        return contentView
    }()
    
    ///关闭按钮
    lazy var closeBtn: UIButton = {
        let btn = UIButton.init()
        btn.setImage(UIImage.init(named: "back_circle"), for: .normal)
        btn.setImage(UIImage.init(named: "back_circle"), for: .highlighted)
        btn.addTarget(self, action: #selector(closeEvent), for: .touchUpInside)
        return btn
    }()

    /// 立即领取
    lazy var boonBtn: UIButton = {
        let btn = UIButton.init()
//        btn.backgroundColor = UIColor.hexInt(0x999999, 0.5)
        btn.backgroundColor = UIColor.clear
        btn.addTarget(self, action: #selector(boonBtnEvent), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
        loadFrame()
       
    }
}

extension FXJ_InvitationNewPeopleVC {
    @objc func closeEvent() {
        self.popController?.dismiss()
    }
    
    @objc func boonBtnEvent() {
       print("立即领取")
        userVPIInfoData()
    }
    
    // 立即领取vip
    func userVPIInfoData() {
        let userInfo = UserInfo.default.findUserInfo()
        homeProvider.request(.expertVIPInfoAPI(params: ["user_id" : (userInfo!.id)!])) { [weak self](result) in
            
            switch result {
            case .success(let res):
                let jsonStr = String.init(data: res.data, encoding: .utf8)
                try? print("result.mapJSON() = \(res.mapJSON())")
                if let model = BaseModel.deserialize(from: jsonStr) {
                    if model.code == 200 {
//                        if model.data == nil{
//                            self?.popEvent()
//                        }
//                        self?.obtainUserInfo()
                        
                        userInfo?.is_receive_vip = "1";
                        userInfo?.saveUserInfo()
                        self?.view.makeToast(model.msg, position: .center)

                        // 4.GCD 主线程/子线程
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self?.closeEvent()
                        }
                        
                    } else {
                        self?.view.makeToast(model.msg, position: .center)
                    }
                }
                
            case .failure(let error):
                print(error)
            }
            
            
        }
        
    }
    // 获取用户信息
//     func obtainUserInfo() {
//        let uInfo = UserInfo.default.findUserInfo()
//        loginProvider.request(.userInfoAPI(user_info: uInfo!.id!)) { [weak self](result) in
//            switch result {
//            case .success(let res):
//                let jsonStr = String.init(data: res.data, encoding: .utf8)
//                try? print("result.mapJSON() = \(res.mapJSON())")
//                if let model = BaseModel.deserialize(from: jsonStr) {
//                    if model.code == 200 {
//                        let userInfo = UserInfo.deserialize(from: model.data as? [String: Any])
//                        uInfo?.invite_info = userInfo?.invite_info;
//                        uInfo?.is_receive_vip = userInfo?.is_receive_vip;
//                        uInfo?.saveUserInfo()
//                    } else {
//                        self?.view.makeToast(model.msg)
//                    }
//                }
//
//
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
}


extension FXJ_InvitationNewPeopleVC {
    func loadUI() {
        self.contentSizeInPop = CGSize.init(width: 260, height: 330)
        self.contentSizeInPopWhenLandscape = CGSize.zero
        
        view.addSubview(contentView)
        view.addSubview(closeBtn)
        view.addSubview(boonBtn)
        ///透明设置
        self.popController?.containerView.backgroundColor = UIColor.clear
        self.popController?.contentView.backgroundColor = UIColor.clear
        view.backgroundColor = UIColor.clear
        
        ///禁止空白区域点击
        self.popController?.shouldDismissOnBackgroundTouch = false
    }
    
    func loadFrame() {
        contentView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(32)
            make.height.equalTo(289)
        }
        
        closeBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 32, height: 32))
            make.left.equalTo(contentView).offset(10)
            make.bottom.equalTo(contentView.snp.top)
        }
        
        boonBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 177, height: 40))
            make.centerX.equalTo(contentView).offset(-8)
            make.bottom.equalTo(contentView).offset(-25)
        }
    }
    
    
}
