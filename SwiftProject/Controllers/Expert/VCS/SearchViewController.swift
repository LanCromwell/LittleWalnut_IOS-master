//
//  SearchViewController.swift
//  SwiftProject
//
//  Created by YX on 2019/9/12.
//  Copyright © 2019 MT. All rights reserved.
//



import UIKit
import DZNEmptyDataSet
import DFPlayer
import MJRefresh


class SearchViewController: BaseViewController {
    
    ///搜索字段
    var content: String?
    ///搜索字段
      var audioId: String?
    /// 列表数据源
    var dataArray = [SearchModel]()
    ///播放音频源
    var playerM: DFPlayerModel?
    ///上次点击的
    var lastIndexPath: IndexPath?
    ///分页
    var page: Int = 1
    ///分页大小
    var page_size: Int = 8
    
    var audioPlayer: AVAudioPlayer?

    
    //topView
    lazy var topView: UIView = {
        let topView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 146 + kStatusHeight))
        return topView
    }()
    
    
    ///渐变背景
    lazy var bgLayer: CAGradientLayer = {
        let bgLayer = CAGradientLayer()
        bgLayer.colors = [UIColor(red: 1, green: 0.76, blue: 0.39, alpha: 1).cgColor, UIColor(red: 1, green: 0.44, blue: 0.39, alpha: 1).cgColor, UIColor(red: 1, green: 0.23, blue: 0.4, alpha: 1).cgColor]
        bgLayer.locations = [0, 0.83, 1]
        bgLayer.frame = topView.bounds
        bgLayer.startPoint = CGPoint(x: 1, y: 1)
        bgLayer.endPoint = CGPoint(x: -0.04, y: -0.04)
        return bgLayer
    }()
    
    lazy var titleLab: UILabel = {
        let lab = UILabel.init()
        lab.text = "搜索结果"
        lab.textAlignment = .center
        lab.textColor = UIColor.white
        lab.font = UIFont.font(size: 18, weight: .semibold)
        return lab
    }()
    
    lazy var backButton: UIButton = {
        let btn = UIButton.init()
        btn.imageView?.contentMode = .center
        btn.setImage(UIImage.init(named: "back-icon-white"), for: .normal)
        btn.addTarget(self, action: #selector(backEvent), for: .touchUpInside)
        return btn
    }()
    
    ///bottom
    lazy var bottomView: UIView = {
        let bottomView = UIView.init(frame: CGRect.init(x: 12, y: kStatusHeight + 60, width: kScreenWidth - 24, height: kScreenHeight - kStatusHeight - 60))
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
        
        let collectionView = UICollectionView(frame: CGRect.init(x: 2, y: 2, width: bottomView.mj_w - 4, height: bottomView.mj_h - 4), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.emptyDataSetSource  = self
        collectionView.emptyDataSetDelegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.mt_register(cellWithClass: SearchListCell.self)
        
        collectionView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.obtainListData()
        })
        
        collectionView.mj_footer = MJRefreshBackFooter.init(refreshingBlock: {
            self.loadMore()
        })
        
        return collectionView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
        loadFrame()
        ///获取网络数据
        obtainListData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ///初始化播放控件
        initDFPlayer()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DFPlayer.shared().df_deallocPlayer()
        audioPlayer?.stop()
        audioPlayer = nil
    }
    
    
}



extension SearchViewController {
    func loadUI() {
        view.addSubview(topView)
        topView.layer.addSublayer(bgLayer)
        topView.addSubview(titleLab)
        topView.addSubview(backButton)
        view.addSubview(bottomView)
        bottomView.addSubview(collectionView)
    }
    
    func loadFrame() {
        backButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 60, height: 44))
            make.top.equalTo(kStatusHeight)
            make.left.equalTo(0)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(kStatusHeight)
            make.height.equalTo(44)
        }
    }
    
    ///初始化播放器
    fileprivate func initDFPlayer() {
//        DFPlayer.shareInstance()?.df_initPlayer(withUserId: nil)
//        DFPlayer.shareInstance()?.dataSource = self
//        DFPlayer.shareInstance()?.delegate = self
//        DFPlayer.shareInstance()?.playMode = .onlyOnce
//        ///设置完数据后 需要刷新一下
//        DFPlayer.shareInstance()?.df_reloadData()
//        DFPlayer.shareInstance()?.category = .playback
        
        DFPlayer.shared()?.df_initPlayer(withUserId: nil)
        DFPlayer.shared()?.dataSource = self
       DFPlayer.shared()?.delegate = self
       DFPlayer.shared()?.playMode = .onlyOnce
       ///设置完数据后 需要刷新一下
       DFPlayer.shared()?.df_reloadData()
//       DFPlayer.shared()?.category =
    }

    
    
    ///返回事件
    @objc fileprivate func backEvent() {
        self.navigationController?.popViewController(animated: true)
    }
    
    ///获取 列表数据
    fileprivate func obtainListData() {
//        guard let content = content else {
//
//        }
        page = 1
        let userInfo = UserInfo.default.findUserInfo()
        var params : [String : Any]
        let requestUrl : HomeAPI
        if content != nil {
            params = ["page": page, "page_size": page_size, "search_content": content ?? "", "user_id": userInfo?.id ?? ""] as [String : Any]
            requestUrl = HomeAPI.expertSearchApi(params: params)
        }else if audioId != nil {
            params = ["page": page, "page_size": page_size, "type": audioId ?? "", "user_id": userInfo?.id ?? ""] as [String : Any]
            requestUrl = HomeAPI.expertAudioListApi(params: params)
        }else{
            return
        }
        
       
        homeProvider.request(requestUrl) { [weak self](result) in
            switch result {
            case .success(let res):
                let jsonStr = String.init(data: res.data, encoding: .utf8)
                try? print("result.mapJSON() = \(res.mapJSON())")
                self?.collectionView.mj_header?.endRefreshing()
                if let model = BaseModel.deserialize(from: jsonStr) {
                    
                    if model.code == 200 {
                        let dict = model.data as! [String: Any]
                        if let array = [SearchModel].deserialize(from: dict["data"] as? [Any]) {
                            self?.dataArray  = array as! [SearchModel]
                            self?.collectionView.reloadData()
                        }
                    } else {
                        self?.view.makeToast(model.msg, position: .center)
                    }
                }
                
                
            case .failure(let error):
                self?.collectionView.mj_header?.endRefreshing()
                print(error)
            }
        }
    }
    
    
    fileprivate func loadMore() {
//        guard let content = content else { return  }
        page += 1
//        let userInfo = UserInfo.default.findUserInfo()
//        let params = ["page": page, "page_size": page_size, "search_content": content, "user_id": userInfo?.id ?? ""] as [String : Any]
        let userInfo = UserInfo.default.findUserInfo()
       var params : [String : Any]
       let requestUrl : HomeAPI
       if content != nil {
           params = ["page": page, "page_size": page_size, "search_content": content ?? "", "user_id": userInfo?.id ?? ""] as [String : Any]
           requestUrl = HomeAPI.expertSearchApi(params: params)
       }else if audioId != nil {
           params = ["page": page, "page_size": page_size, "type": audioId ?? "", "user_id": userInfo?.id ?? ""] as [String : Any]
           requestUrl = HomeAPI.expertAudioListApi(params: params)
       }else{
           return
       }
        
        homeProvider.request(requestUrl) { [weak self](result) in
            switch result {
            case .success(let res):
                let jsonStr = String.init(data: res.data, encoding: .utf8)
                try? print("result.mapJSON() = \(res.mapJSON())")
                self?.collectionView.mj_footer?.endRefreshing()
                if let model = BaseModel.deserialize(from: jsonStr) {
                    
                    if model.code == 200 {
                        let dict = model.data as! [String: Any]
                        if let array = [SearchModel].deserialize(from: dict["data"] as? [Any]) {
                            self?.dataArray += array as! [SearchModel]
                            self?.collectionView.reloadData()
                        }
                    } else {
                        self?.view.makeToast(model.msg, position: .center)
                    }
                }
                
                
            case .failure(let error):
                self?.collectionView.mj_footer?.endRefreshing()
                print(error)
            }
        }
    }
    
    
    ///播放鼓励音频
    fileprivate func playEndMp3() {
        let url: URL?
        let userInfo = UserInfo.default.findUserInfo()
        if userInfo?.role_id! == "2" {
            url = Bundle.main.url(forResource: "father_good", withExtension: "mp3")
        } else if userInfo?.role_id! == "1" {
            url = Bundle.main.url(forResource: "mather_good", withExtension: "mp3")
        } else {
            url = Bundle.main.url(forResource: "gradfather_good", withExtension: "mp3")
        }
        audioPlayer = try?  AVAudioPlayer.init(contentsOf: url!)
        audioPlayer?.prepareToPlay()
        audioPlayer?.play()
        print(userInfo?.role_id! as Any)
    }
}



//MARK:-  UICollectionView 代理
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.mj_w, height: 70)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SearchListCell = collectionView.mt_dequeueReusableCell(withClass: SearchListCell.self, for: indexPath)
        cell.index = indexPath
        cell.model = dataArray[indexPath.row]
        ///分享
        cell.searchShareCallBack = { [weak self] model, index in
            self?.shareEvent(model, index: index)
        }
        
        ///播放
        cell.searchPlayerCallBack  = { [weak self] model, index in
            self?.playerEvent(model, index: index)
        }
        
        ///点赞
        cell.searchFavoriteCallBack = { [weak self] model, index in
            self?.favoriteEvent(model, index: index)
        }
        return cell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         print(indexPath.row)
         let model = dataArray[indexPath.row]
        self.playerEvent(model, index: indexPath)
    }
    
    
    
}


extension SearchViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.init(r: 153, g: 153, b: 153), NSAttributedString.Key.font: UIFont.font(size: 14, weight: .regular)]
        let string = NSMutableAttributedString.init(string: "暂无相关内容", attributes: attributes as [NSAttributedString.Key : Any])
        return string
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: "expert_no_data")
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -110
    }
    
    func spaceHeight(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 15
    }
}


///MARK:- DFPlayerDataSource DFPlayerDelegate
extension SearchViewController: DFPlayerDataSource, DFPlayerDelegate {
    func df_audioData(for player: DFPlayer!) -> [DFPlayerModel]! {
         return [playerM ?? DFPlayerModel.init()]
    }
    
    ///数据源
    func df_playerModelArray() -> [DFPlayerModel]! {
        return [playerM ?? DFPlayerModel.init()]
    }
    
    ///音频将要加入播放队列
    func df_playerAudioWillAdd(toPlayQueue player: DFPlayer!) {
        print("1.totalTimer\(player.totalTime)")
    }
    
    ///准备播放
    func df_playerReady(toPlay player: DFPlayer!) {
        print("2.totalTimer\(player.totalTime)")
    }
    
    ///缓冲进度代理
    func df_player(_ player: DFPlayer!, bufferProgress: CGFloat, totalTime: CGFloat) {
        print("3.totalTimer\(player.totalTime)")
    }
    
    ///播放进度代理
    func df_player(_ player: DFPlayer!, progress: CGFloat, currentTime: CGFloat, totalTime: CGFloat) {}
    
    ///播放完成
    func df_playerDidPlay(toEndTime player: DFPlayer!) {
        playEndMp3()
    }
    
}




extension SearchViewController {
    ///分享事件
    fileprivate func shareEvent(_ model: SearchModel?, index: IndexPath?) {
        let userInfo = UserInfo.default.findUserInfo()
        guard let invite_info = userInfo?.invite_info else { return }
        
        UMSocialUIManager.setPreDefinePlatforms([
            NSNumber(integerLiteral:UMSocialPlatformType.wechatSession.rawValue),
            NSNumber(integerLiteral:UMSocialPlatformType.QQ.rawValue),
            NSNumber(integerLiteral:UMSocialPlatformType.qzone.rawValue),
            NSNumber(integerLiteral:UMSocialPlatformType.wechatTimeLine.rawValue)
            ])
        
        UMSocialUIManager.showShareMenuViewInWindow { (platformType, userInfo) in
            //创建分享消息对象
            let messageObject = UMSocialMessageObject()
            let thumbURL = "https://mamaucan.oss-cn-beijing.aliyuncs.com/xiaohetao.png"
            //分享消息对象设置分享内容对象
            let shareObject = UMShareWebpageObject.shareObject(withTitle: invite_info.title ?? "", descr: invite_info.description ?? "", thumImage: thumbURL)
            //设置网页地址
            shareObject?.webpageUrl = invite_info.href
            messageObject.shareObject = shareObject
            //调用分享接口
            UMSocialManager.default().share(to: platformType, messageObject: messageObject, currentViewController: self, completion: { (data, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
            })
            
        }
        
    }
    
    ///播放事件
    fileprivate func playerEvent(_ model: SearchModel?, index: IndexPath?) {
        guard let index = index else {
            return
        }
        
        let model = dataArray[index.row]
        
        ///重置播放源
        let urlPath = model.audio_path ?? ""
        let entry = DFPlayerModel.init()
        entry.audioUrl = NSURL.init(string: urlPath)! as URL
        entry.audioId = UInt(model.id ?? 0)
        playerM = entry
        
        ///设置完数据后 需要刷新一下
        DFPlayer.shared()?.df_reloadData()
        dataArray = dataArray.map { (item) -> SearchModel in
            item.isPlaying = false
            return item
        }
        
        ///切换新歌
        if lastIndexPath == nil || lastIndexPath?.row != index.row {
            DFPlayer.shared()?.df_play(withAudioId: 0)
            model.isPlaying = true
        } else {
            if DFPlayer.shared()?.state == DFPlayerState.playing {
                DFPlayer.shared()?.df_pause()
                model.isPlaying = false
            } else if DFPlayer.shared()?.state == DFPlayerState.pause {
                DFPlayer.shared().df_play()
                model.isPlaying = true
            }
        }
        
        dataArray[index.row] = model
        collectionView.reloadData()
        
        lastIndexPath = index
        
    }
    
    ///点赞事件0
    fileprivate func favoriteEvent(_ model: SearchModel?, index: IndexPath?) {
        guard let index = index else { return }
        let smodel: SearchModel = dataArray[index.row]
        let userInfo = UserInfo.default.findUserInfo()
        let params = ["user_id": userInfo?.id ?? "", "audio_id": smodel.id ?? 0] as [String : Any]
        homeProvider.request(.homeCollectAudioAPI(params: params)) { [weak self](result) in
            print(result)
            switch result {
            case .success(let res):
                let jsonStr = String.init(data: res.data, encoding: .utf8)
                try? print("result.mapJSON() = \(res.mapJSON())")
                if let model = BaseModel.deserialize(from: jsonStr) {
                    if model.code == 200 {
                        if smodel.is_collect == nil || smodel.is_collect == 0 {
                            smodel.is_collect = 1
                        } else {
                            smodel.is_collect = 0
                        }
                        self?.collectionView.reloadData()
                        self?.view.makeToast(model.msg, position: .center)
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
