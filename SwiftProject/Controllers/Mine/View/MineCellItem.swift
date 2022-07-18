//
//  MineCellItem.swift
//  SwiftProject
//
//  Created by YX on 2019/8/27.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit

class MineCellItem: UIView {
    
    lazy var iconV: UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "mine_collection")
        imageV.contentMode = .center
        return imageV
    }()
    
    lazy var titleLab: UILabel = {
        let lab = UILabel.init()
        lab.text = "我的收藏"
        lab.textAlignment = .center
        lab.textColor = UIColor.init(r: 49, g: 49, b: 49)
        lab.font = UIFont.font(size: 15, weight: .regular)
        return lab
    }()
    
    lazy var rightIconV: UILabel = {
        let lab = UILabel.init()
        lab.text = ">"
        lab.textAlignment = .center
        lab.textColor = UIColor.init(r: 238, g: 238, b: 238)
        lab.font = UIFont.font(size: 15, weight: .regular)
        return lab
    }()
    
    
    lazy var lineV: UIView = {
        let lineV = UIView()
        lineV.backgroundColor = UIColor.init(r: 238, g: 238, b: 238)
        return lineV
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

extension MineCellItem {
    ///添加子视图
    fileprivate func loadUI() {
        self.addSubviews([iconV, titleLab, rightIconV, lineV])
    }
    
    ///布局
    fileprivate func loadFrame() {
        iconV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 25, height: 25))
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(20)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(iconV.snp.right)
        }
        
        rightIconV.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalToSuperview().offset(-35)
        }
        
        lineV.snp.makeConstraints { (make) in
            make.left.equalTo(45)
            make.right.equalTo(-30)
            make.bottom.equalTo(0)
            make.height.equalTo(1)
        }
    }
}
