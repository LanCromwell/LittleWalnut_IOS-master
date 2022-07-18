//
//  ForgetPwdViewController.swift
//  SwiftProject
//
//  Created by YX on 2019/7/26.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit
import Toast_Swift
import SwiftyJSON
import HandyJSON

class ForgetPwdViewController: BaseViewController {
    
    ///忘记密码视图
    let forgetView: ForgetpwdView = {
        let forgetView = ForgetpwdView.init(frame: UIScreen.main.bounds)
        forgetView.codeBtn.addTarget(self, action: #selector(obtainCodeEvent), for: .touchUpInside)
        forgetView.commitBtn.addTarget(self , action: #selector(commitEvent), for: .touchUpInside)
        return forgetView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
        loadFrame()
    }
    
}


//MARK:- UI & Frame
extension ForgetPwdViewController {
    ///视图
    fileprivate func loadUI() {
        view.addSubview(forgetView)
    }
    
    ///布局
    fileprivate func loadFrame() {
        
    }
}


//MARK:- 事件
extension ForgetPwdViewController {
    ///获取验证码
    @objc func obtainCodeEvent() {
        print("获取验证码事件")
        let phoneString = forgetView.phoneTF.text!
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
    
    
    @objc func commitEvent() {
        print("注册事件")
        let phoneString = forgetView.phoneTF.text!
        if !Validate.feCheckMobile(phoneString) {
            view.makeToast("注册手机号不合法", position: .center)
            return
        }
        
        let codeString = forgetView.codeTF.text!
        if codeString.count == 0 {
            view.makeToast("验证码不能为空", position: .center)
            return
        }
        
        let pwdString = forgetView.pwdTF.text!
        if pwdString.count == 0 {
            view.makeToast("密码不能为空", position: .center)
            return
        }
        
        let params = ["phone": phoneString, "pwd": pwdString, "verification_code": codeString]
        loginProvider.request(.forgetpwdAPI(params: params)) { [weak self](result) in
            switch result {
            case .success(let res):
                let jsonStr = String.init(data: res.data, encoding: .utf8)
                if let model = BaseModel.deserialize(from: jsonStr) {
                    if model.code == 200 {
                        self?.navigationController?.popViewController(animated: true)
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
