//
//  SearchListCell.swift
//  SwiftProject
//
//  Created by YX on 2019/9/12.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit

class SearchListCell: UICollectionViewCell {
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
        btn.addTarget(self, action: #selector(playerEvent), for: .touchUpInside)
        
        return btn
    }()
    
    ///收藏
    lazy var favoriteBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: "expert_favorite"), for: .normal)
        btn.setImage(UIImage.init(named: "favorite-icon-selected"), for: .selected)
        btn.imageEdgeInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        btn.addTarget(self, action: #selector(favoriteEvent), for: .touchUpInside)
        return btn
    }()
    
    ///分享
    lazy var shareBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: "expert_share"), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        btn.addTarget(self, action: #selector(shareEvent), for: .touchUpInside)
        return btn
    }()
    
    ///模型赋值
    var model: SearchModel? {
        didSet {
            guard let model = model else { return }
            
            titleLab.text = model.title ?? ""
            timeLab.text = model.duration ?? ""
            playerBtn.isSelected = model.isPlaying
            favoriteBtn.isSelected = (model.is_collect == nil || model.is_collect == 0) ? false : true
        }
    }
    
    ///索引
    var index: IndexPath?
    
    ///搜索点赞回调
    var searchFavoriteCallBack: ((SearchModel?, IndexPath?) -> ())?
    ///搜索分享回调
    var searchShareCallBack: ((SearchModel?, IndexPath?) -> ())?
    ///搜索播放回调
    var searchPlayerCallBack: ((SearchModel?, IndexPath?) -> ())?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUI()
        loadFrame()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



extension SearchListCell {
    ///分享事件
    @objc fileprivate func shareEvent() {
        searchShareCallBack?(model, index)
    }
    
    ///播放事件
    @objc fileprivate func playerEvent() {
        searchPlayerCallBack?(model, index)
    }
    
    ///点赞事件
    @objc fileprivate func favoriteEvent() {
        searchFavoriteCallBack?(model, index)
    }
}


extension SearchListCell {
    func loadUI() {
        contentView.addSubviews([titleLab, timeLab, lineV, playerBtn, shareBtn, favoriteBtn])
    }
    
    func loadFrame() {
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.top.equalTo(18)
            make.right.equalTo(-144)
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
        
        shareBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 40, height: 40))
            make.right.equalTo(playerBtn.snp.left)
            make.centerY.equalTo(contentView.snp.centerY)
        }

        favoriteBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 40, height: 40))
            make.right.equalTo(shareBtn.snp.left)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        
    }
}


