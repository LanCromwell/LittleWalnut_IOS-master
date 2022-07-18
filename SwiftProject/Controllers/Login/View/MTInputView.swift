//
//  MTInputView.swift
//  SwiftProject
//
//  Created by YX on 2019/7/26.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit
import JKCategories

enum MTInputViewType {
    case MTInputViewType_Phone
    case MTInputViewType_Pwd
    case MTInputViewType_Invited
}

class MTInputView: UIView {
    
    var type: MTInputViewType = .MTInputViewType_Phone {
        didSet {
            if type == .MTInputViewType_Invited {
                leftIcon.isHidden = true
            }
        }
    }
    
    ///容器
    lazy var contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()
    
    ///圆角
    lazy var radiusLayer: CALayer = {
        let layer = CALayer()
        layer.masksToBounds = true
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.init(r: 181, g: 181, b: 181).cgColor
        contentView.layer.addSublayer(layer)
        return layer
    }()
    
    ///leftIcon
    lazy var leftIcon: UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage.init(named: "weixin")
        return imageV
    }()
    
    ///输入框
    lazy var inputTF: UITextField = {
        let inputTF = UITextField()
        inputTF.textColor = UIColor.init(gray: 51)
//        inputTF.clearsOnBeginEditing = true
        if (UIDevice.current.systemVersion as NSString).floatValue >= 13.0 {
           inputTF.attributedPlaceholder = NSAttributedString.init(string: "", attributes: [NSAttributedString.Key.font: UIFont.font(size: 13, weight: .medium),NSAttributedString.Key.foregroundColor : UIColor.init(r: 151, g: 151, b: 151)])
                                               
        }else{
            inputTF.setValue(UIFont.font(size: 13, weight: .medium) ,forKeyPath: "_placeholderLabel.font")
                   inputTF.setValue(UIColor.init(r: 151, g: 151, b: 151), forKeyPath: "_placeholderLabel.textColor")
        }
        
       
        inputTF.font = UIFont.font(size: 13, weight: .medium)
        inputTF.clearButtonMode = .whileEditing
        ///适配iOS 13
//        let placeholserAttributes = [NSAttributedString.Key.foregroundColor : UIColor.blue,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)]
//        inputTF.attributedPlaceholder = NSAttributedString(string: "输入密码",attributes: placeholserAttributes)
   
        return inputTF
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUI()
        loadFrame()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        ///设置圆角边框
        radiusLayer.frame = contentView.bounds
        radiusLayer.cornerRadius = contentView.mj_h/2.0
    }
}


extension MTInputView {
    fileprivate func loadUI () {
       addSubviews([contentView, leftIcon, inputTF])
    }
    
    
    fileprivate func loadFrame() {
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        leftIcon.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView.snp.centerY)
            make.left.equalTo(10)
            make.size.equalTo(CGSize.init(width: 20, height: 20))
        }
        
        inputTF.snp.makeConstraints { (make) in
            make.left.equalTo(leftIcon.snp.right).offset(8)
            make.right.equalTo(-10)
            make.top.bottom.equalTo(0)
        }
    }
}
