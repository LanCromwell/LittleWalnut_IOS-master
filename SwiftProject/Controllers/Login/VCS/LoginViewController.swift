//
//  LoginViewController.swift
//  SwiftProject
//
//  Created by YX on 2019/7/20.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit
import SwiftyJSON
import MBProgressHUD
import RxSwift
import RxCocoa
import CoreTelephony
import Alamofire

class LoginViewController: BaseViewController {
    // 运营商信息
    var operatorStr : String?
    // 手机型号
    var phone_model : String?
    // 手机品牌
    var phone_brand : String?

    let disposeBag = DisposeBag()
    ///登录视图
    let loginView: LoginView = {
        let loginView = LoginView.init(frame: UIScreen.main.bounds)
        loginView.loginBtn.addTarget(self, action: #selector(loginEvent), for: .touchUpInside)
        loginView.qqButton.addTarget(self, action: #selector(qqLoginEvent), for: .touchUpInside)
        loginView.weixinButton.addTarget(self, action: #selector(weixinLoginEvent), for: .touchUpInside)
         loginView.codeBtn.addTarget(self, action: #selector(obtainCodeEvent), for: .touchUpInside)
        return loginView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        ///添加子视图
        loadUI()
        currentDeviceInfo()
        loginView.phoneTF.text = "17601026832"
        loginView.pwdTF.text = "6844"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }

    
    private func loadUI() {
        view.addSubview(loginView)
        loginView.agreementLab.rx.tapGesture.subscribeNext({ [weak self](tap) in
            self?.gotoWebView()
        }).disposed(by: disposeBag)
    }
    


}


///MARK:- 事件处理
extension LoginViewController {
    
    ///获取验证码
       @objc func obtainCodeEvent() {
           print("获取验证码事件")
           let phoneString = loginView.phoneTF.text!
           if !Validate.feCheckMobile(phoneString) {
               view.makeToast("手机号不合法", position: .center)
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
    
    //MARK:- 登录事件
    @objc func loginEvent() {
        
        view.endEditing(true)
        
        let phoneString = loginView.phoneTF.text!
        if !Validate.feCheckMobile(phoneString) {
            view.makeToast("注册手机号不合法", position: .center)

            return
        }
        
        
        let pwdString = loginView.pwdTF.text!
        if pwdString.count == 0 {
            view.makeToast("验证码不能为空", position: .center)
            return
        }
        
        loginProvider.request(.loginAPI(username: phoneString, pwd: pwdString, operatorInfo: operatorStr ?? "", phone_brand: phone_brand ?? "", phone_model: phone_model ?? "")) { [weak self](result) in
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
    
    
    //MARK:- QQ登录
    @objc func qqLoginEvent() {
        ///授权
        UMSocialManager.default()?.getUserInfo(with: .QQ, currentViewController: self, completion: { [weak self](result, error) in
            if error == nil {
                let userInfo = result as! UMSocialUserInfoResponse

                let uid = userInfo.uid ?? ""
                let iconurl = userInfo.iconurl ?? ""
                let name = userInfo.name ?? ""
                print("uid == \(uid)   iconurl == \(iconurl)  name == \(name)")
                self?.thridLogin(third_unique_id: uid, third_icon: iconurl, third_name: name, type: 2)
            }
        })
    }
    
    //MARK: - WeiXin登录
    @objc func weixinLoginEvent() {
        ///授权
        UMSocialManager.default()?.getUserInfo(with: .wechatSession, currentViewController: self, completion: { [weak self](result, error) in
            let userInfo = result as! UMSocialUserInfoResponse
            
            let uid = userInfo.uid ?? ""
            let iconurl = userInfo.iconurl ?? ""
            let name = userInfo.name ?? ""
            print("uid == \(uid)   iconurl == \(iconurl)  name == \(name)")
            self?.thridLogin(third_unique_id: uid, third_icon: iconurl, third_name: name, type: 1)
        })

    }
    
    
    //MARK:- 三方登录
    func thridLogin(third_unique_id: String, third_icon: String, third_name: String, type: Int) {
        loginProvider.request(.thridLoginAP(third_unique_id: third_unique_id, third_icon: third_icon, third_name: third_name, type: type, operatorInfo: operatorStr ?? "", phone_brand: phone_brand ?? "", phone_model: phone_model ?? "")) { [weak self](result) in
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
//                        GlobalUIManager.loadHomeVC()
                        let thridname = "xht"+userInfo!.id!
                       UMessage.setAlias(thridname, type: "xht_app") { (responseObject, error) in
                             print(responseObject as Any,error as Any);
                          }
                    } else {
                        ///未绑定
                        let registerVC = RegisterViewController()
                        registerVC.third_unique_id = third_unique_id
                        registerVC.third_icon = third_icon
                        registerVC.third_name = third_name
                        registerVC.type = type
                        self?.navigationController?.pushViewController(registerVC, animated: true)
                    }
                }
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - 遵循协议
    func gotoWebView() {
        let webView = WebViewController()
        webView.filePath = "http://www.mamaucan.com.cn/law"
        webView.navigationView.titleLabel.text = "用户协议"
        navigationController?.pushViewController(webView, animated: true)
    }
    
    ///去设置
    func gotoSettingVC() {
        let firstVC = SettingFirstViewController()
        firstVC.isRegisterEnter = true
        navigationController?.pushViewController(firstVC, animated: true)
    }
    
    //获取设备型号运营商信息 (给 operatorStr  phone_model  phone_brand 赋值)
    func currentDeviceInfo() {
        var manager: NetworkReachabilityManager?
        manager = NetworkReachabilityManager(host: "www.apple.com")
        
        manager?.listener = { status in
            
            if status == NetworkReachabilityManager.NetworkReachabilityStatus.notReachable {
                print("无网络链接")
                self.operatorStr = "无网络"
            }else
                
                if status == NetworkReachabilityManager.NetworkReachabilityStatus.reachable(.ethernetOrWiFi) {
                    self.operatorStr = "WIFI"
                }else
                    if status == NetworkReachabilityManager.NetworkReachabilityStatus.reachable(.wwan) {
                        print("数据网络")
                        //获取并输出运营商信息
                        let info = CTTelephonyNetworkInfo()
                        if let carrier = info.subscriberCellularProvider {
                            if carrier.carrierName != nil{
                                self.operatorStr = carrier.carrierName;
                            }else{
                                self.operatorStr = "WIFI"
                            }
                        }
                    }else if status == NetworkReachabilityManager.NetworkReachabilityStatus.unknown {
                        print("未知网络")
                        self.operatorStr = "未知网络"
            }
            print(self.operatorStr!)
            manager?.stopListening()
        }
        manager?.startListening()
        
        // 分割字符串
        let separatedStrings = self.deviceName
        let array : Array = separatedStrings.components(separatedBy: " ")
        print("\(array) ")
        if array.count > 1 {
            self.phone_brand = array[0]
            self.phone_model = array[1]
        }
        
//        print(self.phone_brand!)
//        print(self.phone_model!)

    }
   
    // 设备型号
    var deviceName: String {
        
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") {identifier, element  in
            guard let value = element.value as? Int8, value != 0 else {
                return identifier
            }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod1,1":  return "iPod Touch 1"
        case "iPod2,1":  return "iPod Touch 2"
        case "iPod3,1":  return "iPod Touch 3"
        case "iPod4,1":  return "iPod Touch 4"
        case "iPod5,1":  return "iPod Touch 5"
        case "iPod7,1":   return "iPod Touch 6"
            
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":  return "iPhone 4"
        case "iPhone4,1":  return "iPhone 4s"
        case "iPhone5,1":   return "iPhone 5"
        case  "iPhone5,2":  return "iPhone 5"
        case "iPhone5,3":  return "iPhone 5c"
        case "iPhone5,4":  return "iPhone 5c"
        case "iPhone6,1":  return "iPhone 5s"
        case "iPhone6,2":  return "iPhone 5s"
        case "iPhone7,2":  return "iPhone 6"
        case "iPhone7,1":  return "iPhone 6Plus"
        case "iPhone8,1":  return "iPhone 6s"
        case "iPhone8,2":  return "iPhone 6sPlus"
        case "iPhone8,4":  return "iPhone SE"
//        case "iPhone9,1":  return "国行、日版、港行iPhone 7"
//        case "iPhone9,2":  return "港行、国行iPhone 7 Plus"
//        case "iPhone9,3":  return "美版、台版iPhone 7"
//        case "iPhone9,4":  return "美版、台版iPhone 7 Plus"
        case "iPhone10,1","iPhone10,4":   return "iPhone 8"
        case "iPhone10,2","iPhone10,5":   return "iPhone 8Plus"
        case "iPhone10,3","iPhone10,6":   return "iPhone X"
        case "iPhone11,2" : return"iPhone XS"
        case"iPhone11,4" : return"iPhone XSMax"
        case"iPhone11,6" : return"iPhone XSMax"
        case"iPhone11,8" : return"iPhone XR"
        case "iPhone12,1" : return "iPhone 11"
        case "iPhone12,3" : return "iPhone 11Pro"
        case "iPhone12,5" : return "iPhone 11ProMax"


            
        case "iPad1,1":   return "iPad 1"
        case "iPad1,2":   return "iPad 3G"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":   return "iPad 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":  return "iPad Mini"
        case "iPad3,1", "iPad3,2", "iPad3,3":  return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":   return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":   return "iPad Air"
        case "iPad4,4", "iPad4,5", "iPad4,6":  return "iPad Mini2"
        case "iPad4,7", "iPad4,8", "iPad4,9":  return "iPad Mini3"
        case "iPad5,1", "iPad5,2":  return "iPad Mini4"
        case "iPad5,3", "iPad5,4":   return "iPad Air2"
        case "iPad6,3", "iPad6,4":  return "iPad Pro9.7"
        case "iPad6,7", "iPad6,8":  return "iPad Pro12.9"
        case "AppleTV2,1":  return "AppleTV 2"
        case "AppleTV3,1","AppleTV3,2":  return "AppleTV 3"
        case "AppleTV5,3":   return "AppleTV 4"
        case "i386", "x86_64":   return "Simulator 1"
        default:  return identifier
        }
    }
    
}


