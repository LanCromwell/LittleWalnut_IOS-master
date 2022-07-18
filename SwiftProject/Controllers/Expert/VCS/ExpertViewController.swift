//
//  ExpertViewController.swift
//  SwiftProject
//
//  Created by YX on 2019/7/25.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit
import HWPopController

class ExpertViewController: BaseViewController {
    
    ///头视图
    lazy var headerView: ExpertHeadView = {
        let headerV = ExpertHeadView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kStatusHeight + 120))
        headerV.headItemClick = { [weak self] model in
            print(model)
            let entry = model as ExpertModel
            self?.gotoSearchVC_audioList(entry.id)
        }
        
        headerV.searchTextCallBack = { [weak self] text in
            self?.gotoSearchVC(text)
        }
        
        return headerV
    }()
    
    ///bottom
    lazy var bottomView: UIView = {
        let bottomView = UIView.init(frame: CGRect.init(x: 0, y: kStatusHeight + 103, width: kScreenWidth, height: kScreenHeight - kStatusHeight - 103))
        let bgLayer = CALayer()
        bgLayer.frame = bottomView.bounds
        bgLayer.cornerRadius = 5
        bgLayer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        bottomView.layer.addSublayer(bgLayer)
        // shadowCode
        bottomView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        bottomView.layer.shadowOffset = CGSize(width: 0, height: 1)
        bottomView.layer.shadowOpacity = 1
        bottomView.layer.shadowRadius = 2
        return bottomView
    }()
    
    
    ///列表控件
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets.init(top: 6, left: 0, bottom: 16, right: 0)
        
        let collectionView = UICollectionView(frame: CGRect.init(x: 0, y: 3, width: kScreenWidth, height: bottomView.mj_h - kBottomHeight - 3), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.mt_register(cellWithClass: ExpertCollectionCell.self)
        return collectionView
    }()
    
    
    ///数据源
    var dataArray = [ExpertModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
        loadFrame()
        ///获取数据
        obtainListData()
        obtainUserInfo()
    }
}


extension ExpertViewController {
    func loadUI() {
        view.addSubview(headerView)
        view.addSubview(bottomView)
        bottomView.addSubviews(collectionView)
    }
    
    
    func loadFrame() {
        
    }
}

///MARK: - 事件
extension ExpertViewController {
    ///获取 列表数据
    fileprivate func obtainListData() {
        homeProvider.request(.expertListApi) { [weak self](result) in
            print(result)
            switch result {
            case .success(let res):
                let jsonStr = String.init(data: res.data, encoding: .utf8)
                try? print("result.mapJSON() = \(res.mapJSON())")
                if let model = BaseModel.deserialize(from: jsonStr) {
                    if model.code == 200 {
                        if let array = [ExpertModel].deserialize(from: model.data as? [Any]) {
                            self?.dataArray = array as! [ExpertModel]
                            self?.collectionView.reloadData()
                            self!.headerView.model = self?.dataArray.first
                        }
                    } else {
                        self?.view.makeToast(model.msg, position: .center)
                    }
                }
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
   
}



//MARK:-  UICollectionView 代理
extension ExpertViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: kScreenWidth, height: 65 * 2 + 28)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ExpertCollectionCell = collectionView.mt_dequeueReusableCell(withClass: ExpertCollectionCell.self, for: indexPath)
        let model = self.dataArray[indexPath.row + 1]
        cell.model = model
        cell.updateBgColor(indexPath)
        
        cell.listItemClick = {[weak self] model in
            let entry = model as ExpertModel
            self?.gotoSearchVC_audioList(entry.id)
        }
        
        return cell
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    }
    
    
    
}


extension ExpertViewController {
    // 搜索
    fileprivate func gotoSearchVC(_ content: String?) {
        let searchVC = SearchViewController()
        searchVC.content = content
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    // id去列表
    fileprivate func gotoSearchVC_audioList(_ audioId: String?) {
           let searchVC = SearchViewController()
           searchVC.audioId = audioId
           self.navigationController?.pushViewController(searchVC, animated: true)
       }
    
    //MARK: - 新人红包
    fileprivate func popEvent() {
        let popVC = FXJ_InvitationNewPeopleVC()
        let popController = HWPopController.init(viewController: popVC)
        popController.popPosition = .center
        popController.present(in: self)
    }
    
    // 获取用户信息
    func obtainUserInfo() {
        let uInfo = UserInfo.default.findUserInfo()
        loginProvider.request(.userInfoAPI(user_info: uInfo!.id!)) { [weak self](result) in
            switch result {
            case .success(let res):
                let jsonStr = String.init(data: res.data, encoding: .utf8)
                try? print("result.mapJSON() = \(res.mapJSON())")
                if let model = BaseModel.deserialize(from: jsonStr) {
                    if model.code == 200 {
                        let userInfo = UserInfo.deserialize(from: model.data as? [String: Any])
                        uInfo?.invite_info = userInfo?.invite_info;
                        uInfo?.is_receive_vip = userInfo?.is_receive_vip;
                        uInfo?.saveUserInfo()
                        let is_receive_vip = userInfo?.is_receive_vip
                        if is_receive_vip != nil {
                            if  Int(is_receive_vip!) == 0{
                                self?.popEvent()
                            }
                        }
                    } else {
                        self?.view.makeToast(model.msg, position: .center)
                    }
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
