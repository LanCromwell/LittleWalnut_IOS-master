
//
//  SettingHeadView.swift
//  SwiftProject
//
//  Created by YX on 2019/8/28.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit

class SettingHeadView: UIView {
    
    typealias CallBack = () -> Void
    
    var callback: CallBack?
    
    //topView
    lazy var topView: UIView = {
        let topView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 146 + kStatusHeight))
        return topView
    }()
    
    ///渐变背景
    lazy var bgLayer: CAGradientLayer = {
        let bgLayer = CAGradientLayer()
        bgLayer.colors = [UIColor(red: 1, green: 0.76, blue: 0.39, alpha: 1).cgColor, UIColor(red: 1, green: 0.44, blue: 0.39, alpha: 1).cgColor, UIColor(red: 1, green: 0.23, blue: 0.4, alpha: 1).cgColor]
        bgLayer.locations = [0, 0.83, 1]
        bgLayer.frame = topView.bounds
        bgLayer.startPoint = CGPoint(x: 1, y: 1)
        bgLayer.endPoint = CGPoint(x: -0.04, y: -0.04)
        return bgLayer
    }()
    
    
    ///title
    lazy var titleLab: UILabel = {
        let lab = UILabel.init()
        lab.text = "设置状态"
        lab.textAlignment = .center
        lab.textColor = UIColor.white
        lab.font = UIFont.font(size: 18, weight: .semibold)
        return lab
    }()
    
    ///下一步
    lazy var nextBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle("下一步", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.font(size: 12, weight: .regular)
        btn.addTarget(self, action: #selector(nextEvent), for: .touchUpInside)
        btn.isHidden = true
        return btn
    }()
    
    ///内容框
    lazy var contentV: UIImageView = {
        let imageV = UIImageView()
        imageV.frame = CGRect.init(x: 12, y: kTopHeight, width: kScreenWidth - 24, height: 130)
        imageV.image = UIImage.init(named: "shadow_bg")
        imageV.isUserInteractionEnabled = true
        return imageV
    }()
    
    
    ///第一个
    lazy var firstIconV: UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "first_selected")
        return imageV
    }()
    
    lazy var firstTitleLab: UILabel = {
        let lab = UILabel.init()
        lab.text = "宝宝出生日"
        lab.textAlignment = .center
        lab.textColor = UIColor.init(r: 153, g: 153, b: 153)
        lab.font = UIFont.font(size: 12, weight: .regular)
        return lab
    }()
    
    
    ///第二个
    lazy var secondIconV: UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "second_normal")
        return imageV
    }()
    
    lazy var secondTitleLab: UILabel = {
        let lab = UILabel.init()
        lab.text = "选择身份"
        lab.textAlignment = .center
        lab.textColor = UIColor.init(r: 216, g: 216, b: 216)
        lab.font = UIFont.font(size: 12, weight: .regular)
        return lab
    }()
    
    
    ///第三个
    lazy var thirdIconV: UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "third_normal")
        return imageV
    }()
    
    lazy var thirdTitleLab: UILabel = {
        let lab = UILabel.init()
        lab.text = "选择语言"
        lab.textAlignment = .center
        lab.textColor = UIColor.init(r: 216, g: 216, b: 216)
        lab.font = UIFont.font(size: 12, weight: .regular)
        return lab
    }()
    
    ///第一个line
    lazy var firstLineV: UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "line_selected")
        return imageV
    }()
    
    ///第二个line
    lazy var secondLineV: UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "line_normal")
        return imageV
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


extension SettingHeadView {
    @objc func nextEvent() {
        print("下一步")
        if callback != nil {
            callback!()
        }
    }
}


extension SettingHeadView {
    func loadUI() {
        self.addSubview(self.topView)
        self.topView.layer.addSublayer(bgLayer)
        addSubview(titleLab)
        addSubview(nextBtn)
        self.addSubview(self.contentV)
        contentV.addSubviews([firstIconV, firstLineV, firstTitleLab, secondIconV, secondLineV, secondTitleLab, thirdIconV, thirdTitleLab])
    }
    
    func loadFrame() {
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(kStatusHeight)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
        }
        
        nextBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 60, height: 30))
            make.centerY.equalTo(titleLab.snp.centerY)
            make.right.equalTo(-15)
        }
        
        secondIconV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 32, height: 33))
            make.centerX.equalToSuperview()
            make.top.equalTo(38)
        }
        
        secondTitleLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(secondIconV.snp.centerX)
            make.bottom.equalTo(-25)
        }
        
        firstLineV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 41, height: 1))
            make.centerY.equalTo(secondIconV.snp.centerY)
            make.right.equalTo(secondIconV.snp.left).offset(-10)
        }
        
        
        secondLineV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 41, height: 1))
            make.centerY.equalTo(secondIconV.snp.centerY)
            make.left.equalTo(secondIconV.snp.right).offset(10)
        }
        
        
        firstIconV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 36, height: 35))
            make.centerY.equalTo(secondIconV.snp.centerY)
            make.right.equalTo(firstLineV.snp.left).offset(-10)
        }
        
        
        firstTitleLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(firstIconV.snp.centerX)
            make.bottom.equalTo(-25)
        }
        
        thirdIconV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 33, height: 32))
            make.centerY.equalTo(secondIconV.snp.centerY)
            make.left.equalTo(secondLineV.snp.right).offset(10)
        }
        
        thirdTitleLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(thirdIconV.snp.centerX)
            make.bottom.equalTo(-25)
        }
        
    }
}

extension SettingHeadView {
    // 设置标题
    func setTitleLableText(text:String) {
        titleLab.text = text;
    }
    //设置第二个icon图片
    func setSecondIconWithImage(imageName:String) {
       secondIconV.image = UIImage.init(named: imageName);
    }
    //设置第二个title颜色
    func setSecondLabelTextColorWithColor(color:UIColor) {
        secondTitleLab.textColor = color;
    }
    // 设置第三阶段信息
    func setThirdHeaderViewData(text:String,imageName:String,color:UIColor) {
        titleLab.text = text;
        thirdIconV.image = UIImage.init(named: imageName);
        thirdTitleLab.textColor = color;
        secondLineV.image = UIImage.init(named: "line_selected")
    }
}
