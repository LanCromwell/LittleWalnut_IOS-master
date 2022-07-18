//
//  HomeViewController.swift
//  SwiftProject
//
//  Created by YX on 2019/7/20.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit
import SwiftyJSON
import RxSwift
import RxCocoa
import DFPlayer
import HWPopController


class HomeViewController: BaseViewController {
    
    var currentModel : MTCalandarModel?
    
    ///渐变背景
    lazy var bgLayer: CAGradientLayer = {
        let bgLayer = CAGradientLayer()
        bgLayer.colors = [UIColor(red: 1, green: 0.76, blue: 0.39, alpha: 1).cgColor, UIColor(red: 1, green: 0.44, blue: 0.39, alpha: 1).cgColor, UIColor(red: 1, green: 0.23, blue: 0.4, alpha: 1).cgColor]
        bgLayer.locations = [0, 0.83, 1]
        bgLayer.frame = self.view.bounds
        bgLayer.startPoint = CGPoint(x: 1, y: 1)
        bgLayer.endPoint = CGPoint(x: -0.04, y: -0.04)
        return bgLayer
    }()
    
    ///日历控件
    lazy var calendarView: MTCalendarView = {
//        let calendarView = MTCalendarView.init(frame: CGRect.init(x: 0, y: kStatusHeight, width: kScreenWidth, height: kScreenWidth/7 * 6 + 10))
        let calendarView = MTCalendarView.init(frame: CGRect.init(x: 0, y: kStatusHeight, width: kScreenWidth, height: 0))
        calendarView.dateClickCallBack = { [weak self] model, isClick in
            print(model.data!.description_href!)
            self?.currentModel = model
            self?.updateHomeData(model as MTCalandarModel, isClick: isClick)
        }
        return calendarView
    }()
    
    ///描述
    lazy var descLab: UILabel = {
        let lab = UILabel.init()
        lab.frame = CGRect.init(x: 0, y: calendarView.mj_y + calendarView.mj_h + 10 * kWIDTHBASE, width: kScreenWidth, height: 30 * kWIDTHBASE)
        lab.text = ""
        lab.textAlignment = .center
        lab.textColor = UIColor.white
        lab.font = UIFont.font(size: 17  , weight: .semibold)
        return lab
    }()
    
    ///底部控件
    lazy var bottomView: HomeBottomView = {
        let bottomV = HomeBottomView.init(frame: CGRect.zero)
        bottomV.playerBtn.addTarget(self, action: #selector(playEvent), for: .touchUpInside)
        bottomV.favoriteBtn.addTarget(self, action: #selector(collectEvent), for: .touchUpInside)
        bottomV.shareBtn.addTarget(self, action: #selector(shareEvent), for: .touchUpInside)
         bottomV.historyBtn.addTarget(self, action: #selector(historyBtnEvent), for: .touchUpInside)
         bottomV.textListBtn.addTarget(self, action: #selector(textListBtnEvent), for: .touchUpInside)
        return bottomV
    }()
    
    ///历史记录
    lazy var historyView: HomeHistoryView = {
        let bottomV = HomeHistoryView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        bottomV.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5);
        return bottomV
    }()
    
    ///倒计时弹窗
       lazy var isFreeTopView: FXJIsFreeTopView = {
           let bottomV = FXJIsFreeTopView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
           bottomV.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5);
        bottomV.sendBtn.addTarget(self, action: #selector(sendBtnEvent), for: .touchUpInside)
        bottomV.noSendBtn.addTarget(self, action: #selector(nosendBtnEvent), for: .touchUpInside)
           return bottomV
       }()
    
    ///tips
    lazy var oneTipsView: TipsOneView = {
        let view = TipsOneView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        return view
    }()
    
    ///播放音频源
    var playerM: DFPlayerModel?
    ///当前itemM
    var itemM: MTCalandarModel?
    
    var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        ///添加子视图
        loadUI()
        ///布局子视图
        loadFrame()
        obtainUserInfo()
        NotificationCenter.default.addObserver(self, selector: #selector(closednotyBtnEvent), name: NSNotification.Name(rawValue: "HistortyClosedNoty"), object: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        UIApplication.shared.isIdleTimerDisabled = true
//        calendarView.updateDate()
        ///初始化播放控件
        initDFPlayer()
        
        mt_reload_data()
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        UIApplication.shared.isIdleTimerDisabled = false
        DFPlayer.shared()?.df_deallocPlayer()
        bottomView.playerBtn.isSelected = false
    }

}


//MARK:- 事件处理
extension HomeViewController {
    fileprivate func testFunc() {
        ///Demo
        homeProvider.request(.homeContentListApi) { (result) in
            if case let .success(res) = result {
//                let json = try? JSON.init(data: res.data)
                if (res.statusCode == 200) {
                    ///解析数据源 绑定
                } else {
                    ///
                }
                
            } else {
                print("error 也会走 那我就放心了")
            }
        }
        
    }
    
    fileprivate func mt_reload_data()  {
        self.calendarView.updateDate()
        descLab.frame = CGRect.init(x: 0, y: calendarView.mj_y + calendarView.mj_h + 10 * kWIDTHBASE, width: kScreenWidth, height: 30 * kWIDTHBASE)
        ///网络获取
        loadAudioList()

    }
    
    
    fileprivate func loadAudioList() {
        let userInfo = UserInfo.default.findUserInfo()
        let params = ["user_id": userInfo?.id ?? "", "token": userInfo?.token ?? ""]
        homeProvider.request(.homeAduioListApi(params: params)) { [weak self](result) in
            print(result)
            switch result {
            case .success(let res):
                let jsonStr = String.init(data: res.data, encoding: .utf8)
                try? print("result.mapJSON() = \(res.mapJSON())")
                if let model = BaseModel.deserialize(from: jsonStr) {
                    if model.code == 200 {
                        if let array = [HomeListModel].deserialize(from: model.data as? [Any]) {
                            self?.calendarView.updateView(array as! [HomeListModel])
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
    
    // MARK: 用户信息
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
//                            self?.userInfo = userInfo
                            uInfo = userInfo

    //                        uInfo?.invite_info = userInfo?.invite_info;
    //                        uInfo?.is_receive_vip = userInfo?.is_receive_vip;
                            uInfo?.saveUserInfo()

                                 if ((userInfo?.is_free) == "1") { //1 免费
                                     
                                 }else{
                                    let val1 = Int(userInfo!.remainder_days!);
                                    if val1! <= 0 {
                                        self?.tabBarController?.selectedIndex = 2;
                                    }else{
                                        self?.isFreeTopView.titleLabel.text = "试用期倒数\( String(describing: userInfo!.remainder_days!))天,转发赠送\(String(describing: userInfo!.user_share_get_day!))天";
                                        let delegate  = UIApplication.shared.delegate as! AppDelegate
                                    delegate.window?.addSubview(self!.isFreeTopView)
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
    
    ///更改播放状态
    fileprivate func changeStudyState(audio_id: Int) {
        let userInfo = UserInfo.default.findUserInfo()
        let params = ["user_id": userInfo?.id ?? "", "audio_id": audio_id] as [String : Any]
        homeProvider.request(.homeChangeMp3StudyState(params: params)) {(result) in
            print(result)
        }
    }
    
    
    //MARK: - 每日签到
    fileprivate func popEvent() {
        let popVC = ClockViewController()
        let popController = HWPopController.init(viewController: popVC)
        popController.popPosition = .center
        popController.present(in: self)
    }
    
    //MARK: - 历史记录关闭
    @objc func closednotyBtnEvent() {
           ///初始化播放控件
           initDFPlayer()
           mt_reload_data()
    }
    
    //MARK: - 转发
       @objc func sendBtnEvent() {
        
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
                        if error == nil { // 成功
                            self.addDaysRequest()
                        }
                           if error != nil {
                               print(error!.localizedDescription)
                           }
                       })
                       
                   }
       }
    
    //MARK: - 免转发
    @objc func nosendBtnEvent() {
        isFreeTopView.backEvent()
    }
    // 分享完增加天数
    @objc func addDaysRequest()
    {
        
          let userInfo = UserInfo.default.findUserInfo()
          let params = ["user_id": userInfo?.id ?? "0"] as [String : Any]
          homeProvider.request(.userAddDaysAPI(params: params)) { [weak self](result) in
              switch result {
              case .success(let res):
                  let jsonStr = String.init(data: res.data, encoding: .utf8)
                  try? print("result.mapJSON() = \(res.mapJSON())")
                  if let model = BaseModel.deserialize(from: jsonStr) {
                      
                      if model.code == 200 {
//                          let dict = model.data as! [String: Any]
                        self?.isFreeTopView.backEvent()
                      } else {
//                        self.makeToast(model.msg, position: self?.center)
                      }
                  }
                  
                  
              case .failure(let error):
                  print(error)
              }
          }
    }
    
    //MARK:- 播放事件
    @objc func playEvent() {
        guard let _ = itemM?.data else {
            self.view.makeToast("暂无资源", position: .center)
            return
        }

        ///如果正在播放
        if DFPlayer.shared()?.state == DFPlayerState.playing {
            DFPlayer.shared()?.df_pause()
            bottomView.playerBtn.isSelected = false
        } else if DFPlayer.shared()?.state == DFPlayerState.pause {
            DFPlayer.shared().df_play()
            bottomView.playerBtn.isSelected = true
        } else {
            DFPlayer.shared()?.df_play(withAudioId: 0)
            bottomView.playerBtn.isSelected = true
        }
        
        
        
    }
    
    ///更新播放进度
    func updateProgress(currentTime: Double, totalTime: Double, progress: Double) {
        bottomView.startTimeLab.text = transToHourMinSec(time: Float(currentTime))
        bottomView.endTimeLab.text = transToHourMinSec(time: Float(totalTime))
        bottomView.progressView.setValue(Float(currentTime/totalTime), animated: true)
    }
    
    // MARK: - 把秒数转换成时分秒（00:00:00）格式
    ///
    /// - Parameter time: time(Float格式)
    /// - Returns: String格式(00:00:00)
    func transToHourMinSec(time: Float) -> String {
        if time <= 0 {
        return "00:00"

        }
        let allTime: Int = Int(time)
//        var hours = 0
        var minutes = 0
        var seconds = 0
//        var hoursText = ""
        var minutesText = ""
        var secondsText = ""
        
//        hours = allTime / 3600
//        hoursText = hours > 9 ? "\(hours)" : "0\(hours)"
        
        minutes = allTime % 3600 / 60
        minutesText = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        
        seconds = allTime % 3600 % 60
        secondsText = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        
        return "\(minutesText):\(secondsText)"
    }
    
    func updateHomeData(_ model: MTCalandarModel, isClick: Bool) {
        ///保留模型
        itemM = model
        
        let audioPath = model.data?.audio_path ?? ""
        if audioPath.count <= 0 && isClick == true {
            self.view.makeToast("暂无资源", position: .center)
            return
        }
        
        ///更新文本
        self.descLab.text = model.data?.title ?? ""
        
        ///重置播放源
        let urlPath = model.data?.audio_path ?? ""
        let entry = DFPlayerModel.init()
        entry.audioUrl = NSURL.init(string: urlPath)! as URL
        entry.audioId = UInt(model.data?.id ?? 0)
        playerM = entry
        ///设置完数据后 需要刷新一下
        DFPlayer.shared()?.df_reloadData()
        
        bottomView.endTimeLab.text = model.data?.duration ?? "00:00"
     
        let is_collection = model.data?.is_collect ?? 0
        bottomView.favoriteBtn.isSelected = is_collection == 1 ? true : false
        
        if isClick {
            ///播放
            DFPlayer.shared()?.df_play(withAudioId: 0)
            bottomView.playerBtn.isSelected = true
            changeStudyState(audio_id: itemM?.data?.id ?? 0)
        } else {
            let key = Date.init().toString(.y_M_d)
            if !UserDefaults.standard.bool(forKey: key) {
                UserDefaults.standard.set(true, forKey: key)
                DFPlayer.shared()?.df_play(withAudioId: 0)
                bottomView.playerBtn.isSelected = true
                changeStudyState(audio_id: itemM?.data?.id ?? 0)
            }
        
        }

    }
    
    ///收藏事件
    @objc func collectEvent() {
        ///安全限制
        guard let data = itemM?.data else {return}
        
        let userInfo = UserInfo.default.findUserInfo()
        let params = ["user_id": userInfo?.id ?? "", "audio_id": data.id ?? 0] as [String : Any]
        homeProvider.request(.homeCollectAudioAPI(params: params)) { [weak self](result) in
            print(result)
            switch result {
            case .success(let res):
                let jsonStr = String.init(data: res.data, encoding: .utf8)
                try? print("result.mapJSON() = \(res.mapJSON())")
                if let model = BaseModel.deserialize(from: jsonStr) {
                    if model.code == 200 {
                        let is_collection = data.is_collect ?? 0
                        if is_collection == 0 {
                            data.is_collect = 1
                        } else {
                            data.is_collect = 0
                        }
                        self?.bottomView.favoriteBtn.isSelected = data.is_collect == 1 ? true : false
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
    
    @objc func shareEvent() {
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
    
    @objc func historyBtnEvent() {

        
        let bottomV = HomeHistoryView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
               bottomV.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5);
        
        
        DFPlayer.shared()?.df_deallocPlayer()
        bottomView.playerBtn.isSelected = false
        let delegate  = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.addSubview(bottomV)

       
    }
    
    @objc func textListBtnEvent() {
        let vc =  WebViewController.init()
        vc.title = "文稿"
        vc.filePath = self.currentModel?.data!.description_href!
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


//MARK:- UI & Frame
extension HomeViewController {
    ///添加子控件
    fileprivate func loadUI() {
        view.layer.addSublayer(bgLayer)
        view.addSubview(calendarView)
        view.addSubviews(descLab)
        view.addSubviews(bottomView)
        
        if UserDefaults.standard.bool(forKey: "firstLoadHome") == false {
            UserDefaults.standard.set(true, forKey: "firstLoadHome")
            ///添加tips
            let window = UIApplication.shared.keyWindow!
            window.addSubview(oneTipsView)
        }
        
    }
    
    ///布局
    fileprivate func loadFrame() {
        bottomView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(115  * kWIDTHBASE)
            make.bottom.equalTo(0 * kWIDTHBASE)
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
        DFPlayer.shared()?.isObserveProgress = true;

        ///设置完数据后 需要刷新一下
        DFPlayer.shared()?.df_reloadData()
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

///MARK:- DFPlayerDataSource DFPlayerDelegate
extension HomeViewController: DFPlayerDataSource, DFPlayerDelegate {
    func df_audioData(for player: DFPlayer!) -> [DFPlayerModel]! {
         print(playerM?.audioUrl ?? "")
         return [playerM ?? DFPlayerModel.init()]
    }
    

    ///数据源
    func df_playerModelArray() -> [DFPlayerModel]! {
        print(playerM?.audioUrl ?? "")
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
//    func df_player(_ player: DFPlayer!, progress: CGFloat, currentTime: CGFloat, totalTime: CGFloat) {
//        updateProgress(currentTime: Double(currentTime), totalTime: Double(totalTime), progress: Double(progress))
//    }
    
    func df_player(_ player: DFPlayer!, progress: CGFloat, currentTime: CGFloat) {
          updateProgress(currentTime: Double(currentTime), totalTime: Double(player.totalTime), progress: Double(progress))
    }
    
    ///播放完成
    func df_playerDidPlay(toEndTime player: DFPlayer!) {
//         UIApplication.shared.isIdleTimerDisabled = false
        playEndMp3()
    }
    
}
