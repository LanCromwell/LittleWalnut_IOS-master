//
//  CollectionCell.swift
//  SwiftProject
//
//  Created by YX on 2019/8/29.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    ///标题
    lazy var titleLab: UILabel = {
        let lab = UILabel.init()
        lab.text = "现代妈妈如何科学坐月子"
        lab.textAlignment = .left
        lab.textColor = UIColor.init(r: 49, g: 49, b: 49)
        lab.font = UIFont.font(size: 15, weight: .medium)
        return lab
    }()
    
    ///时间
    lazy var timeLab: UILabel = {
        let lab = UILabel.init()
        lab.text = "3:23"
        lab.textAlignment = .left
        lab.textColor = UIColor.init(r: 153, g: 153, b: 153)
        lab.font = UIFont.font(size: 12, weight: .regular)
        return lab
    }()
    
    ///下划线
    lazy var lineV: UIView = {
        let lineV = UIView.init()
        lineV.backgroundColor = UIColor.init(r: 238, g: 238, b: 238)
        return lineV
    }()
    
    ///播放按钮
    lazy var playerBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: "player-icon"), for: .normal)
        btn.setImage(UIImage.init(named: "pause-icon"), for: .selected)
        btn.imageEdgeInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        return btn
    }()
    
    ///收藏
    lazy var favoriteBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: "favorite-icon"), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        return btn
    }()
    
    ///分享
    lazy var shareBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: "share-icon"), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        return btn
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


extension CollectionCell {
    func loadUI() {
        contentView.addSubviews([titleLab, timeLab, lineV, playerBtn, shareBtn, favoriteBtn])
    }
    
    func loadFrame() {
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.top.equalTo(18)
            make.right.equalTo(-100)
        }
        
        timeLab.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLab)
            make.top.equalTo(titleLab.snp.bottom).offset(4)
        }
        
        lineV.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.right.equalTo(-12)
            make.bottom.equalTo(0)
            make.height.equalTo(1)
        }
        
        playerBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 40, height: 40))
            make.right.equalTo(-12)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
//        playerBtn.snp.makeConstraints { (make) in
//            make.size.equalTo(CGSize.init(width: 40, height: 40))
//            make.right.equalTo(-12)
//            make.centerY.equalTo(contentView.snp.centerY)
//        }
//        
//        playerBtn.snp.makeConstraints { (make) in
//            make.size.equalTo(CGSize.init(width: 40, height: 40))
//            make.right.equalTo(-12)
//            make.centerY.equalTo(contentView.snp.centerY)
//        }
        
        
    }
}

