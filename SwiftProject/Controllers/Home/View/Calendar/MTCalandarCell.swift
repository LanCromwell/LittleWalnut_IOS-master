//
//  MTCalandarCell.swift
//  SwiftProject
//
//  Created by YX on 2019/7/26.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit

class MTCalandarCell: UICollectionViewCell {
    
    let timeStamp = u_long(NSDate().timeIntervalSince1970)
    
    let itemW = (kScreenWidth - 2 * 12.0 - 5.0 * 2) / 7.0
    
    lazy var bgImageV: UIImageView = {
        let imageV = UIImageView()
        imageV.isUserInteractionEnabled = true
        imageV.layer.cornerRadius = itemW/2.0 - 2
        imageV.layer.masksToBounds = true
        return imageV
    }()
    
    lazy var titleLab: UILabel = {
        let titleLab = UILabel()
        titleLab.textColor = UIColor.init(gray: 51)
        titleLab.textAlignment = .center
        titleLab.font = UIFont.font(size: 16, weight: .thin)
        return titleLab
    }()
    
    lazy var subTitleLab: UILabel = {
        let titleLab = UILabel()
        titleLab.textColor = UIColor.init(gray: 90)
        titleLab.textAlignment = .center
        titleLab.font = UIFont.font(size: 9, weight: .thin)
        return titleLab
    }()
    
    var model: MTCalandarModel? {
        didSet {
            guard let model = model else {
                return
            }
                        
            if model.type == .currentMonth {
                titleLab.text = model.solarStr
                subTitleLab.text = model.lunarStr
                if model.isToday { // 今天
                    titleLab.textColor = UIColor.white
                    subTitleLab.textColor = UIColor.white
                    bgImageV.backgroundColor = UIColor.init(r: 255, g: 154, b: 69)
                } else if model.isSelected { // 选中
                    titleLab.textColor = UIColor.init(gray: 51)
                    subTitleLab.textColor = UIColor.init(gray: 90)
                    bgImageV.backgroundColor = UIColor.init(r: 238, g: 238, b: 238)
                } else if model.data?.is_study == 1 { // 已学习
                    titleLab.textColor = UIColor.white
                    subTitleLab.textColor = UIColor.white
                    bgImageV.backgroundColor = UIColor.init(r: 96, g: 206, b: 135)

                }else if model.data?.is_study == 0
                    
                {
                    // 未学习
                    titleLab.textColor = UIColor.init(gray: 51)
                    subTitleLab.textColor = UIColor.init(gray: 90)

                    let date = model.date as NSDate
                    let dateStamp:TimeInterval = date.timeIntervalSince1970
                    let dateStr:u_long = u_long(dateStamp)
                    
                    print(self.timeStamp) // 当前时间戳
                    if self.timeStamp > dateStr {
                          print("当前时间之前")
                    bgImageV.backgroundColor = UIColor.init(r: 238, g: 238, b: 238)

                    }else{
                         print("当前时间之后")
                        bgImageV.backgroundColor = UIColor.white
                    }
                }
                else { // 默认
                    titleLab.textColor = UIColor.init(gray: 51)
                    subTitleLab.textColor = UIColor.init(gray: 90)
                    bgImageV.backgroundColor = UIColor.white
                }
               
            } else {
                titleLab.text = ""
                subTitleLab.text = ""
                titleLab.textColor = UIColor.init(gray: 176)
                subTitleLab.textColor = UIColor.init(gray: 176)
                bgImageV.backgroundColor = UIColor.white
            }
            
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


extension MTCalandarCell {
    fileprivate func loadUI() {
        contentView.addSubview(bgImageV)
        bgImageV.addSubviews([titleLab, subTitleLab])
    }
    
    fileprivate func loadFrame() {
        
        bgImageV.snp.makeConstraints { (make) in
            make.top.equalTo(2)
            make.left.equalTo(2)
            make.bottom.equalTo(-2)
            make.right.equalTo(-2)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(bgImageV.snp.centerY).offset(4)
        }
        
        subTitleLab.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(bgImageV.snp.centerY).offset(5)
        }
    }
}
