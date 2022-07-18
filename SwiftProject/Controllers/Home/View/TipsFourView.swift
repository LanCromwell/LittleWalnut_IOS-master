//
//  TipsFourView.swift
//  SwiftProject
//
//  Created by YX on 2019/9/19.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit


class TipsFourView: UIView {
    
    lazy var bgView: UIImageView = {
        let bgView = UIImageView.init()
        bgView.image = UIImage.init(named: "tip_one_bg")
        return bgView
    }()
    
    lazy var one: UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "tips_four_01")
        return imageV
    }()
    
    lazy var two: UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "tips_four_02")
        return imageV
    }()
    
    lazy var three: UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "tips_four_03")
        return imageV
    }()
    
    lazy var four: UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "tips_four_04")
        imageV.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(doneEvent))
        imageV.addGestureRecognizer(tap)
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


extension TipsFourView {
    fileprivate func loadUI() {
        addSubviews([bgView, one, two, three, four])
    }
    
    fileprivate func loadFrame() {
        bgView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        
        
        
        one.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(kStatusHeight + 60)
            make.height.equalTo((kScreenWidth - 30) * 662 / 714.0)
        }
        
        
        two.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 273 * kWIDTHBASE, height: 92 * kWIDTHBASE))
            make.top.equalTo(one.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        
        
        three.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 34 * kWIDTHBASE, height: 49 * kWIDTHBASE))
            make.centerX.equalToSuperview()
            make.top.equalTo(two.snp.bottom).offset(10 * kWIDTHBASE)
        }
        

        four.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 110  * kWIDTHBASE, height: 47  * kWIDTHBASE))
            make.centerX.equalToSuperview()
            make.top.equalTo(three.snp.bottom).offset(34  * kWIDTHBASE)
        }
    }
}


extension TipsFourView {
    @objc fileprivate func doneEvent() {
        self.removeFromSuperview()
    }
}
