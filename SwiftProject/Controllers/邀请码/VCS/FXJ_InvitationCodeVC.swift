//
//  FXJ_InvitationCodeVC.swift
//  SwiftProject
//
//  Created by 方新俊 on 2019/9/7.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit

class FXJ_InvitationCodeVC: BaseViewController {
    
      var userInfo: UserInfo?
    
    // 背景图片
    lazy var bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "邀请有礼")
//        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        return imageView
    }()
    
    // 邀请码
    lazy var invitationCodeLabel: UIButton = {
        let btn = UIButton()
        
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btn.backgroundColor = UIColor.clear
        btn.titleLabel?.font = UIFont.font(size: 12*kWIDTHBASE, weight: .medium)
//        btn.setTitle("我的邀请码:00HZ", for: UIControl.State.normal)
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.layer.cornerRadius = 12*kWIDTHBASE
        btn.clipsToBounds = true
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.borderWidth = 1
        return btn
    }()
    // 复制按钮
    lazy var copyBtn: UIButton = {
        let btn = UIButton()
        
        btn.addTarget(self, action: #selector(shareBtnClick), for: .touchUpInside)
//        btn.setTitleColor(UIColor.red, for: UIControl.State.normal)
//        btn.backgroundColor = UIColor.white
//        btn.titleLabel?.font = UIFont.font(size: 12*kWIDTHBASE, weight: .medium)
//        btn.setTitle("复制", for: UIControl.State.normal)
        btn.setImage(UIImage.init(named: "copyWhite"), for: .normal)
        btn.tag = 104
//        btn.layer.cornerRadius = 10*kWIDTHBASE
//        btn.clipsToBounds = true
        return btn
    }()
    
    // 分享View
    lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    // 微信
    lazy var oneBtn: UIButton = {
        let btn = DryImageTitleButton()
        btn.mode = .imageTop
        btn.space = 5
        btn.addTarget(self, action: #selector(shareBtnClick), for: .touchUpInside)
        btn.setTitleColor(UIColor.hexInt(0xdddddd), for: UIControl.State.normal)
//        btn.backgroundColor = UIColor.hexInt(0xFF973E)
        btn.titleLabel?.font = UIFont.font(size: 12*kWIDTHBASE, weight: .medium)
        btn.setTitle("微信", for: UIControl.State.normal)
        btn.setImage(UIImage.init(named: "微信"), for: .normal)
        btn.tag = 101;
        return btn
    }()
    // 朋友圈
    lazy var twoBtn: UIButton = {
        let btn = DryImageTitleButton()
        btn.mode = .imageTop
        btn.space = 5
        btn.addTarget(self, action: #selector(shareBtnClick), for: .touchUpInside)
        btn.setTitleColor(UIColor.hexInt(0xdddddd), for: UIControl.State.normal)
//        btn.backgroundColor = UIColor.hexInt(0xFF973E)
        btn.titleLabel?.font = UIFont.font(size: 12*kWIDTHBASE, weight: .medium)
        btn.setTitle("朋友圈", for: UIControl.State.normal)
        btn.setImage(UIImage.init(named: "朋友圈"), for: .normal)
        btn.tag = 102;
        return btn
    }()
    
    // qq
    lazy var threeBtn: UIButton = {
        let btn = DryImageTitleButton()
        btn.mode = .imageTop
        btn.space = 5
        btn.addTarget(self, action: #selector(shareBtnClick), for: .touchUpInside)
        btn.setTitleColor(UIColor.hexInt(0xdddddd), for: UIControl.State.normal)
//        btn.backgroundColor = UIColor.hexInt(0xFF973E)
        btn.titleLabel?.font = UIFont.font(size: 12*kWIDTHBASE, weight: .medium)
        btn.setTitle("QQ空间", for: UIControl.State.normal)
        btn.setImage(UIImage.init(named: "QQ空间"), for: .normal)
        btn.tag = 103;
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setNavUI()
        loadUI()
        loadFrame()
        
        let code = userInfo?.invite_info?.invitation_code
        print(code!)
        let codeStr = "我的邀请码: \(code!)"
        invitationCodeLabel.setTitle(codeStr, for: UIControl.State.normal)
        
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

extension FXJ_InvitationCodeVC {
    // 导航条
    func setNavUI() {
        self.navigationView.isHidden = false
        self.navigationView.titleLabel.text = "我的邀请码"
        self.navigationView.titleLabel.textColor = UIColor.hexInt(0x313131)
        self.navigationView.backgroundColor = UIColor.white
        self.navigationView.leftButton.isHidden = false
        self.navigationView.leftButton.setImage(UIImage.init(named: "back-icon"), for: .normal)
        self.navigationView.bottomLine.isHidden = false
    }
    
    func loadUI() {
       view.addSubview(bgImageView)
        view.addSubview(bottomView)
        view.addSubview(invitationCodeLabel)
        view.addSubview(copyBtn)
        bottomView.addSubviews([oneBtn,twoBtn,threeBtn])
    }
    
    func loadFrame() {
        // 邀请码
        invitationCodeLabel.snp.makeConstraints { (make) in
            make.height.equalTo(24*kWIDTHBASE)
            make.width.equalTo(135*kWIDTHBASE)
            make.centerX.equalToSuperview().offset(-25*kWIDTHBASE)
            make.centerY.equalToSuperview().offset(60*kWIDTHBASE)
        }
        // 复制
        copyBtn.snp.makeConstraints { (make) in
            make.height.equalTo(24*kWIDTHBASE)
            make.width.equalTo(50*kWIDTHBASE)
            make.centerY.equalTo(invitationCodeLabel)
            make.left.equalTo(invitationCodeLabel.snp.right).offset(-10*kWIDTHBASE)
        }
        
        bgImageView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(navigationView.snp.bottom)
            make.bottom.equalToSuperview().offset(-kBottomSpaceHeight)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.bottom.equalTo(bgImageView)
            make.left.equalTo(50*kWIDTHBASE)
            make.right.equalTo(-50*kWIDTHBASE)
            make.height.equalTo(70*kWIDTHBASE)
        }
        bottomView.layoutIfNeeded()
        oneBtn.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(bottomView.ly_width/3)
        }
        // 朋友圈
        twoBtn.snp.makeConstraints { (make) in
            make.top.bottom.centerX.equalToSuperview()
//            make.centerX.equalTo(navigationView)
            make.width.equalTo(bottomView.ly_width/3)
        }
        // QQ
        threeBtn.snp.makeConstraints { (make) in
            make.right.top.bottom.equalToSuperview()
            make.width.equalTo(bottomView.ly_width/3)
        }
    }
    
}

extension FXJ_InvitationCodeVC {
    
   @objc func shareBtnClick(sender : UIButton) {
        print(sender.tag)
    switch sender.tag {
      case 101: // 微信
        shareEvent(platformType: UMSocialPlatformType.wechatSession)
        break
      case 102: // 朋友圈
        shareEvent(platformType: UMSocialPlatformType.wechatTimeLine)
        break
      case 103: // qq空间
        shareEvent(platformType: UMSocialPlatformType.qzone)
        break
    case 104: // 复制
      let pasteboard = UIPasteboard.general
      pasteboard.string = invitationCodeLabel.title(for: UIControl.State.normal);
      view.makeToast("复制成功", position: .center)
        break
    default:
        break
        
    }
    
    }
    
    @objc func shareEvent(platformType:UMSocialPlatformType) {
        let userInfo = UserInfo.default.findUserInfo()
        guard let invite_info = userInfo?.invite_info else { return }
            //创建分享消息对象
            let messageObject = UMSocialMessageObject()
            let thumbURL = "https://mamaucan.oss-cn-beijing.aliyuncs.com/xiaohetao.png"
            //分享消息对象设置分享内容对象
            let shareObject = UMShareWebpageObject.shareObject(withTitle: invite_info.title ?? "", descr: invite_info.description ?? "", thumImage: thumbURL)
            //设置网页地址
            shareObject?.webpageUrl = invite_info.href
            messageObject.shareObject = shareObject
            //调用分享接口
            UMSocialManager.default().share(to: platformType,
                                            messageObject: messageObject,
                                            currentViewController: self,
                                            completion: { (data, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
            })
        
    }
    
}
