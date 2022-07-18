//
//  WebViewController.swift
//  SwiftProject
//
//  Created by YX on 2019/9/6.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: BaseViewController {
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    deinit {
        print("WebViewController  被释放了。。。")
    }

  
    //MARK:- lazy
    lazy var webView: WKWebView = {
        let webView = WKWebView.init(frame: CGRect.init(x: 0, y: kTopHeight, width: kScreenWidth, height: kScreenHeight - kTopHeight - kBottomSpaceHeight))
        webView.navigationDelegate = self
        // 让webview翻动有回弹效果
        webView.scrollView.bounces = true
        // 只允许webview上下滚动
        webView.scrollView.alwaysBounceVertical = true
        return webView
    }()
    
//    lazy var webConfiguration: WKWebViewConfiguration = {
//        let configuration = WKWebViewConfiguration.init()
//        let preferences = WKPreferences.init()
//        preferences.javaScriptCanOpenWindowsAutomatically = true
//        configuration.preferences = preferences
//        configuration.userContentController = self.webUserContentController
//        return configuration
//    }()
//
//    lazy var webUserContentController: WKUserContentController = {
//        let userConetentController = WKUserContentController.init()
//        userConetentController.add(self as! WKScriptMessageHandler, name: "webViewApp")
//        return userConetentController
//    }()
    

}


///WKNavigationDelegate：判断页面加载完成，只有在页面加载完成了，才能在swift中调webview中的js方法
extension WebViewController: WKNavigationDelegate {
    
    // 导航条
    func setNavUI() {
        self.navigationView.isHidden = false
        self.navigationView.titleLabel.textColor = UIColor.hexInt(0x313131)
        self.navigationView.backgroundColor = UIColor.white
        self.navigationView.leftButton.isHidden = false
        self.navigationView.leftButton.setImage(UIImage.init(named: "back-icon"), for: .normal)
        self.navigationView.bottomLine.isHidden = false
    }
    
    // 监听网页加载进度
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
    }
    
    // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        print("开始加载...")
    }
    
    // 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!){
//        print("当内容开始返回...")
    }
    
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
//        print("页面加载完成...")
        /// 获取网页title
//        self.title = self.wkWebView.title
        webView.evaluateJavaScript("sayHello('WebView你好！')") { (result, err) in
        }
        
    }
    
    // 页面加载失败时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
//        print("页面加载失败")
    }
    
}



