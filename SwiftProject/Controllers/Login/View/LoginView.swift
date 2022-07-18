//
//  LoginView.swift
//  SwiftProject
//
//  Created by YX on 2019/7/25.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit
import SnapKit

class LoginView: UIView {
    
    ///容器
    lazy var contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()
    
//    ///scrollView
//    lazy var scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.showsVerticalScrollIndicator =  false
//        scrollView.showsHorizontalScrollIndicator = false
//        return scrollView
//    }()
    
    ///标题
    lazy var titleLab: UILabel = {
        let lab = UILabel.init()
        lab.numberOfLines = 0
        lab.text = "用户登录"
        lab.textAlignment = .center
        lab.textColor = Color_019
        lab.font = UIFont.font(size: 20 * kWIDTHBASE, weight: .semibold)
        return lab
    }()
    
    ///手机输入框
    lazy var phoneTF: UITextField = {
        let inputTF = UITextField()
        inputTF.textColor = Color_019
        
//        if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 13.0) {
//                   _searchView.searchTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索你喜欢的商品" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14*WIDTHBASE],NSForegroundColorAttributeName:[UIColor whiteColor]}];
//                       _searchView.searchTextField.backgroundColor = [UIColor clearColor];
//        }
        
        if (UIDevice.current.systemVersion as NSString).floatValue >= 13.0 {
            inputTF.attributedPlaceholder = NSAttributedString.init(string: "请输入手机号", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor : Color_100])
            
            
        }else{
            inputTF.setValue(UIFont.font(size: 15, weight: .regular) ,forKeyPath: "_placeholderLabel.font")
                 inputTF.setValue(Color_100, forKeyPath: "_placeholderLabel.textColor")
            inputTF.placeholder = "请输入手机号"

        }
        
     
        
        
        
        inputTF.font = UIFont.font(size: 15, weight: .regular)
        inputTF.clearButtonMode = .whileEditing
        return inputTF
    }()
    
    ///手机输入框下划线
    lazy var phoneUnderLine: UIView = {
        let lineV = UIView.init()
        lineV.backgroundColor = Color_085
        return lineV
    }()
    
    ///密码输入框
    lazy var pwdTF: UITextField = {
        let inputTF = UITextField()
        inputTF.textColor = Color_019
        if (UIDevice.current.systemVersion as NSString).floatValue >= 13.0 {
            inputTF.attributedPlaceholder = NSAttributedString.init(string: "请输入验证码", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor : Color_100])
            
            
        }else{
            
            inputTF.setValue(UIFont.font(size: 15, weight: .regular) ,forKeyPath: "_placeholderLabel.font")
            inputTF.setValue(Color_100, forKeyPath: "_placeholderLabel.textColor")
            inputTF.placeholder = "请输入验证码"
        }
        inputTF.font = UIFont.font(size: 15, weight: .regular)
        inputTF.clearButtonMode = .whileEditing
        return inputTF
    }()
    
    
    ///密码输入框下划线
    lazy var pwdUnderLine: UIView = {
        let lineV = UIView.init()
        lineV.backgroundColor = Color_085
        return lineV
    }()
    
    
    
    ///手机号
    lazy var phoneView: MTInputView = {
        let phoneV = MTInputView.init(frame: CGRect.zero)
        phoneV.inputTF.placeholder = "请输入手机号"
        return phoneV
    }()
    
    ///登录密码
    lazy var pwdView: MTInputView = {
        let pwdV = MTInputView.init(frame: CGRect.zero)
        pwdV.inputTF.placeholder = "请输入验证码"
        pwdV.inputTF.isSecureTextEntry = true
        return pwdV
    }()
    
    ///验证码Button
       lazy var codeBtn: GSCaptchaButton = {
           let button = GSCaptchaButton.init(frame: CGRect.init(x: 0, y: 0, width: 75  * kWIDTHBASE, height: 25 * kWIDTHBASE))
           button.backgroundColor = Color_100
           button.setTitle("获取验证码", for: .normal)
           button.setTitleColor(UIColor.white, for: .normal)
           button.setTitleColor(UIColor.gray, for: .disabled)
           button.titleLabel?.font = UIFont.font(size: 12 * kWIDTHBASE, weight: .regular)
           button.maxSecond = 80
           button.addTarget(self, action: #selector(codeEvent), for: .touchUpInside)
           button.layer.cornerRadius = 12.5 * kWIDTHBASE
           button.layer.masksToBounds = true
           return button
       }()
    ///注册
    lazy var registerBtn: UIButton = {
        let button = UIButton()
        button.setTitle("立即注册", for: .normal)
        button.setTitleColor(Color_100, for: .normal)
        button.titleLabel?.font = UIFont.font(size: 12, weight: .regular)
        button.addTarget(self, action: #selector(registerEvent), for: .touchUpInside)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    ///忘记密码
    lazy var forgetBtn: UIButton = {
        let button = UIButton()
        button.setTitle("忘记密码", for: .normal)
        button.setTitleColor(Color_100, for: .normal)
        button.titleLabel?.font = UIFont.font(size: 12, weight: .regular)
        button.addTarget(self, action: #selector(forgetpwdEvent), for: .touchUpInside)
        button.contentHorizontalAlignment = .right
        return button
    }()
    
    ///登录控件
    lazy var loginBtn: UIButton = {
        let button = UIButton()
        button.setTitle("登录", for: .normal)
//        button.setBackgroundImage(UIImage.init(named: "login_bg"), for: .normal)
        button.backgroundColor = Color_100
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.font(size: 15, weight: .medium)
//        button.addTarget(self, action: #selector(loginEvent), for: .touchUpInside)
        button.layer.cornerRadius = 22.0 * kWIDTHBASE
        button.layer.masksToBounds = true
        return button
    }()
    

    
    ///三方登录
    lazy var thirdView: UIView = {
        let tView = UIView.init()
        return tView
    }()
    
    ///标题
    lazy var tipsLab: UILabel = {
        let lab = UILabel.init()
        lab.text = "第三方账号直接登录"
        lab.textAlignment = .center
        lab.textColor = UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        lab.font = UIFont.font(size: 12, weight: .regular)
        return lab
    }()

    ///QQ
    lazy var qqButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.init(named: "qq"), for: .normal)
        button.setImage(UIImage.init(named: "qq"), for: .highlighted)
        return button
    }()
    
    ///Weixin
    lazy var weixinButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.init(named: "weixin"), for: .normal)
        button.setImage(UIImage.init(named: "weixin"), for: .highlighted)
        return button
    }()
    
    
    ///协议
    lazy var agreementLab: UILabel = {
        let lab = UILabel.init()
        lab.text = "用户服务协议"
        lab.textAlignment = .center
        lab.textColor = Color_100
        lab.font = UIFont.font(size: 12, weight: .regular)
        lab.isUserInteractionEnabled = true
        return lab
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUI()
        loadFrame()
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    
    
}


//MARK:- 事件处理
extension LoginView {
    ///忘记密码
    @objc fileprivate func forgetpwdEvent() {
        let forgetVC = ForgetPwdViewController()
        self.ly_viewController?.navigationController?.pushViewController(forgetVC, animated: true)
    }
    
    ///验证码事件
       @objc fileprivate func codeEvent() {
           codeBtn.countdown = true
       }
    
    ///注册
    @objc fileprivate func registerEvent() {
        let registerVC = RegisterViewController()
        let loginVC = self.ly_viewController as! LoginViewController
        registerVC.operatorStr = loginVC.operatorStr
        registerVC.phone_brand = loginVC.phone_brand
        registerVC.phone_model = loginVC.phone_model
        self.ly_viewController?.navigationController?.pushViewController(registerVC, animated: true)
    }
    

}


//MARK:- UI & Frame
extension LoginView {
    ///添加子控件
    fileprivate func loadUI() {
        addSubview(contentView)
        contentView.addSubviews([titleLab, phoneTF, phoneUnderLine, pwdTF, pwdUnderLine, registerBtn,forgetBtn, loginBtn,thirdView,agreementLab,codeBtn])
        ///三方登录
        thirdView.addSubviews([tipsLab, qqButton, weixinButton])
        
    }
    
    ///布局
    fileprivate func loadFrame() {
        ///底层容器
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(85 * kWIDTHBASE)
            make.centerX.equalTo(contentView)
            make.left.equalTo(16)
        }
        
        phoneTF.snp.makeConstraints { (make) in
            make.left.equalTo(35)
            make.centerX.equalTo(contentView)
            make.height.equalTo(48 * kWIDTHBASE)
            make.top.equalTo(titleLab.snp.bottom).offset(35 * kWIDTHBASE)
        }
        
        phoneUnderLine.snp.makeConstraints { (make) in
            make.left.right.equalTo(phoneTF)
            make.height.equalTo(0.5)
            make.top.equalTo(phoneTF.snp.bottom)
        }
        
        
        pwdTF.snp.makeConstraints { (make) in
            make.left.right.equalTo(phoneTF)
            make.height.equalTo(48 * kWIDTHBASE)
            make.top.equalTo(phoneUnderLine.snp.bottom).offset(15 * kWIDTHBASE)
        }
        
        pwdUnderLine.snp.makeConstraints { (make) in
            make.left.right.equalTo(phoneTF)
            make.height.equalTo(0.5)
            make.top.equalTo(pwdTF.snp.bottom)
        }
        
        codeBtn.snp.makeConstraints { (make) in
                  make.size.equalTo(CGSize.init(width: 75 * kWIDTHBASE, height: 25 * kWIDTHBASE))
                  make.right.equalTo(contentView.snp.right).offset(-35 * kWIDTHBASE)
                  make.top.equalTo(phoneUnderLine.snp.bottom).offset((15 + (48 - 25)/2.0) * kWIDTHBASE)
        }
        
        registerBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 100 * kWIDTHBASE, height: 50 * kWIDTHBASE))
            make.top.equalTo(pwdUnderLine.snp.bottom).offset(0)
            make.left.equalTo(phoneTF.snp.left)
        }
        
        
        forgetBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 100 * kWIDTHBASE, height: 50 * kWIDTHBASE))
            make.top.equalTo(pwdUnderLine.snp.bottom).offset(0)
            make.right.equalTo(phoneTF.snp.right)
        }


        loginBtn.snp.makeConstraints { (make) in
            make.left.equalTo(35 * kWIDTHBASE)
            make.centerX.equalTo(contentView)
            make.top.equalTo(forgetBtn.snp.bottom).offset(50 * kWIDTHBASE)
            make.height.equalTo(44 * kWIDTHBASE)
        }
        
        agreementLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.bottom.equalTo(-(kBottomSpaceHeight + 15))
            make.height.equalTo(40 * kWIDTHBASE)
        }
        
        thirdView.snp.makeConstraints { (make) in
            make.bottom.equalTo(agreementLab.snp.top).offset(0)
            make.left.right.equalTo(0)
            make.height.equalTo(100 * kWIDTHBASE)
        }
        
        

        ///微信 QQ 都安装
        if (UMSocialManager.default()?.isSupport(.wechatSession))! && (UMSocialManager.default()?.isSupport(.QQ))! {
            tipsLab.snp.makeConstraints { (make) in
                make.centerX.equalTo(thirdView)
                make.top.equalTo(10)
            }


            weixinButton.snp.makeConstraints { (make) in
                make.size.equalTo(CGSize.init(width: 35, height: 35))
                make.centerX.equalTo(thirdView.snp.centerX).offset(40)
                make.top.equalTo(tipsLab.snp.bottom).offset(10)
            }

            qqButton.snp.makeConstraints { (make) in
                make.size.equalTo(CGSize.init(width: 35, height: 35))
                make.centerX.equalTo(thirdView.snp.centerX).offset(-40)
                make.top.equalTo(tipsLab.snp.bottom).offset(10)
            }
        }
        ///仅仅安装QQ
        else if !(UMSocialManager.default()?.isSupport(.wechatSession))! && (UMSocialManager.default()?.isSupport(.QQ))! {
            tipsLab.snp.makeConstraints { (make) in
                make.centerX.equalTo(thirdView)
                make.top.equalTo(10)
            }

            qqButton.snp.makeConstraints { (make) in
                make.size.equalTo(CGSize.init(width: 35, height: 35))
                make.centerX.equalTo(thirdView.snp.centerX)
                make.top.equalTo(tipsLab.snp.bottom).offset(10)
            }
        }

        ///仅仅安装微信
        else if !(UMSocialManager.default()?.isSupport(.wechatSession))! && (UMSocialManager.default()?.isSupport(.QQ))! {
            tipsLab.snp.makeConstraints { (make) in
                make.centerX.equalTo(thirdView)
                make.top.equalTo(10)
            }

            weixinButton.snp.makeConstraints { (make) in
                make.size.equalTo(CGSize.init(width: 35, height: 35))
                make.centerX.equalTo(thirdView.snp.centerX)
                make.top.equalTo(tipsLab.snp.bottom).offset(10)
            }
        }
        


       
        
    }
}
