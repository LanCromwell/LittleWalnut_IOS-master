//
//  SettingSecondViewController.swift
//  SwiftProject
//
//  Created by YX on 2019/8/28.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import HWPopController

class SettingSecondViewController: BaseViewController {
    // 当前选中的按钮
    var currentBtn : UIButton = UIButton()
    var child_birthday : String = ""
    var isRegisterEnter : Bool = false

    // 数据源
    var dataArray : [Dictionary<String, Any>] = [Dictionary<String, Any>]()
    
    lazy var headView: SettingHeadView = {
        let headV = SettingHeadView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kStatusHeight + 200))
//        headV.callback = {
//            self.nextStep()
//        }
        headV.setTitleLableText(text: "选择身份")
        headV.setSecondIconWithImage(imageName: "second_selected")
        headV.setSecondLabelTextColorWithColor(color: UIColor.hexInt(0x999999))
        return headV
    }()
    // 妈妈按钮
    lazy var topBtn:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: "second_woman_normal"), for: UIControl.State.normal)
        btn.setImage(UIImage.init(named: "second_woman"), for: UIControl.State.selected)

        btn.addTarget(self, action: #selector(topBtnClick(button:)), for: .touchUpInside)
        btn.layer.cornerRadius = 45*kWIDTHBASE
        btn.clipsToBounds = true
        btn.layer.borderColor = UIColor.hexInt(0xFF6B65).cgColor
        btn.tag = 101;
//        btn.setTitleColor(UIColor.red, for: UIControl.State.normal)
//        btn.backgroundColor = UIColor.purple
//        btn.titleLabel?.font = UIFont.font(size: 15*kWIDTHBASE, weight: .regular)
        return btn
    }()
    
    lazy var topTitle: UILabel = {
        let lab = UILabel.init()
        lab.text = "我是准妈/妈妈"
        lab.textColor = UIColor.init(r: 153, g: 153, b: 153)
        lab.font = UIFont.font(size: 15*kWIDTHBASE, weight: .regular)
        lab.textAlignment = .center
        lab.adjustsFontSizeToFitWidth = true
        return lab
    }()
     // 爸爸按钮
    lazy var bottomBtn:UIButton = {
        let btn = UIButton()
//        btn.setBackgroundImage(UIImage.init(named: "second_man"), for: UIControl.State.normal)
        btn.setImage(UIImage.init(named: "second_man_normal"), for: UIControl.State.normal)
        btn.setImage(UIImage.init(named: "second_man"), for: UIControl.State.selected)
        btn.addTarget(self, action: #selector(bottomBtnClick(button:)), for: .touchUpInside)
//        btn.setTitleColor(UIColor.green, for: UIControl.State.normal)
//        btn.titleLabel?.font = UIFont.font(size: 15*kWIDTHBASE, weight: .regular)
        btn.layer.cornerRadius = 45*kWIDTHBASE
        btn.clipsToBounds = true
        btn.layer.borderColor = UIColor.hexInt(0xFF973E).cgColor
        btn.tag = 102;
        return btn
    }()
    
    //
    lazy var bottomTitile: UILabel = {
        let lab = UILabel.init()
        lab.text = "我是准爸/爸爸"
        lab.textColor = UIColor.init(r: 153, g: 153, b: 153)
        lab.font = UIFont.font(size: 15*kWIDTHBASE, weight: .regular)
        lab.textAlignment = .center
        lab.adjustsFontSizeToFitWidth = true
        return lab
    }()
    
     ///祖父母
    lazy var grandparentBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("我是祖父母", for: UIControl.State.normal)
//        btn.setImage(UIImage.init(named: "second_man"), for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(grandparentsBtnClick(button:)), for: .touchUpInside)
        btn.setTitleColor(UIColor.hexInt(0xFF973E), for: UIControl.State.selected)
        btn.setTitleColor(UIColor.hexInt(0x999999), for: UIControl.State.normal)
        btn.titleLabel?.font = UIFont.font(size: 15*kWIDTHBASE, weight: .regular)
        btn.tag = 103;
        return btn
    }()
    
    ///描述
    lazy var descLab: UILabel = {
        let lab = UILabel.init()
        lab.text = "完善以上信息，获取更多精准内容"
        lab.textColor = UIColor.init(r: 153, g: 153, b: 153)
        lab.font = UIFont.font(size: 12, weight: .regular)
        lab.textAlignment = .center
        return lab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         let userinfo = UserInfo.default.findUserInfo()
        let role_id = Int(userinfo?.role_id ?? "")
        switch role_id {
        case 1:
            topBtn.isSelected = true;
            break
        case 2:
            bottomBtn.isSelected = true;
             break
        case 3:
             grandparentBtn.isSelected = true
             break
        default:
             break
        }
        
        loadUI()
        loadFrame()
//        roleListRequest()
    }
}

extension SettingSecondViewController {
    
    func loadUI() {
        self.view.addSubviews(headView)
        view.addSubview(topBtn)
        view.addSubview(topTitle)
        view.addSubview(bottomBtn)
        view.addSubview(bottomTitile)
        view.addSubview(grandparentBtn)
        view.addSubview(descLab)
    }
    
    func loadFrame() {
      
        topBtn.snp.makeConstraints { (make) in
            make.top.equalTo(headView.snp.bottom).offset(28*kWIDTHBASE)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 90*kWIDTHBASE, height: 90*kWIDTHBASE))
        }
        
        topTitle.snp.makeConstraints { (make) in
            make.top.equalTo(topBtn.snp.bottom)
            make.left.right.equalTo(topBtn)
            make.height.equalTo(20*kWIDTHBASE)
        }
        
        bottomBtn.snp.makeConstraints { (make) in
            make.top.equalTo(topTitle.snp.bottom).offset(28*kWIDTHBASE)
            make.size.centerX.equalTo(topBtn)
        }
        
        bottomTitile.snp.makeConstraints { (make) in
            make.top.equalTo(bottomBtn.snp.bottom)
            make.left.right.equalTo(bottomBtn)
            make.height.equalTo(20*kWIDTHBASE)
        }
        
        grandparentBtn.snp.makeConstraints { (make) in
            make.top.equalTo(bottomTitile.snp.bottom).offset(48*kWIDTHBASE)
            make.left.right.equalToSuperview()
            make.height.equalTo(20*kWIDTHBASE)
        }
        
        descLab.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-40*kWIDTHBASE)
            make.left.right.equalToSuperview()
            make.height.equalTo(20*kWIDTHBASE)
        }
    }
}

extension SettingSecondViewController{
    
    func nextStep() {
        print("currentBtn = \(currentBtn.tag - 100)")
        let thirdVC = SettingThirdViewController()
        thirdVC.role_id = "\(currentBtn.tag - 100)"
        thirdVC.isRegisterEnter = self.isRegisterEnter
        thirdVC.child_birthday = self.child_birthday
        navigationController?.pushViewController(thirdVC, animated: true)
    }
    
    // 妈妈
    @objc func topBtnClick(button : UIButton) { // 0x7fc32ccbb180
        button.isSelected = !button.isSelected

        topBtn.layer.borderWidth = 1;
        bottomBtn.layer.borderWidth = 0;
        grandparentBtn.isSelected = false
        topTitle.textColor = UIColor.hexInt(0xFF973E)
        bottomTitile.textColor = UIColor.hexInt(0x999999)
        currentBtn = button;
        self.nextStep()
    }
    // 爸爸
    @objc func bottomBtnClick(button : UIButton) { // 0x7fc32cc308b0
        button.isSelected = !button.isSelected

        bottomBtn.layer.borderWidth = 1;
        topBtn.layer.borderWidth = 0;
        grandparentBtn.isSelected = false
        bottomTitile.textColor = UIColor.hexInt(0xFF973E)
        topTitle.textColor = UIColor.hexInt(0x999999)
        currentBtn = button;
        self.nextStep()
    }
    // 祖父母
    @objc func grandparentsBtnClick(button : UIButton) { // 0x7fc32cceb460
        button.isSelected = !button.isSelected
        topBtn.layer.borderWidth = 0;
        bottomBtn.layer.borderWidth = 0;
        currentBtn = button;
        self.nextStep()
    }
    
    // 获取角色列表
    func roleListRequest(){
        let model = UserInfo.default.findUserInfo()
        settingProvider.request(FXJ_SettingAPI.roleListAPI(phone: model!.phone!, pwd: "")) { [weak self](result) in
            switch result {
            case .success(let res):
                let jsonStr = String.init(data: res.data, encoding: .utf8)
                if let model = BaseModel.deserialize(from: jsonStr) {
                    if model.code == 200 {
                        print(model.data as Any)
                        self?.dataArray = model.data as! [Dictionary<String, Any>];
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
