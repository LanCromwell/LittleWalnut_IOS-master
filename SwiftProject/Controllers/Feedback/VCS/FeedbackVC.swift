//
//  FeedbackVC.swift
//  SwiftProject
//
//  Created by 方新俊 on 2019/9/7.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit

class FeedbackVC: BaseViewController,UITextViewDelegate {

    ///背景
    lazy var bgImageV: UIImageView = {
        let imageV = UIImageView()
        imageV.frame = CGRect.init(x: 12*kWIDTHBASE, y: 5*kWIDTHBASE, width: kScreenWidth - 24*kWIDTHBASE, height: 148*kWIDTHBASE)
        imageV.image = UIImage.init(named: "shadow_bg")
        imageV.isUserInteractionEnabled = true
        return imageV
    }()
    // 输入框
    lazy var inputTextView : UITextView = {
        let textView =  UITextView()
        textView.font = UIFont.font(size: 11, weight: .medium)
        textView.delegate = self
        textView.backgroundColor = UIColor.clear
        return textView
    }()
    
    // 输入框提示语
    lazy var placeholderLabel : UILabel = {
        let label =  UILabel()
        label.font = UIFont.font(size: 11, weight: .medium)
        label.textColor = UIColor.hexInt(0x999999)
        label.text = "留下微信号以及您的意见，可以让我们提供更好的服务，意见如被采纳我们将提供小红包奖励。"
        label.numberOfLines = 0
        return label
    }()
    
    // 提交按钮
    lazy var commitBnt : UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(commitBtnClick), for: .touchUpInside)
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btn.backgroundColor = UIColor.hexInt(0xFF973E)
        btn.titleLabel?.font = UIFont.font(size: 15*kWIDTHBASE, weight: .medium)
        btn.layer.cornerRadius = 22*kWIDTHBASE
        btn.clipsToBounds = true
        btn.setTitle("提交", for: UIControl.State.normal)
        btn.tag = 101;
        return btn
    }()
    // 底部
    lazy var bottomView: FeedbackBottomanView = {
        let infoView = FeedbackBottomanView.loadFromNib()
        return infoView as! FeedbackBottomanView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavUI()
        loadUI()
        loadFrame()
        view.backgroundColor = UIColor.white
        
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


extension FeedbackVC {
    // 导航条
    func setNavUI() {
        self.navigationView.isHidden = false
        self.navigationView.titleLabel.text = "意见反馈"
        self.navigationView.titleLabel.textColor = UIColor.hexInt(0x313131)
        self.navigationView.backgroundColor = UIColor.white
        self.navigationView.leftButton.isHidden = false       
        self.navigationView.leftButton.setImage(UIImage.init(named: "back-icon"), for: .normal)
        self.navigationView.bottomLine.isHidden = false
    }
    
    func loadUI() {
        view.addSubview(bgImageV)
        bgImageV.addSubview(inputTextView)
        bgImageV.addSubview(placeholderLabel)
        view.addSubview(commitBnt)
        view.addSubview(bottomView)
    }
    
    func loadFrame() {
       
        bgImageV.snp.makeConstraints { (make) in
            make.left.equalTo(12*kWIDTHBASE)
            make.right.equalTo(-12*kWIDTHBASE)
            make.top.equalTo(navigationView.snp.bottom).offset(4*kWIDTHBASE)
            make.height.equalTo(148*kWIDTHBASE)
        }
        
        inputTextView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(10*kWIDTHBASE)
            make.right.bottom.equalToSuperview().offset(-10*kWIDTHBASE)
        }
        
        placeholderLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(inputTextView).offset(5*kWIDTHBASE)
            make.top.equalTo(inputTextView).offset(5*kWIDTHBASE)
        }
        
        commitBnt.snp.makeConstraints { (make) in
            make.left.equalTo(28*kWIDTHBASE)
            make.right.equalTo(-28*kWIDTHBASE)
            make.top.equalTo(bgImageV.snp.bottom).offset(30*kWIDTHBASE)
            make.height.equalTo(44*kWIDTHBASE)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(-20*kWIDTHBASE - kBottomSpaceHeight)
            make.height.equalTo(148*kWIDTHBASE)
        }
        
    }
    
}

extension FeedbackVC {
    // 提交按钮
    @objc func commitBtnClick(btn : UIButton) {
        print(btn.tag)
        if inputTextView.text.count <= 0{
            view.makeToast("请填写您的宝贵意见和建议", position: .center)
            return
        }
        let model = UserInfo.default.findUserInfo()
        settingProvider.request(FXJ_SettingAPI.feedbackCreateAPI(user_id: model!.id!, feedback_content: inputTextView.text)) { [weak self](result) in
            
            switch result {
            case .success(let res) :
                let jsonStr = String.init(data: res.data, encoding: .utf8)
                if let model = BaseModel.deserialize(from: jsonStr) {
                    if model.code == 200 {
                        print(model.data as Any)
                        self?.view.makeToast(model.msg, position: .center)
                        self?.navigationController?.popToRootViewController(animated: true)
                    } else {
                        self?.view.makeToast(model.msg, position: .center)
                    }
                }
                
            case .failure(let error):
                self?.view.makeToast(error.localizedDescription, position: .center)
            }
            
        }
        
        
    }
    //MARK:- UITextViewDelegate
    func textViewDidChange(_ textView: UITextView) {
        print("text ====> " + textView.text)
        if textView.text.count <= 0 {
            placeholderLabel.isHidden = false
        }else{
            placeholderLabel.isHidden = true
        }
    }
    
}
