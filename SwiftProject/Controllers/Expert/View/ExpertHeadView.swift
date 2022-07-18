//
//  ExpertHeadView.swift
//  SwiftProject
//
//  Created by YX on 2019/8/29.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit

class ExpertHeadView: UIView {
    
    ///渐变背景
    lazy var bgLayer: CAGradientLayer = {
        let bgLayer = CAGradientLayer()
        bgLayer.colors = [UIColor(red: 1, green: 0.76, blue: 0.39, alpha: 1).cgColor, UIColor(red: 1, green: 0.44, blue: 0.39, alpha: 1).cgColor, UIColor(red: 1, green: 0.23, blue: 0.4, alpha: 1).cgColor]
        bgLayer.locations = [0, 0.83, 1]
        bgLayer.frame = self.bounds
        bgLayer.startPoint = CGPoint(x: 1, y: 1)
        bgLayer.endPoint = CGPoint(x: -0.04, y: -0.04)
        return bgLayer
    }()
    
    ///搜索背景
    lazy var searchBgV: UIImageView = {
        let layerView = UIImageView.init(frame:CGRect.init(x: 12, y: kStatusHeight + 4, width: kScreenWidth - 24, height: 36))
        layerView.isUserInteractionEnabled = true
        layerView.image = UIImage.init(named: "s")?.resizableImage(withCapInsets: UIEdgeInsets.init(top: 0, left: 200, bottom: 0, right: 200), resizingMode: .stretch)
        return layerView
    }()
    
    ///icon
    lazy var iconV: UIImageView = {
        let iconV = UIImageView.init()
        iconV.frame = CGRect.init(x: 12, y: 12, width: 12, height: 12)
        iconV.image = UIImage.init(named: "search_icon")
        return iconV
    }()
    
    ///搜索输入框
    lazy var searchTF: UITextField = {
        let inputTF = UITextField()
        inputTF.frame = CGRect.init(x: 36, y: 0, width: searchBgV.mj_w - 50, height: 36)
        inputTF.textColor = UIColor.white
//        inputTF.setValue(UIFont.font(size: 12, weight: .regular) ,forKeyPath: "_placeholderLabel.font")
//        inputTF.setValue(UIColor.red, forKeyPath: "_placeholderLabel.textColor")
        inputTF.font = UIFont.font(size: 12, weight: .regular)
        inputTF.clearButtonMode = .whileEditing
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.font(size: 12, weight: .regular)]
        let placeHolderString = NSMutableAttributedString.init(string: "婴儿腹泻", attributes: attributes as [NSAttributedString.Key : Any])
        inputTF.attributedPlaceholder = placeHolderString
        inputTF.returnKeyType = UIReturnKeyType.search
        inputTF.delegate = self
        return inputTF
    }()
    
    var dataArray = [ExpertModel]()
    
    var searchTextCallBack: ((String?) -> ())?

    
    var model: ExpertModel? {
        didSet {
            guard let model = model else { return}
            ///绑定数据
            dataArray = model.child ?? [ExpertModel]()
            collectionView.reloadData()
        }
    }

    ///列表控件
    fileprivate lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: CGRect.init(x: 12, y: kStatusHeight + 50, width: kScreenWidth - 24, height: 40), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.mt_register(cellWithClass: SearchItem.self)
        return collectionView
    }()
    
    ///header item 点击回调
    var headItemClick: ((ExpertModel) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadUI()
        loadFrame()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ExpertHeadView {
    func loadUI() {
        layer.addSublayer(bgLayer)
        addSubview(searchBgV)
        searchBgV.addSubviews([iconV, searchTF])
        addSubview(collectionView)
    }
    
    func loadFrame() {
        
    }
    

}


//MARK:-  UICollectionView 代理
extension ExpertHeadView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 80, height: collectionView.mj_h)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SearchItem = collectionView.mt_dequeueReusableCell(withClass: SearchItem.self, for: indexPath)
        cell.model = dataArray[indexPath.row]
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = dataArray[indexPath.row]
        headItemClick?(model)
    }
    
    
    
}

extension ExpertHeadView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextCallBack?(textField.text)
        return true
    }
}

