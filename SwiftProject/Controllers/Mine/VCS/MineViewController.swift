//
//  MineViewController.swift
//  SwiftProject
//
//  Created by YX on 2019/7/20.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit

class MineViewController: BaseViewController {
    
    ///列表控件
    fileprivate lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        // layout.sectionHeadersPinToVisibleBounds = true
        layout.minimumLineSpacing = 10 * kWIDTHBASE
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - kBottomHeight), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.mt_register(cellWithClass: UICollectionViewCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        ///注册头
        collectionView.register(MineHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MineHeaderReusableView")
        ///注册cell
        collectionView.mt_register(cellWithClass: MineCollectionViewCell.self)
        collectionView.mt_register(cellWithClass: MineLogoutItem.self)

        return collectionView
    }()
    
    
    var userInfo: UserInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationView.title = "我的"
        view.backgroundColor = UIColor.purple
        view.addSubview(collectionView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        obtainUserInfo()
    }
    

}


///MARK:-
extension MineViewController {
    fileprivate func obtainUserInfo() {
        var uInfo = UserInfo.default.findUserInfo()
        loginProvider.request(.userInfoAPI(user_info: uInfo!.id!)) { [weak self](result) in
            switch result {
            case .success(let res):
                let jsonStr = String.init(data: res.data, encoding: .utf8)
                try? print("result.mapJSON() = \(res.mapJSON())")
                if let model = BaseModel.deserialize(from: jsonStr) {
                    if model.code == 200 {
                        let userInfo = UserInfo.deserialize(from: model.data as? [String: Any])
                        self?.userInfo = userInfo
                        uInfo = userInfo

//                        uInfo?.invite_info = userInfo?.invite_info;
//                        uInfo?.is_receive_vip = userInfo?.is_receive_vip;
                        uInfo?.saveUserInfo()
                        self?.collectionView.reloadData()
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
extension MineViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: kScreenWidth, height: 315)
        } else {
            return CGSize(width: kScreenWidth, height: 100)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell: MineCollectionViewCell = collectionView.mt_dequeueReusableCell(withClass: MineCollectionViewCell.self, for: indexPath)
            cell.delegate = self as MineCollectionViewCellDelegate
            return cell
        }
        
        let cell: MineLogoutItem = collectionView.mt_dequeueReusableCell(withClass: MineLogoutItem.self, for: indexPath)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: kScreenWidth, height: kStatusHeight + 240 * kWIDTHBASE)
    }
    
    //.添加header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            let headerView: MineHeaderReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MineHeaderReusableView", for: indexPath) as! MineHeaderReusableView
            headerView.model = userInfo
            return headerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            print("退出登录")
            logoutEvent()

        }
    }
    
    
    
}

//MARK:- MineCollectionViewCellDelegate
extension MineViewController: MineCollectionViewCellDelegate {
    func mineCellItemDidClick(type: MineType) {
        switch type {
        case .MineType_CollectionItem:
            print("我的收藏")
            gotoCollectionVC()
            
        case .MineType_SettingItem:
            print("重新设置")
            gotoSettingVC()
            
        case .MineType_WelfareItem:
            print("送亲友福利")
            gotoInvitationCodeVC()
        case .MineType_FeedBackItem:
            print("意见反馈")
            gotoFeedbackVC()
            
        case .MineType_QualificationItem:
            print("专业资质")
            gotoQualificationWebView()
        case .MineType_MallItem:
            print("积分商城")
            gotoMallWebView()
        }
    }
    
    ///去收藏
    func gotoCollectionVC() {
        let collectionVC = CollectionViewController()
        navigationController?.pushViewController(collectionVC, animated: true)
    }
    
    
    ///去设置
    func gotoSettingVC() {
        let firstVC = SettingFirstViewController()
        navigationController?.pushViewController(firstVC, animated: true)
    }
    
    ///意见反馈
    func gotoFeedbackVC() {
        let firstVC = FeedbackVC()
        navigationController?.pushViewController(firstVC, animated: true)
    }
    
    ///我的邀请码
    func gotoInvitationCodeVC() {
        let firstVC = FXJ_InvitationCodeVC()
        firstVC.userInfo = userInfo
        navigationController?.pushViewController(firstVC, animated: true)
    }
    
    //MARK: - 专业资质
    func gotoQualificationWebView() {
        let webView = WebViewController()
        webView.navigationView.titleLabel.text = "专业资质"
        webView.filePath = "http://www.mamaucan.com.cn/thanks"
        webView.navigationView.leftButton.setTitle(" 返回", for: UIControl.State.normal)
        webView.navigationView.leftButton.setTitleColor(UIColor.hexInt(0x999999), for: UIControl.State.normal)
        webView.navigationView.leftButton.titleLabel?.font = UIFont.font(size: 13, weight: .medium)
        navigationController?.pushViewController(webView, animated: true)
    }
    
    //MARK: - 积分商城
    func gotoMallWebView() {
        let webView = WebViewController()
        webView.filePath = "http://www.mamaucan.com.cn/club"
        webView.navigationView.titleLabel.text = "积分商城"
        webView.navigationView.leftButton.setTitle(" 返回", for: UIControl.State.normal)
        webView.navigationView.leftButton.setTitleColor(UIColor.hexInt(0x999999), for: UIControl.State.normal)
        webView.navigationView.leftButton.titleLabel?.font = UIFont.font(size: 13, weight: .medium)
        navigationController?.pushViewController(webView, animated: true)
    }
}


//MARK:- 事件处理
extension MineViewController {
    ///登出
    fileprivate func logoutEvent() {
        let userInfo = UserInfo.default.findUserInfo()
        let thridname = "xht" + (userInfo?.id ?? "")
        UMessage.removeAlias(thridname, type: "xht_app") { (responseObject, error) in
             print(responseObject as Any,error as Any);
        }
        UserInfo.default.removeUserInfo()
        GlobalUIManager.loadLoginVC()
                               
    }
}
