//
//  MineLogoutItem.swift
//  SwiftProject
//
//  Created by YX on 2019/8/28.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit

class MineLogoutItem: UICollectionViewCell {
    
    ///背景
    lazy var bgImageV: UIImageView = {
        let imageV = UIImageView()
        imageV.frame = CGRect.init(x: 12, y: 20, width: kScreenWidth - 24, height: 60)
        imageV.image = UIImage.init(named: "shadow_bg")
        imageV.isUserInteractionEnabled = true
        return imageV
    }()
    
    lazy var titleLab: UILabel = {
        let lab = UILabel.init()
        lab.text = "退出登录"
        lab.textAlignment = .center
        lab.textColor = UIColor.init(r: 153, g: 153, b: 153)
        lab.font = UIFont.font(size: 15, weight: .regular)
        return lab
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


extension MineLogoutItem {
    ///添加子视图
    fileprivate func loadUI() {
        addSubviews(bgImageV)
        bgImageV.addSubviews(titleLab)
    }
    
    ///布局
    fileprivate func loadFrame() {
        titleLab.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}



