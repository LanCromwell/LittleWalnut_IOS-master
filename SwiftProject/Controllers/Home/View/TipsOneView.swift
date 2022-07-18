//
//  TipsOneView.swift
//  SwiftProject
//
//  Created by YX on 2019/9/16.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit

class TipsOneView: UIView {
    
    var oneDoneClick: (() -> ())?
    
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
        imageV.image = UIImage.init(named: "tip_one_03")
        return imageV
    }()
    
    lazy var four: UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "tip_one_04")
        return imageV
    }()
    
    ///tips
    lazy var twoTipsView: TipsTwoView = {
        let view = TipsTwoView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
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



extension TipsOneView {
    fileprivate func loadUI() {
        addSubviews([bgView, one, two, three, four])
    }
    
    fileprivate func loadFrame() {
        bgView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        
        four.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 68 * kWIDTHBASE, height: 42 * kWIDTHBASE))
            make.left.equalTo(30 * kWIDTHBASE)
            make.bottom.equalTo(-kBottomSpaceHeight - 2)
        }
        
        one.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 46 * kWIDTHBASE, height: 127 * kWIDTHBASE))
            make.left.equalTo(60 * kWIDTHBASE)
            make.bottom.equalTo(four.snp.top).offset(-4)
        }
        
        two.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 110 * kWIDTHBASE, height: 47 * kWIDTHBASE))
            make.left.equalTo(one.snp.right).offset(37 * kWIDTHBASE)
            make.top.equalTo(one.snp.top).offset(25 * kWIDTHBASE)
        }
        
        three.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 292 * kWIDTHBASE, height: 125 * kWIDTHBASE))
            make.left.equalTo(15 * kWIDTHBASE)
            make.bottom.equalTo(one.snp.top).offset(-10 * kWIDTHBASE)
        }
    }
}


extension TipsOneView {
    @objc fileprivate func doneEvent() {
        oneDoneClick?()
        self.removeFromSuperview()
        ///添加tips
        let window = UIApplication.shared.keyWindow!
        window.addSubview(twoTipsView)
    }
}
