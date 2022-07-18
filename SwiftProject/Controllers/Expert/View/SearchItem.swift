//
//  SearchItem.swift
//  SwiftProject
//
//  Created by YX on 2019/8/29.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit

class SearchItem: UICollectionViewCell {
    
    ///标题
    lazy var titleLab: UILabel = {
        let lab = UILabel.init(frame: CGRect.init(x: 0, y: 9, width: 80, height: 22))
        lab.text = "亲子游戏"
        lab.textAlignment = .center
        lab.textColor = UIColor.init(r: 255, g: 255, b: 255)
        lab.font = UIFont.font(size: 12, weight: .regular)
        // strokeCode
        return lab
    }()
    
    lazy var borderLayer: CALayer = {
        let borderLayer = CALayer()
        borderLayer.frame = titleLab.bounds
        borderLayer.borderWidth = 1.0
        borderLayer.cornerRadius = 11.0
        borderLayer.borderColor = UIColor.white.cgColor
        return borderLayer
    }()
    
    
    var model: ExpertModel? {
        didSet {
            guard let model = model else { return}
            ///绑定数据
            titleLab.text = model.name ?? ""
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


extension SearchItem {
    func loadUI() {
        contentView.addSubview(titleLab)
        titleLab.layer.addSublayer(borderLayer)
    }
    
    
    func loadFrame() {
//        titleLab.snp.makeConstraints { (make) in
//            make.left.right.equalTo(0)
//            make.height.equalTo(30)
//            make.centerY.equalTo(contentView.snp.centerY)
//        }
        
    }
}
