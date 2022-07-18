//
//  ExpertWebViewController.swift
//  SwiftProject
//
//  Created by 方新俊 on 2019/12/31.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit
import WebKit

class ExpertWebViewController: BaseViewController {

      var userInfo: UserInfo?
    
    var filePath: String? {
           didSet {
               guard let path = filePath else { return  }
               let url = URL.init(string: path)
               let request = URLRequest.init(url: url!)
               webView.load(request as URLRequest)
           }
       }
       
       override func viewDidLoad() {
           super.viewDidLoad()
           setNavUI()
           view.addSubview(webView)
//        webView.frame = CGRect.init(x: 0, y: kStatusHeight, width: kScreenWidth, height: kScreenHeight - kStatusHeight - kBottomHeight)
           obtainUserInfo()
       }
    
//       override func viewWillAppear(_ animated: Bool) {
//           super.viewWillAppear(animated)
//           UIApplication.shared.statusBarStyle = .default
//       }
//
//       override func viewWillDisappear(_ animated: Bool) {
//           super.viewWillDisappear(animated)
//           UIApplication.shared.statusBarStyle = .lightContent
//       }
//
       deinit {
           print("WebViewController  被释放了。。。")
       }

     
       //MARK:- lazy
       lazy var webView: YZWebView = {
           let webView = YZWebView.init(frame: CGRect.init(x: 0, y: kTopHeight, width: kScreenWidth, height: kScreenHeight - kTopHeight - kBottomHeight))
           webView.noticeDelegate = self
           webView.delegate = self;
           // 让webview翻动有回弹效果
           webView.scrollView.bounces = true
           // 只允许webview上下滚动
           webView.scrollView.alwaysBounceVertical = true
           return webView
       }()
}
    
    ///WKNavigationDelegate：判断页面加载完成，只有在页面加载完成了，才能在swift中调webview中的js方法
extension ExpertWebViewController: WKNavigationDelegate,YZWebViewDelegate, YZWebViewNoticeDelegate,YZSDKDelegate {
    // 用户信息
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
                            uInfo?.saveUserInfo()
                                                 
                        YZSDK.shared.delegate = self;
                        // 必须设置代理方法，保证 SDK 在需要 token 的时候可以正常运行

                        self?.filePath = self?.userInfo?.youzan_info?.shop_href
                            
                        } else {
                            self?.view.makeToast(model.msg, position: .center)
                        }
                    }
                    
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    
     func yzsdk(_ sdk: YZSDK, needInitToken callback: @escaping (String?) -> Void) {
            
            // 调用有赞云的 init Token 接口并返回 token. 见：https://www.youzanyun.com/docs/guide/3400/3466
            // 最好由你的服务端来调用有赞的接口，客户端通过你的服务端间接调用有赞的接口获取 initToken 以保证安全性。
        print("++++++++++++++++++++++++ 调用有赞云的 init Token 接口并返回 token26832")
         callback(self.userInfo?.youzan_info?.access_token);
            
        }
        
    
    func webView(_ webView: YZWebViewProtocol, didReceive notice: YZNotice) {
        
        switch notice.type {  //
        case .login:  // 收到登陆请求
          print("++++++++++++++++++++++++ 收到登陆请求")
            login()
          break
        default: break
            
        }
    }
   //登录
    func login(){

        YZSDK.shared.synchronizeAccessToken(self.userInfo?.youzan_info?.access_token ?? "", cookieKey: self.userInfo?.youzan_info?.cookie_key, cookieValue: self.userInfo?.youzan_info?.cookie_value);

        webView.reload()
    }

   // 导航条
           func setNavUI() {
               self.navigationView.isHidden = false
               self.navigationView.titleLabel.text = "商城"
               self.navigationView.titleLabel.textColor = UIColor.hexInt(0x313131)
               self.navigationView.backgroundColor = UIColor.white
               self.navigationView.leftButton.isHidden = true
               self.navigationView.leftButton.setImage(UIImage.init(named: "back-icon"), for: .normal)
               self.navigationView.bottomLine.isHidden = false
              self.navigationView.leftButton.addTarget(self, action: #selector(leftEvent), for: .touchUpInside)

           }
            
            ///左侧button 点击事件
           @objc func leftEvent() {
            if (self.webView.canGoBack) {
                self.webView.goBack();

             }
           }
    
//    - (BOOL)webView:(id<YZWebView>)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
//    - (void)webViewDidStartLoad:(id<YZWebView>)webView;
//    - (void)webViewDidFinishLoad:(id<YZWebView>)webView;
//    - (void)webView:(id<YZWebView>)webView didFailLoadWithError:(NSError *)error;
//    - (void)webViewWebContentProcessDidTerminate:(id<YZWebView>)webView;
    
    
    func webViewDidStartLoad(_ webView: YZWebViewProtocol) {
        print("开始加载")
    }
    
    func webViewDidFinishLoad(_ webView: YZWebViewProtocol) {
         print("加载完成")
        //获取当前页面的title
        let title = webView.stringByEvaluatingJavaScript(from: "document.title")
        self.navigationView.titleLabel.text = title
        if (self.webView.canGoBack) {
            self.navigationView.leftButton.isHidden = false;
        }else{
             self.navigationView.leftButton.isHidden = true;
        }
    }
    
    
}



