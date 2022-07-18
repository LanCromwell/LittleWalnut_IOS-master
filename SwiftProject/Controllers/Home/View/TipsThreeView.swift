//
//  TipsThreeView.swift
//  SwiftProject
//
//  Created by YX on 2019/9/19.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit


class TipsThreeView: UIView {
    
    lazy var bgView: UIImageView = {
        let bgView = UIImageView.init()
        bgView.image = UIImage.init(named: "tip_one_bg")
        return bgView
    }()
    
    lazy var one: UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "tips_three_01")
        return imageV
    }()
    
    lazy var two: UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "tips_three_02")
        return imageV
    }()
    
    lazy var three: UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "tips_three_03")
        return imageV
    }()
    
    lazy var four: UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "tips_three_04")
        imageV.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(doneEvent))
        imageV.addGestureRecognizer(tap)
        return imageV
    }()
    
    ///tips
    lazy var fourTipsView: TipsFourView = {
        let view = TipsFourView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        return view
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


extension TipsThreeView {
    fileprivate func loadUI() {
        addSubviews([bgView, one, two, three, four])
    }
    
    fileprivate func loadFrame() {
        bgView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        
        three.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 140 * kWIDTHBASE, height: 47 * kWIDTHBASE))
            make.right.equalTo(-15)
            make.top.equalTo(kStatusHeight +  kScreenWidth/7 * 6)
        }
        
        two.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 47 * kWIDTHBASE, height: 89 * kWIDTHBASE))
            make.bottom.equalTo(three.snp.top).offset(-5 * kWIDTHBASE)
            make.right.equalTo(-100 * kWIDTHBASE)
        }
        
        
        
        one.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 228 * kWIDTHBASE, height: 134 * kWIDTHBASE))
            make.centerX.equalToSuperview()
            make.bottom.equalTo(two.snp.top).offset(-4 * kWIDTHBASE)
        }
        
        four.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 110 * kWIDTHBASE, height: 47 * kWIDTHBASE))
            make.centerX.equalToSuperview()
            make.top.equalTo(three.snp.bottom).offset(45 * kWIDTHBASE)
        }
    }
}


extension TipsThreeView {
    @objc fileprivate func doneEvent() {
        self.removeFromSuperview()
        ///添加tips
        let window = UIApplication.shared.keyWindow!
        window.addSubview(fourTipsView)
    }
}
