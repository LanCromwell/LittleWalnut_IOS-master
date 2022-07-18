//
//  RegisterViewController.swift
//  SwiftProject
//
//  Created by YX on 2019/7/26.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit
import Toast_Swift
import SwiftyJSON
import HandyJSON

class RegisterViewController: BaseViewController {
    
    // 运营商信息
    var operatorStr : String?
    // 手机型号
    var phone_model : String?
    // 手机品牌
    var phone_brand : String?
    
    ///三方登录参数
    var third_unique_id: String?
    var third_icon: String?
    var third_name: String?
    var type: Int?
    
    ///注册视图
    lazy var registerView: RegisterView = {
        let registerView = RegisterView.init(frame: UIScreen.main.bounds)
        registerView.codeBtn.addTarget(self, action: #selector(obtainCodeEvent), for: .touchUpInside)
        registerView.registerBtn.addTarget(self , action: #selector(registerEvent), for: .touchUpInside)
        return registerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
        loadFrame()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
}


//MARK:- UI & Frame
extension RegisterViewController {
    ///视图
    fileprivate func loadUI() {
        view.addSubview(registerView)
    }
    
    ///布局
    fileprivate func loadFrame() {
        
    }
}


//MARK:- 事件处理
extension RegisterViewController {
    ///获取验证码
    @objc func obtainCodeEvent() {
        print("获取验证码事件")
        let phoneString = registerView.phoneTF.text!
        if !Validate.feCheckMobile(phoneString) {
           view.makeToast("注册手机号不合法", position: .center)
            return
        }
        
        
        loginProvider.request(.obtainCode(phone: phoneString)) { [weak self](result) in
            switch result {
            case .success(let res):
                guard let json = try? JSON.init(data: res.data) else { return }
                
                if json["code"].intValue == 200 {
                    
                } else {
                    self?.view.makeToast(json["msg"].stringValue, position: .center)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    ///注册事件
    @objc func registerEvent() {
        print("注册事件")
        let phoneString = registerView.phoneTF.text!
        if !Validate.feCheckMobile(phoneString) {
            view.makeToast("注册手机号不合法", position: .center)
            return
        }
        
        let codeString = registerView.codeTF.text!
        if codeString.count == 0 {
            view.makeToast("验证码不能为空", position: .center)
            return
        }
        
        let pwdString = registerView.pwdTF.text!
        if pwdString.count == 0 {
            view.makeToast("密码不能为空", position: .center)
            return
        }
        
        let invitedCode = registerView.invitedTF.text!
        
        ///正常注册
        if third_unique_id == nil {
            loginProvider.request(.registerAPI(phone: phoneString, code: codeString, pwd: pwdString, invited: invitedCode, operatorInfo: operatorStr ?? "", phone_brand: phone_brand ?? "", phone_model: phone_model ?? "")) { [weak self](result) in
                switch result {
                case .success(let res):
                    let jsonStr = String.init(data: res.data, encoding: .utf8)
                    if let model = BaseModel.deserialize(from: jsonStr) {
                        if model.code == 200 {
                            let userInfo = UserInfo.deserialize(from: model.data as? [String: Any])
                            userInfo?.saveUserInfo()
                            let thridname = "xht"+userInfo!.id!
                            UMessage.setAlias(thridname, type: "xht_app") { (responseObject, error) in
                                print(responseObject as Any,error as Any);
                             }
                            self?.gotoSettingVC()
                            
//                            self?.navigationController?.popViewController(animated: true)
                        } else {
                            self?.view.makeToast(model.msg, position: .center)
                        }
                    }
                    
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        ///三方绑定
        else {
            loginProvider.request(.thridBindAPI(third_unique_id: third_unique_id ?? "",
                                                third_icon: third_icon ?? "",
                                                third_name: third_name ?? "",
                                                type: type ?? 0,
                                                phone: phoneString ,
                                                code: codeString,
                                                pwd: pwdString,
                                                invited: invitedCode)) { [weak self](result) in
                switch result {
                case .success(let res):
                    let jsonStr = String.init(data: res.data, encoding: .utf8)
                    if let model = BaseModel.deserialize(from: jsonStr) {
                        if model.code == 200 {
                            let userInfo = UserInfo.deserialize(from: model.data as? [String: Any])
                            let first_login =  ((userInfo?.first_login) != nil) as Bool
                            if first_login {
                                print("第一次登录")
                                self?.gotoSettingVC()
                            }else{
                                print("不是第一次登录")
                                GlobalUIManager.loadHomeVC()
                            }
                            userInfo?.saveUserInfo()
//                            GlobalUIManager.loadHomeVC()
                            let thridname = "xht"+userInfo!.id!
                           UMessage.setAlias(thridname, type: "xht_app") { (responseObject, error) in
                               print(responseObject as Any,error as Any);
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
        

    }
    
    ///去设置
    func gotoSettingVC() {
        let firstVC = SettingFirstViewController()
        firstVC.isRegisterEnter = true
        navigationController?.pushViewController(firstVC, animated: true)
    }
}
