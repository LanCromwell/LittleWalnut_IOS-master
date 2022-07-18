//
//  SettingThirdViewController.swift
//  SwiftProject
//
//  Created by YX on 2019/8/28.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit

class SettingThirdViewController: BaseViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    //生日
    var child_birthday : String = ""
    // 角色 (1妈妈 2爸爸 3祖父母)
    var role_id :String = ""
    var isRegisterEnter : Bool = false

    
    // 数据源
    var dataArray : [Dictionary<String, Any>] = [Dictionary<String, Any>]()
    var currentSelectedStr = Dictionary<String, Any>()
    
    lazy var headView: SettingHeadView = {
        let headV = SettingHeadView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kStatusHeight + 200))
//        headV.callback = {
//            self.nextStep()
//        }
        headV.nextBtn.setTitle("完成", for: UIControl.State.normal)
        headV.setTitleLableText(text: "选择身份")
        headV.setSecondIconWithImage(imageName: "second_selected")
        headV.setSecondLabelTextColorWithColor(color: UIColor.hexInt(0x999999))
        headV.setThirdHeaderViewData(text: "设置状态", imageName: "yuyan", color: UIColor.hexInt(0x999999))
        return headV
    }()
    
    // 标题
    lazy var leftTitleLabel: UILabel = {
        let lab = UILabel.init()
        lab.text = "语言设定"
        lab.textColor = UIColor.hexInt(0x313131)
        lab.font = UIFont.font(size: 15*kWIDTHBASE, weight: .regular)
        return lab
    }()
    // 普通话
    lazy var rightBtn:DryImageTitleButton = {
        let btn = DryImageTitleButton()
        btn.mode = .imageRight
        btn.space = 5
        btn.setTitle("普通话", for: UIControl.State.normal)
        btn.setTitleColor(UIColor.hexInt(0x999999), for: UIControl.State.normal)
        btn.setImage(UIImage.init(named: "rightBack"), for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(rightBtnClick), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.font(size: 15*kWIDTHBASE, weight: .regular)
//        btn.backgroundColor = UIColor.orange
        btn.contentHorizontalAlignment = .right
        return btn
    }()
    // 黑线
    lazy var lineLabel: UILabel = {
        let lab = UILabel.init()
        lab.backgroundColor = UIColor.hexInt(0xD8D8D8)
        return lab
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
    
    ///选择器
    lazy var pickerView: UIPickerView = {
      let picker = UIPickerView()
        //delegate设为自己
        picker.delegate = self
        //DataSource设为自己
        picker.dataSource = self
//        picker.backgroundColor = UIColor.orange
        //设置PickerView默认值
//        picker.selectRow(0, inComponent: 0, animated: true)
        return picker
    }()
    
    ///确定
    lazy var doneBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle("完成", for: .normal)
        btn.setTitleColor(UIColor.hexInt(0xFF973E), for: .normal)
        btn.titleLabel?.font = UIFont.font(size: 15, weight: .regular)
        btn.addTarget(self, action: #selector(getPickerViewValue), for: .touchUpInside)
        btn.contentHorizontalAlignment = .right
        return btn
    }()
    
    ///选择器背景view
    lazy var pickerViewBgView: UIView = {
        let bgView = UIView()
        bgView.setCornerRadius = 8
        bgView.clipsToBounds = true
        bgView.layer.borderColor = UIColor.hexInt(0xf6f6f6).cgColor
        bgView.layer.borderWidth = 1
        bgView.backgroundColor = UIColor.white
        bgView.addSubview(pickerView)
        bgView.addSubview(doneBtn)
        
        pickerView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(214*kWIDTHBASE)
        }
        doneBtn.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.right.equalTo(-26*kWIDTHBASE)
            make.bottom.equalTo(pickerView.snp.top)
        }
        return bgView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        loadUI()
        loadFrame()
        loadLanguageListRequest()
    }
}


extension SettingThirdViewController {
    func loadUI() {
        self.view.addSubviews(headView)
        view.addSubview(rightBtn)
        view.addSubview(leftTitleLabel)
        view.addSubview(lineLabel)
        view.addSubview(descLab)
        
        let userinfo = UserInfo.default.findUserInfo()
       rightBtn.setTitle(userinfo?.language_name ?? "普通话", for: UIControl.State.normal)

    }
    func loadFrame() {
        
        leftTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(headView.snp.bottom).offset(28*kWIDTHBASE)
            make.left.equalTo(25*kWIDTHBASE)
            make.size.equalTo(CGSize.init(width: 90*kWIDTHBASE, height: 20*kWIDTHBASE))
        }
  
        rightBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(leftTitleLabel)
            make.right.equalTo(-25*kWIDTHBASE)
            make.left.equalTo(leftTitleLabel.snp.right).offset(10*kWIDTHBASE)
            make.height.equalTo(20*kWIDTHBASE)
        }
        
        lineLabel.snp.makeConstraints { (make) in
            make.top.equalTo(leftTitleLabel.snp.bottom).offset(15*kWIDTHBASE)
            make.right.equalTo(-25*kWIDTHBASE)
            make.left.equalTo(25*kWIDTHBASE)
            make.height.equalTo(1)
        }
        
        
        descLab.snp.makeConstraints { (make) in
            make.top.equalTo(lineLabel.snp.bottom).offset(30*kWIDTHBASE)
            make.left.right.equalToSuperview()
            make.height.equalTo(20*kWIDTHBASE)
        }
        
    }
}

extension SettingThirdViewController{
    // 右上角完成
    func nextStep() {
           print(child_birthday)
           print(role_id)
           print(currentSelectedStr)
        
        var num: String = ""
        if let a = currentSelectedStr["id"] as? NSNumber {
            let aString = a.stringValue
            print(aString)
            num = aString
        }
        
//        var role_id: String = ""
//        if let a = role_id as? NSNumber {
//            let aString = a.stringValue
//            print(aString)
//            role_id = aString
//        }
        let userInfo = UserInfo.default.findUserInfo()

        settingProvider.request(FXJ_SettingAPI.settingUserInfoAPI(language_id: num, role_id: role_id, child_birthday: child_birthday, user_id: userInfo?.id ?? "")) { [weak self](result) in
            
            switch result {
            case .success(let res) :
                let jsonStr = String.init(data: res.data, encoding: .utf8)
                if let model = BaseModel.deserialize(from: jsonStr) {
                    if model.code == 200 {
                        print(model.data as Any)
                        self?.view.makeToast(model.msg, position: .center)
                        if self?.isRegisterEnter == true {
                            GlobalUIManager.loadHomeVC()
                        }else{
                           self?.navigationController?.popToRootViewController(animated: true)
                        }
                    } else {
                        self?.view.makeToast(model.msg, position: .center)
                    }
                }
                
            case .failure(let error):
                self?.view.makeToast(error.localizedDescription, position: .center)
            }
   
        }
    }
    
    @objc func rightBtnClick(btn : UIButton) {
        
        if self.dataArray.count <= 0{
             view.makeToast("暂无数据", position: .center)
            return
        }
        
        self.view.addSubview(pickerViewBgView)
        pickerViewBgView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(244*kWIDTHBASE)
        }
        pickerView.selectRow(0, inComponent: 0, animated: true)
        let dict = dataArray[0]
        currentSelectedStr = dict
    }
    
    // 加载语言列表
    func loadLanguageListRequest(){
      let model = UserInfo.default.findUserInfo()
        settingProvider.request(FXJ_SettingAPI.languageListAPI(phone: model!.phone!, pwd: "")) { [weak self](result) in
            
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
    
    // 选择器完成
    @objc func getPickerViewValue(){
        pickerViewBgView.removeFromSuperview()
        self.nextStep()
    }
        //设置PickerView列数(dataSourse协议)
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        //设置PickerView行数(dataSourse协议)
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return dataArray.count
        }

        //设置行高
        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return 50*kWIDTHBASE
        }
        //修改PickerView选项
        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

//            //设置分割线
//            for (UIView *line in pickerView.subviews) {
//                if (line.frame.size.height < 1) {//0.6667
//                    line.backgroundColor = [UIColor blackColor];
//                    CGRect tempRect = line.frame;
//                    CGFloat lineW = 120;
//                    line.frame = CGRectMake((pickerView.frame.size.width - lineW) * 0.5, tempRect.origin.y, lineW, 2);
//                }
//            }
            
            //修改字体，大小，颜色
            var pickerLabel = view as? UILabel
            if pickerLabel == nil{
                pickerLabel = UILabel()
                pickerLabel?.font = UIFont.systemFont(ofSize: 20*kWIDTHBASE)
                pickerLabel?.textAlignment = .center
            }
            let dict = dataArray[row]
            pickerLabel?.text = (dict["name"] as! String)
            pickerLabel?.textColor = UIColor.hexInt(0x313131)
            return pickerLabel!
        }
        //检测响应选项的选择状态
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            let dict = dataArray[row]
            currentSelectedStr = dict
            rightBtn.setTitle(currentSelectedStr["name"] as? String, for: .normal)
        }
   }

