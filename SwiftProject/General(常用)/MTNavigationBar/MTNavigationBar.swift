//
//  MTNavigationBar.swift
//  SwiftProject
//
//  Created by YX on 2019/7/20.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit

class MTNavigationBar: UIView {
    
    var onClickLeftButton: (()->())?
    
    ///MARK:- 属性
    var title: String? {
        willSet {
            titleLabel.text = newValue
        }
    }
    
    ///背景View
    lazy var backgroundView: UIView = {
        let view = UIView.init()
        return view
    }()
    
    ///背景图片
    lazy var backgrounImageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.isUserInteractionEnabled = true
        imageView.isHidden = true
        return imageView
    }()
    
    ///下划线 默认显示
    lazy var bottomLine: UIView = {
        let lineV = UIView.init()
        lineV.backgroundColor = UIColor(red: (218.0/255.0), green: (218.0/255.0), blue: (218.0/255.0), alpha: 1.0)
        lineV.isHidden = true
        return lineV
    }()
    
    ///titleLabel
    lazy var titleLabel: UILabel = {
        let titleLab = UILabel.init()
        titleLab.textColor = UIColor.white
        titleLab.textAlignment = .center
        return titleLab
    }()
    
    lazy var leftButton: UIButton = {
        let btn = UIButton.init()
        btn.imageView?.contentMode = .center
        btn.isHidden = true
        btn.addTarget(self, action: #selector(leftEvent), for: .touchUpInside)
        return btn
    }()
    
    lazy var rightButton: UIButton = {
        let btn = UIButton.init()
        btn.imageView?.contentMode = .center
        btn.isHidden = true
        btn.addTarget(self, action: #selector(rightEvent), for: .touchUpInside)
        return btn
    }()
    
    
    ///构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        ///添加控件
        loadUI()
        ///布局
        loadFrame()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}




//MARK: - 导航栏左右按钮事件处理
extension MTNavigationBar {
    ///左侧button 点击事件
    @objc func leftEvent() {
        if let onClickBack = onClickLeftButton {
            onClickBack()
        } else {
            self.ly_viewController?.navigationController?.popViewController(animated: true)
        }
    }
    
    ///右侧button 点击事件
    @objc func rightEvent() {
        
    }
}


//MARK:- 添加视图 & layout
extension MTNavigationBar {
    ///添加视图
    fileprivate func loadUI() {
        addSubviews(backgroundView, backgrounImageView, leftButton, titleLabel, leftButton, bottomLine)
    }
    
    ///开始布局
    fileprivate func loadFrame() {
        
        let margin:CGFloat = 0
        let buttonHeight:CGFloat = 44
        let buttonWidth:CGFloat = 70
        let titleLabelWidth:CGFloat = 180

        backgroundView.frame = self.bounds
        backgrounImageView.frame = self.bounds
        leftButton.frame = CGRect.init(x: margin, y: kStatusHeight, width: buttonWidth, height: buttonHeight)
        rightButton.frame = CGRect.init(x: kScreenWidth - buttonWidth, y: kStatusHeight, width: buttonWidth, height: buttonHeight)
        titleLabel.frame = CGRect.init(x: (kScreenWidth - titleLabelWidth)/2.0, y: kStatusHeight, width: titleLabelWidth, height: buttonHeight)
        bottomLine.frame =  CGRect.init(x: 0, y: bounds.height - 0.5, width: kScreenWidth, height: 0.5)
    }
    

    
}
