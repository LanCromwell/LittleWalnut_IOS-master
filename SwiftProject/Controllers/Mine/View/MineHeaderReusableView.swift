//
//  MineHeaderReusableView.swift
//  SwiftProject
//
//  Created by YX on 2019/7/26.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit

class MineHeaderReusableView: UICollectionReusableView {
    //topView
    lazy var topView: UIView = {
        let topView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 146 * kWIDTHBASE + kStatusHeight))
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
    
    
    ///内容框
    lazy var contentView: UIImageView = {
        let layerView = UIImageView.init(frame: CGRect.init(x: 12, y: kStatusHeight + 44, width: kScreenWidth - 24, height: 169 * kWIDTHBASE))
//        // fillCode
        let bgLayer1 = CALayer()
        bgLayer1.frame = layerView.bounds
        bgLayer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        bgLayer1.cornerRadius = 8.0
        layerView.layer.addSublayer(bgLayer1)
        // shadowCode
        layerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.07).cgColor
        layerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        layerView.layer.shadowOpacity = 1
        layerView.layer.shadowRadius = 8
//        layerView.image = UIImage.init(named: "shadow_bg")
        layerView.isUserInteractionEnabled = true
        return layerView
    }()
    
    ///头像
    lazy var headView: UIImageView = {
        let headV = UIImageView.init()
        headV.layer.cornerRadius = 35.0
        headV.layer.masksToBounds = true
        headV.image = UIImage.init(named: "mother_placeholder")
        return headV
    }()
    
    ///title
    lazy var titleLab: UILabel = {
        let lab = UILabel.init()
        lab.text = ""
        lab.textAlignment = .center
        lab.textColor = UIColor.init(r: 49, g: 49, b: 49)
        lab.font = UIFont.font(size: 18, weight: .medium)
        return lab
    }()
    
    ///desc
    lazy var descLab: UILabel = {
        let lab = UILabel.init()
        lab.text = "已经学习388天，获得38积分"
        lab.textAlignment = .center
        lab.textColor = UIColor.init(r: 153, g: 153, b: 153)
        lab.font = UIFont.font(size: 12, weight: .regular)
        return lab
    }()
    
    var model: UserInfo? {
        didSet {
            guard let model = model else { return }

            titleLab.text = "亲爱的" + (model.role_name ?? "")
            
            var studyDay = model.register_date ?? ""
            if studyDay.hasPrefix("已经学习") {
               studyDay = studyDay.replacingOccurrences(of: "已经学习", with: "")
            }
            if studyDay.hasSuffix("天") {
                studyDay = studyDay.replacingOccurrences(of: "天", with: "")
            }
            descLab.attributedText = highlightString(studyDay, score: model.is_receive_vip ?? "0")
            
            if model.role_id! == "1" { // mama
                headView.sd_setImage(with: URL.init(string: model.avatar ?? ""), placeholderImage: UIImage.init(named: "second_woman"))
            } else {
                headView.sd_setImage(with: URL.init(string: model.avatar ?? ""), placeholderImage: UIImage.init(named: "second_man"))
            }
            

        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUI()
        loadFrame()
        
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MineHeaderReusableView {
    func highlightString(_ day: String, score: String) -> NSMutableAttributedString {
        //定义富文本即有格式的字符串
        let attributedStrM : NSMutableAttributedString = NSMutableAttributedString()
        
        let oneString = NSAttributedString.init(string: "已经学习", attributes: [NSAttributedString.Key.foregroundColor : UIColor.init(r: 153, g: 153, b: 153) , NSAttributedString.Key.font : UIFont.font(size: 12, weight: .regular)])
        let twoString = NSAttributedString.init(string: day, attributes: [NSAttributedString.Key.foregroundColor : UIColor.init(r: 255, g: 151, b: 62) , NSAttributedString.Key.font : UIFont.font(size: 12, weight: .regular)])
        let threeString = NSAttributedString.init(string: "天，获得", attributes: [NSAttributedString.Key.foregroundColor : UIColor.init(r: 153, g: 153, b: 153) , NSAttributedString.Key.font : UIFont.font(size: 12, weight: .regular)])
        let fourString = NSAttributedString.init(string: score, attributes: [NSAttributedString.Key.foregroundColor : UIColor.init(r: 255, g: 151, b: 62) , NSAttributedString.Key.font : UIFont.font(size: 12, weight: .regular)])
        let fiveString = NSAttributedString.init(string: "积分", attributes: [NSAttributedString.Key.foregroundColor : UIColor.init(r: 153, g: 153, b: 153) , NSAttributedString.Key.font : UIFont.font(size: 12, weight: .regular)])

        attributedStrM.append(oneString)
        attributedStrM.append(twoString)
        attributedStrM.append(threeString)
        attributedStrM.append(fourString)
        attributedStrM.append(fiveString)

        
        return attributedStrM
    }
}

extension MineHeaderReusableView {
    func loadUI() {
        self.addSubview(self.topView)
        self.topView.layer.addSublayer(bgLayer)
        
        self.addSubview(self.contentView)
        contentView.addSubviews([titleLab, headView, descLab])
    }
    
    func loadFrame() {
        headView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 70 * kWIDTHBASE, height: 70 * kWIDTHBASE))
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(26 * kWIDTHBASE)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(headView.snp.bottom).offset(3 * kWIDTHBASE)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        descLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(titleLab.snp.bottom).offset(10 * kWIDTHBASE)
        }
    }
}
