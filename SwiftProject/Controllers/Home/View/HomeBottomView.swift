//
//  HomeBottomView.swift
//  SwiftProject
//
//  Created by YX on 2019/7/27.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit

class HomeBottomView: UIView {
    
    lazy var startTimeLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(gray: 51)
        lab.text = "00:00"
        lab.textAlignment = .left
        lab.font = UIFont.font(size: 11, weight: .regular)
        lab.textColor = UIColor.white
        return lab
    }()
    
    lazy var endTimeLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(gray: 51)
        lab.text = "00:00"
        lab.textAlignment = .right
        lab.font = UIFont.font(size: 11, weight: .regular)
        lab.textColor = UIColor.white
        return lab
    }()
    
    lazy var progressView: UISlider = {
        let progress = UISlider()
        progress.minimumValue = 0.0
        progress.maximumValue = 1.0
        progress.value = 0.0
        progress.isEnabled = false
        progress.minimumTrackTintColor = UIColor.init(r: 255, g: 111, b: 100)
        progress.maximumTrackTintColor = UIColor.white
        progress.setThumbImage(UIImage.init(named: "truck"), for: .normal)
        return progress
    }()
    
    ///播放按钮
    lazy var playerBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: "player-icon"), for: .normal)
        btn.setImage(UIImage.init(named: "pause-icon"), for: .selected)
        return btn
    }()
    
    ///收藏
    lazy var favoriteBtn: UIButton = {
        let btn = UIButton()
//        btn.setImage(UIImage.init(named: "favorite-icon"), for: .normal)
//        btn.setImage(UIImage.init(named: "favorite-icon-selected"), for: .selected)
        btn.setImage(UIImage.init(named: "favorite-icon-selected"), for: .normal)
        btn.setImage(UIImage.init(named: "favorite-icon"), for: .selected)
        return btn
    }()
    
     ///历史记录
        lazy var historyBtn: UIButton = {
            let btn = UIButton()
            btn.setImage(UIImage.init(named: "历史记录"), for: .normal)
//            btn.setImage(UIImage.init(named: "favorite-icon"), for: .selected)
            return btn
        }()
    
    //文案
    lazy var textListBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: "文稿"), for: .normal)
//        btn.setImage(UIImage.init(named: "favorite-icon"), for: .selected)
        return btn
    }()
    
    
    ///分享
    lazy var shareBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: "share-icon"), for: .normal)
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


extension HomeBottomView {
    ///添加视图
    fileprivate func loadUI() {
        addSubviews([startTimeLab, progressView, endTimeLab])
        addSubview(playerBtn)
        addSubview(favoriteBtn)
        addSubview(shareBtn)
        addSubview(historyBtn)
        addSubview(textListBtn)

    }
    
    ///布局
    fileprivate func loadFrame() {
        startTimeLab.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 55, height: 30))
            make.top.equalTo(20)
            make.left.equalTo(30)
        }
        
        endTimeLab.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 55, height: 30))
            make.right.equalTo(-30)
            make.top.equalTo(20)
        }
        
        progressView.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.left.equalTo(30)
            make.right.equalTo(-30)
        }
        
        playerBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 55 * kWIDTHBASE , height: 55 * kWIDTHBASE ))
            make.top.equalTo(startTimeLab.snp.bottom).offset(0 * kWIDTHBASE)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        favoriteBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 55 * kWIDTHBASE, height: 55 * kWIDTHBASE))
            make.top.equalTo(startTimeLab.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX).offset(-85)
        }
        
        historyBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 55 * kWIDTHBASE, height: 55 * kWIDTHBASE))
            make.left.equalTo(self.snp.left).offset(30*kWIDTHBASE)
            make.centerY.equalTo(favoriteBtn.snp.centerY)
        }
        
        shareBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 55 * kWIDTHBASE, height: 55 * kWIDTHBASE))
            make.top.equalTo(startTimeLab.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX).offset(85)
        }
        
        textListBtn.snp.makeConstraints { (make) in
               make.size.equalTo(CGSize.init(width: 55 * kWIDTHBASE, height: 55 * kWIDTHBASE))
               make.right.equalTo(self.snp.right).offset(-30*kWIDTHBASE)
               make.centerY.equalTo(shareBtn.snp.centerY)
           }
               
        
    }
}
