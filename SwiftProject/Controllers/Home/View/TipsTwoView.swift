//
//  TipsTwoView.swift
//  SwiftProject
//
//  Created by YX on 2019/9/19.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit

class TipsTwoView: UIView {

    lazy var bgView: UIImageView = {
        let bgView = UIImageView.init()
        bgView.image = UIImage.init(named: "tip_one_bg")
        return bgView
    }()
    
    lazy var one: UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "tip_one_01")
        return imageV
    }()
    
    lazy var two: UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "tip_one_02")
        imageV.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(doneEvent))
        imageV.addGestureRecognizer(tap)
        return imageV
    }()
    
    lazy var three: UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "tips_two_01")
        return imageV
    }()
    
    lazy var four: UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "tips_two_02")
        return imageV
    }()
    
    ///tips
    lazy var threeTipsView: TipsThreeView = {
        let view = TipsThreeView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
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


extension TipsTwoView {
    fileprivate func loadUI() {
        addSubviews([bgView, one, two, three, four])
    }
    
    fileprivate func loadFrame() {
        bgView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        
        one.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 46 * kWIDTHBASE, height: 127 * kWIDTHBASE))
            make.left.equalTo(120 * kWIDTHBASE)
            make.bottom.equalTo(four.snp.top).offset(-4 * kWIDTHBASE)
        }
        
        two.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 110 * kWIDTHBASE, height: 47 * kWIDTHBASE))
            make.centerX.equalToSuperview()
            make.top.equalTo(four.snp.bottom).offset(36 * kWIDTHBASE)
        }
        
        three.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 288 * kWIDTHBASE, height: 65 * kWIDTHBASE))
            make.left.equalTo(60 * kWIDTHBASE)
            make.bottom.equalTo(one.snp.top).offset(-10 * kWIDTHBASE)
        }
        
        four.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 265 * kWIDTHBASE, height: 48 * kWIDTHBASE))
            make.centerX.equalToSuperview()
            make.top.equalTo(kStatusHeight +  kScreenWidth/7 * 6 + 100 * kWIDTHBASE)
        }
    }
}


extension TipsTwoView {
    @objc fileprivate func doneEvent() {
        self.removeFromSuperview()
        ///添加tips
        let window = UIApplication.shared.keyWindow!
        window.addSubview(threeTipsView)
    }
}

