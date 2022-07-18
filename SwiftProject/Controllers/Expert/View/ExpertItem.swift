//
//  ExpertItem.swift
//  SwiftProject
//
//  Created by YX on 2019/8/29.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit

class ExpertItem: UICollectionViewCell {
    
    lazy var iconV: UIImageView = {
        let iconV = UIImageView.init()
        iconV.contentMode = .scaleAspectFit
        iconV.image = UIImage.init(named: "expert_item")
        return iconV
    }()
    
    ///标题
    lazy var titleLab: UILabel = {
        let lab = UILabel.init()
        lab.numberOfLines = 0
        lab.text = ""
        lab.textAlignment = .center
        lab.textColor = UIColor.init(r: 49, g: 49, b: 49)
        lab.font = UIFont.font(size: 12, weight: .regular)
        return lab
    }()
    
    var model: ExpertModel? {
        didSet {
            guard let model = model else { return}
            
            iconV.sd_setImage(with: URL.init(string: model.img ?? ""), placeholderImage: UIImage.init(named: "expert_item"))

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


extension ExpertItem {
    func loadUI() {
        contentView.addSubviews([iconV, titleLab])
    }
    
    func loadFrame() {
        iconV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 25, height: 25))
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(10)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(iconV.snp.bottom).offset(5)
        }
    }
}
