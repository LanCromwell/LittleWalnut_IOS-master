//
//  SettingFirstViewController.swift
//  SwiftProject
//
//  Created by YX on 2019/8/28.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import HWPopController


class SettingFirstViewController: BaseViewController {
    
    var currentTimeStr : String = ""

    var child_birthday : String = ""
    var isRegisterEnter : Bool = false
    
    let disposeBag = DisposeBag()
    ///头部视频
    lazy var headerView: SettingHeadView = {
        let headV = SettingHeadView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kStatusHeight + 200))
//        headV.callback = {
//            self.nextEvent()
//        }
        return headV
    }()
    
    ///头像
    lazy var headImageV: UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage.init(named: "first_head")
        return imageV
    }()
    
    ///title
    lazy var titleLab: UILabel = {
        let lab = UILabel.init()
        lab.text = "孩子的预产期/出生日期"
        lab.textColor = UIColor.init(r: 49, g: 49, b: 49)
        lab.font = UIFont.font(size: 15, weight: .regular)
        return lab
    }()
    
    ///时间
    lazy var timeLab: UILabel = {
        let lab = UILabel.init()
        lab.text = self.currentTimeStr
        lab.textColor = UIColor.init(r: 153, g: 153, b: 153)
        lab.font = UIFont.font(size: 15, weight: .regular)
        lab.rx.tapGesture.subscribeNext({ (tap) in
            self.showPickView();
        }).disposed(by: disposeBag)
        return lab
    }()
    
    ///右侧icon
    lazy var rightIconV: UILabel = {
        let lab = UILabel.init()
        lab.text = ">"
        lab.textAlignment = .center
        lab.textColor = UIColor.init(r: 153, g: 153, b: 153)
        lab.font = UIFont.font(size: 15, weight: .regular)
        return lab
    }()
    
    ///下滑线
    lazy var lineV: UIView = {
        let lineV = UIView()
        lineV.backgroundColor = UIColor.init(r: 216, g: 216, b: 216)
        return lineV
    }()
    
    ///描述
    lazy var descLab: UILabel = {
        let lab = UILabel.init()
        lab.text = "完善以上信息，获取更多精准内容"
        lab.textColor = UIColor.init(r: 153, g: 153, b: 153)
        lab.font = UIFont.font(size: 12, weight: .regular)
        return lab
    }()
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userinfo = UserInfo.default.findUserInfo()
        if userinfo?.child_birthday != nil {
            let birthdayStr = self.timeStampToString(timeStamp: userinfo!.child_birthday!)
            self.currentTimeStr = birthdayStr

        }else{
            let date = Date()
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "yyyy.MM.dd"
            let timeStr = timeFormatter.string(from: date)
            self.currentTimeStr = timeStr
            self.child_birthday = self.currentTimeStr
        }
        
        loadUI()
        loadFrame()
        
       
        
    }
    
    deinit {
        print("✅dealloc  \(#file) ")
    }
    
}

extension SettingFirstViewController {
    ///下一步
    func nextEvent() {
        if self.child_birthday.count <= 0 {
            view.makeToast("请选择日期", position: .center)
            return
        }
        let secondVC = SettingSecondViewController()
        secondVC.child_birthday = self.child_birthday
        secondVC.isRegisterEnter = self.isRegisterEnter
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    ///弹出时间选择框
    func showPickView() {
        ///时间选择器
        let timeVC = TimePickerViewController()
        timeVC.timeString = self.currentTimeStr
        weak var weakself = self
        timeVC.timePickerBlock = { (year,month,day) in
//            let m = String(format: "%02f", month)
//            let d = String(format: "%02f", day)
            let str = "\(year).\(month).\(day)"
            let birthdatStr = weakself?.stringToTimeStamp(stringTime: str)
            weakself!.child_birthday = birthdatStr!
            weakself!.timeLab.text = str
            weakself!.nextEvent()
        }
        let popController = HWPopController.init(viewController: timeVC)
        popController.popPosition = .bottom
        popController.popType = .slideInFromBottom
        popController.present(in: self)
    }
    
    /**
     时间转化为时间戳
     :param: stringTime 时间为stirng
     
     :returns: 返回时间戳为stirng
     */
     func stringToTimeStamp(stringTime:String)->String {
        
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy.MM.dd"
        let date = dfmatter.date(from: stringTime)
        
        let dateStamp:TimeInterval = date!.timeIntervalSince1970
        
        let dateSt:Int = Int(dateStamp)
        print(dateSt)
        return String(dateSt)
        
    }
    /**
     时间戳转时间
    :param: timeStamp <#timeStamp description#>
    
    :returns: return time
    */
     func timeStampToString(timeStamp:String)->String {
        
        let string = NSString(string: timeStamp)
        let timeSta:TimeInterval = string.doubleValue
        
        //转换为时间
        
        let timeInterval:TimeInterval = TimeInterval(timeSta)

        let date = NSDate(timeIntervalSince1970: timeInterval)

        let dateformatter = DateFormatter()

        dateformatter.dateFormat = "yyyy.MM.dd" //自定义日期格式

        let time = dateformatter.string(from: date as Date)
      
        print(time)
        return time
    }
}


extension SettingFirstViewController {
    func loadUI() {
        view.addSubviews([headerView, headImageV, titleLab, timeLab, rightIconV, lineV, descLab])
    }
    
    func loadFrame() {
        headImageV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 70, height: 70))
            make.centerX.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(headImageV.snp.bottom).offset(20)
            make.left.equalTo(25)
        }
        
        rightIconV.snp.makeConstraints { (make) in
            make.right.equalTo(-25)
            make.centerY.equalTo(titleLab.snp.centerY)
        }
        
        timeLab.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLab.snp.centerY)
            make.right.equalTo(rightIconV.snp.left).offset(-8)
        }
        
        lineV.snp.makeConstraints { (make) in
            make.left.equalTo(25)
            make.right.equalTo(-25)
            make.height.equalTo(1)
            make.top.equalTo(timeLab.snp.bottom).offset(15)
        }
        
        descLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(lineV.snp.bottom).offset(28)
        }
    }
}

