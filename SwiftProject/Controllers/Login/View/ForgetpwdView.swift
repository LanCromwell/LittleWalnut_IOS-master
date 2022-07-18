//
//  ForgetpwdView.swift
//  SwiftProject
//
//  Created by YX on 2019/7/26.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit
import SnapKit

class ForgetpwdView: UIView {
    
    ///容器
    lazy var contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()
    
    ///scrollView
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator =  false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    ///返回按钮
    lazy var backButton: DryImageTitleButton = {
        let button = DryImageTitleButton()
        button.mode = .imageLeft
        button.space = 8
        button.setTitle("", for: .normal)
        button.setImage(UIImage.init(named: "back-icon"), for: .normal)
        button.addTarget(self, action: #selector(backEvent), for: .touchUpInside)
        return button
    }()
    
    ///标题
    lazy var titleLab: UILabel = {
        let lab = UILabel.init()
        lab.numberOfLines = 0
        lab.text = "修改密码"
        lab.textAlignment = .center
        lab.textColor = Color_019
        lab.font = UIFont.font(size: 20 * kWIDTHBASE, weight: .semibold)
        return lab
    }()
    
    ///手机输入框
    lazy var phoneTF: UITextField = {
        let inputTF = UITextField()
        inputTF.textColor = Color_019
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
    
    
    ///验证码输入框
    lazy var codeTF: UITextField = {
        let inputTF = UITextField()
        inputTF.textColor = Color_019
        
        if (UIDevice.current.systemVersion as NSString).floatValue >= 13.0 {
                   inputTF.attributedPlaceholder = NSAttributedString.init(string: "请输入密码", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor : Color_100])
                   
                   
        }else{
            inputTF.setValue(UIFont.font(size: 15, weight: .regular) ,forKeyPath: "_placeholderLabel.font")
            inputTF.setValue(Color_100, forKeyPath: "_placeholderLabel.textColor")
            inputTF.placeholder = "请输入验证码"
            
        }
        inputTF.font = UIFont.font(size: 15, weight: .regular)
        inputTF.clearButtonMode = .whileEditing
        return inputTF
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
    
    ///验证码下划线
    lazy var codeUnderLine: UIView = {
        let lineV = UIView.init()
        lineV.backgroundColor = Color_085
        return lineV
    }()
    
    ///密码输入框
    lazy var pwdTF: UITextField = {
        let inputTF = UITextField()
        inputTF.textColor = Color_019
        
        if (UIDevice.current.systemVersion as NSString).floatValue >= 13.0 {
                   inputTF.attributedPlaceholder = NSAttributedString.init(string: "请输入密码", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor : Color_100])
                   
                   
        }else{
            inputTF.setValue(UIFont.font(size: 15, weight: .regular) ,forKeyPath: "_placeholderLabel.font")
            inputTF.setValue(Color_100, forKeyPath: "_placeholderLabel.textColor")
            inputTF.placeholder = "请输入密码"
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
    
    
    ///注册控件
    lazy var commitBtn: UIButton = {
        let button = UIButton()
        button.setTitle("提交", for: .normal)
        button.backgroundColor = Color_100
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.font(size: 15, weight: .medium)
        //        button.addTarget(self, action: #selector(loginEvent), for: .touchUpInside)
        button.layer.cornerRadius = 22.0 * kWIDTHBASE
        button.layer.masksToBounds = true
        return button
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
extension ForgetpwdView {
    ///返回事件
    @objc fileprivate func backEvent() {
        self.ly_viewController?.navigationController?.popViewController(animated: true)
    }
    
    
    ///验证码事件
    @objc fileprivate func codeEvent() {
        codeBtn.countdown = true
    }
}


//MARK:- UI & Frame
extension ForgetpwdView {
    ///添加子控件
    fileprivate func loadUI() {
        addSubview(contentView)
        contentView.addSubview(scrollView)
        scrollView.addSubviews([backButton, titleLab, phoneTF, phoneUnderLine, codeTF, codeBtn, codeUnderLine, pwdTF, pwdUnderLine, commitBtn])
        
    }
    
    ///布局
    fileprivate func loadFrame() {
        ///底层容器
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
        
        backButton.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(kStatusHeight)
            make.size.equalTo(CGSize.init(width: 65 * kWIDTHBASE, height: 44 * kWIDTHBASE))
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(85 * kWIDTHBASE)
            make.centerX.equalTo(scrollView)
            make.left.equalTo(16 * kWIDTHBASE)
        }
        
        phoneTF.snp.makeConstraints { (make) in
            make.left.equalTo(35 * kWIDTHBASE)
            make.centerX.equalTo(scrollView)
            make.height.equalTo(48 * kWIDTHBASE)
            make.top.equalTo(titleLab.snp.bottom).offset(35 * kWIDTHBASE)
        }
        
        phoneUnderLine.snp.makeConstraints { (make) in
            make.left.right.equalTo(phoneTF)
            make.height.equalTo(0.5)
            make.top.equalTo(phoneTF.snp.bottom)
        }
        
        codeBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 75 * kWIDTHBASE, height: 25 * kWIDTHBASE))
            make.right.equalTo(contentView.snp.right).offset(-35 * kWIDTHBASE)
            make.top.equalTo(phoneUnderLine.snp.bottom).offset((15 + (48 - 25)/2.0) * kWIDTHBASE)
        }
        
        codeTF.snp.makeConstraints { (make) in
            make.left.equalTo(35 * kWIDTHBASE)
            make.right.equalTo(codeBtn.snp.left).offset(-10  * kWIDTHBASE)
            make.height.equalTo(48 * kWIDTHBASE)
            make.top.equalTo(phoneUnderLine.snp.bottom).offset(15 * kWIDTHBASE)
        }
        
        
        codeUnderLine.snp.makeConstraints { (make) in
            make.left.right.equalTo(phoneTF)
            make.height.equalTo(0.5)
            make.top.equalTo(codeTF.snp.bottom)
        }
        
        
        pwdTF.snp.makeConstraints { (make) in
            make.left.equalTo(35 * kWIDTHBASE)
            make.centerX.equalTo(scrollView)
            make.height.equalTo(48 * kWIDTHBASE)
            make.top.equalTo(codeUnderLine.snp.bottom).offset(15 * kWIDTHBASE)
        }
        
        pwdUnderLine.snp.makeConstraints { (make) in
            make.left.right.equalTo(phoneTF)
            make.height.equalTo(0.5)
            make.top.equalTo(pwdTF.snp.bottom)
        }
        
        
        commitBtn.snp.makeConstraints { (make) in
            make.left.equalTo(35 * kWIDTHBASE)
            make.centerX.equalTo(contentView)
            make.top.equalTo(pwdUnderLine.snp.bottom).offset(50 * kWIDTHBASE)
            make.height.equalTo(44 * kWIDTHBASE)
        }
        
    
    }
}


