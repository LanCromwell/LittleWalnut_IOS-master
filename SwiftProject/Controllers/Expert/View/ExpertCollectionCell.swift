//
//  ExpertCollectionCell.swift
//  SwiftProject
//
//  Created by YX on 2019/8/29.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit
import SDWebImage

class ExpertCollectionCell: UICollectionViewCell {
    
    let leftWidth: CGFloat = 100
    let itemHeight: CGFloat = 65
    let padding: CGFloat = 4
    
    lazy var containerView: UIView = {
        let layerView = UIView.init(frame: CGRect.init(x: 12, y: 10, width: kScreenWidth - 24, height: itemHeight * 2 + padding * 2))
        // shadowCode
        layerView.layer.shadowColor = UIColor(red: 0.46, green: 0.46, blue: 0.46, alpha: 0.22).cgColor
        layerView.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        layerView.layer.shadowOpacity = 1
        layerView.layer.shadowRadius = 3
        
        return layerView
    }()
    
    lazy var bgLayer: CALayer = {
        let bgLayer1 = CALayer()
        bgLayer1.frame = containerView.bounds
        bgLayer1.backgroundColor = UIColor(red: 1, green: 0.96, blue: 0.97, alpha: 1).cgColor
        return bgLayer1
    }()
    
    lazy var iconV: UIImageView = {
        let iconV = UIImageView.init()
//        iconV.contentMode = .scaleToFill
        iconV.contentMode = .scaleAspectFit
        iconV.image = UIImage.init(named: "expert_icon")
        return iconV
    }()
    
    ///标题
    lazy var titleLab: UILabel = {
        let lab = UILabel.init()
        lab.numberOfLines = 0
        lab.text = ""
        lab.textAlignment = .center
        lab.textColor = UIColor.init(r: 49, g: 49, b: 49)
        lab.font = UIFont.font(size: 15, weight: .medium)
        return lab
    }()
    
    
    ///列表控件
    fileprivate lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: CGRect.init(x: leftWidth, y: padding, width: containerView.mj_w - leftWidth - padding, height: itemHeight * 2), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(red: 1, green: 0.96, blue: 0.97, alpha: 1)
        collectionView.mt_register(cellWithClass: ExpertItem.self)
        return collectionView
    }()
    
    ///数据源
    var dataArray = [ExpertModel]()
    ///item 点击回调
    var listItemClick: ((ExpertModel) -> ())?

    var model: ExpertModel? {
        didSet {
            guard let model = model else { return}
            ///绑定数据
            titleLab.text = model.name ?? ""
            
            iconV.sd_setImage(with: URL.init(string: model.img ?? ""), placeholderImage: UIImage.init(named: "expert_icon"))

            ///刷新子界面
            dataArray = model.child ?? [ExpertModel]()
            collectionView.reloadData()
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


extension ExpertCollectionCell {
    func loadUI() {
        addSubview(containerView)
        containerView.layer.addSublayer(bgLayer)
        containerView.addSubviews([iconV, titleLab, collectionView])
    }
    
    func loadFrame() {
        iconV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 35, height: 45))
            make.left.equalTo((leftWidth - 35)/2.0)
            make.top.equalTo(25)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(iconV.snp.centerX)
            make.top.equalTo(iconV.snp.bottom).offset(5)
        }
    }
    
    func updateBgColor(_ index: IndexPath) {
        switch index.row {
        case 0:
            bgLayer.backgroundColor = UIColor.init(r: 255, g: 245, b: 247).cgColor
            collectionView.backgroundColor = UIColor.init(r: 255, g: 245, b: 247)
        case 1:
            bgLayer.backgroundColor = UIColor.init(r: 255, g: 250, b: 245).cgColor
            collectionView.backgroundColor = UIColor.init(r: 255, g: 250, b: 245)
        case 2:
            bgLayer.backgroundColor = UIColor.init(r: 255, g: 245, b: 247).cgColor
            collectionView.backgroundColor = UIColor.init(r: 255, g: 245, b: 247)
        case 3:
            bgLayer.backgroundColor = UIColor.init(r: 246, g: 253, b: 249).cgColor
            collectionView.backgroundColor = UIColor.init(r: 246, g: 253, b: 249)
        default:
            bgLayer.backgroundColor = UIColor.init(r: 242, g: 250, b: 255).cgColor
            collectionView.backgroundColor = UIColor.init(r: 242, g: 250, b: 255)
        }
    }
}

//MARK:-  UICollectionView 代理
extension ExpertCollectionCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.mj_w - padding)/3.0, height: itemHeight)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ExpertItem = collectionView.mt_dequeueReusableCell(withClass: ExpertItem.self, for: indexPath)
        let model = self.dataArray[indexPath.row]
        cell.model = model
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = dataArray[indexPath.row]
        listItemClick?(model)
    }
    
    
    
}
