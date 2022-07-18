//
//  TagsView.swift
//  SwiftProject
//
//  Created by YX on 2019/8/27.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit

class TagsView: UIView {
    lazy var todayTitleLab: UILabel = {
        let lab = UILabel.init()
        lab.text = "今天"
        lab.textAlignment = .right
        lab.textColor = UIColor.init(r: 153, g: 153, b: 153)
        lab.font = UIFont.font(size: 10, weight: .regular)
        return lab
    }()
    
    
    lazy var todayIcon: UIView = {
        let view = UIView.init()
        view.layer.cornerRadius = 3.0
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.init(r: 255, g: 176, b: 29)
        return view
    }()
    
    
    lazy var undoTitleLab: UILabel = {
        let lab = UILabel.init()
        lab.text = "未听"
        lab.textAlignment = .right
        lab.textColor = UIColor.init(r: 153, g: 153, b: 153)
        lab.font = UIFont.font(size: 10, weight: .regular)
        return lab
    }()
    
    lazy var undoIcon: UIView = {
        let view = UIView.init()
        view.layer.cornerRadius = 3.0
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.init(r: 238, g: 238, b: 238)
        return view
    }()
    
    
    lazy var doneTitleLab: UILabel = {
        let lab = UILabel.init()
        lab.text = "已听"
        lab.textAlignment = .right
        lab.textColor = UIColor.init(r: 153, g: 153, b: 153)
        lab.font = UIFont.font(size: 10, weight: .regular)
        return lab
    }()
    
    lazy var doneIcon: UIView = {
        let view = UIView.init()
        view.layer.cornerRadius = 3.0
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.init(r: 96, g: 206, b: 135)
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


extension TagsView {
    func loadUI() {
        addSubviews([todayTitleLab, todayIcon, undoTitleLab, undoIcon, doneTitleLab, doneIcon])
    }
    
    func loadFrame() {
        todayTitleLab.snp.makeConstraints { (make) in
            make.top.bottom.right.equalTo(0)
        }
        
        todayIcon.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 6, height: 6))
            make.centerY.equalTo(todayTitleLab.snp.centerY)
            make.right.equalTo(todayTitleLab.snp.left).offset(-2)
        }
        
        
        undoTitleLab.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(0)
            make.right.equalTo(todayIcon.snp.left).offset(-8)
        }
        
        undoIcon.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 6, height: 6))
            make.centerY.equalTo(todayTitleLab.snp.centerY)
            make.right.equalTo(undoTitleLab.snp.left).offset(-2)
        }
        
        doneTitleLab.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(0)
            make.right.equalTo(undoIcon.snp.left).offset(-8)
        }
        
        doneIcon.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 6, height: 6))
            make.centerY.equalTo(todayTitleLab.snp.centerY)
            make.right.equalTo(doneTitleLab.snp.left).offset(-2)
        }
        
    }
}
