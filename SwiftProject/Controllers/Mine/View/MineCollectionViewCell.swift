//
//  MineCollectionViewCell.swift
//  SwiftProject
//
//  Created by YX on 2019/7/26.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum MineType: Int {
    case MineType_CollectionItem = 0
    case MineType_SettingItem = 1
    case MineType_WelfareItem = 2
    case MineType_FeedBackItem = 3
    case MineType_QualificationItem = 4
    case MineType_MallItem = 5
}

protocol MineCollectionViewCellDelegate {
    func mineCellItemDidClick(type: MineType)
}

class MineCollectionViewCell: UICollectionViewCell {
    
    var delegate: MineCollectionViewCellDelegate?

    let disposeBag = DisposeBag()
    ///背景
    lazy var bgImageV: UIImageView = {
        let imageV = UIImageView()
        imageV.frame = CGRect.init(x: 12, y: 5, width: kScreenWidth - 24, height: 310)
        imageV.image = UIImage.init(named: "shadow_bg")
        imageV.isUserInteractionEnabled = true
        return imageV
    }()
    
    
    ///我的收藏
    lazy var collectionItem: MineCellItem = {
        let item = MineCellItem.init(frame: CGRect.init(x: 0, y: 5, width: kScreenWidth, height: 50))
        item.iconV.image = UIImage.init(named: "mine_collection")
        item.rx.tapGesture.subscribeNext({ [unowned self](tap) in
            self.delegate?.mineCellItemDidClick(type: .MineType_CollectionItem)
        }).disposed(by: disposeBag)
        return item
    }()
    
    ///重新设置
    lazy var settingItem: MineCellItem = {
        let item = MineCellItem.init(frame: CGRect.init(x: 0, y: 5 + 50 * 1, width: kScreenWidth, height: 50))
        item.iconV.image = UIImage.init(named: "mine_setting")
        item.titleLab.text = "重新设置"
        item.rx.tapGesture.subscribeNext({ [unowned self](tap) in
            self.delegate?.mineCellItemDidClick(type: .MineType_SettingItem)
        }).disposed(by: disposeBag)
        return item
    }()
    
    ///送亲友福利
    lazy var welfareItem: MineCellItem = {
        let item = MineCellItem.init(frame: CGRect.init(x: 0, y: 5 + 50 * 2, width: kScreenWidth, height: 50))
        item.iconV.image = UIImage.init(named: "mine_welfare")
        item.titleLab.text = "送亲友福利"
        item.rx.tapGesture.subscribeNext({ [unowned self](tap) in
            self.delegate?.mineCellItemDidClick(type: .MineType_WelfareItem)
        }).disposed(by: disposeBag)
        return item
    }()
    
    ///意见反馈
    lazy var feedBackItem: MineCellItem = {
        let item = MineCellItem.init(frame: CGRect.init(x: 0, y: 5 + 50 * 3, width: kScreenWidth, height: 50))
        item.iconV.image = UIImage.init(named: "mine_feedback")
        item.titleLab.text = "意见反馈"
        item.rx.tapGesture.subscribeNext({ [unowned self](tap) in
            self.delegate?.mineCellItemDidClick(type: .MineType_FeedBackItem)
        }).disposed(by: disposeBag)
        return item
    }()
    
    ///专业资质
    lazy var qualificationItem: MineCellItem = {
        let item = MineCellItem.init(frame: CGRect.init(x: 0, y: 5 + 50 * 4, width: kScreenWidth, height: 50))
        item.iconV.image = UIImage.init(named: "mine_qualification")
        item.titleLab.text = "专业资质"
        item.rx.tapGesture.subscribeNext({ [unowned self](tap) in
            self.delegate?.mineCellItemDidClick(type: .MineType_QualificationItem)
        }).disposed(by: disposeBag)
        return item
    }()
    
    ///资源中心
    lazy var mallItem: MineCellItem = {
        let item = MineCellItem.init(frame: CGRect.init(x: 0, y: 5 + 50 * 5, width: kScreenWidth, height: 50))
        item.iconV.image = UIImage.init(named: "mine_mall")
        item.titleLab.text = "资源中心"
        item.lineV.isHidden = true
        item.rx.tapGesture.subscribeNext({ [unowned self](tap) in
            self.delegate?.mineCellItemDidClick(type: .MineType_MallItem)
        }).disposed(by: disposeBag)
        return item
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

extension MineCollectionViewCell {
    ///我的收藏点击事件
    func collectionEvent() {
        
    }
}

extension MineCollectionViewCell {
    ///添加子视图
    fileprivate func loadUI() {
        addSubviews(bgImageV)
        bgImageV.addSubviews([collectionItem, settingItem, welfareItem, feedBackItem, qualificationItem, mallItem])
    }
    
    ///布局
    fileprivate func loadFrame() {
        
    }
}
