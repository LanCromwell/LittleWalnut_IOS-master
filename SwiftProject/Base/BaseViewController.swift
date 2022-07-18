//
//  BaseViewController.swift
//  SwiftProject
//
//  Created by YX on 2019/7/20.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit


class BaseViewController: UIViewController {
    
    ///自己定义导航条
    lazy var navigationView: MTNavigationBar = {
        let barView = MTNavigationBar.init(frame: topFrame)
        barView.backgroundColor = UIColor.red
        barView.isHidden = true
        return barView
    }()
    
    
    ///阴影Card
    lazy var cardView: UIView = {
        let layerView = UIView.init(frame: shadowFrame)
        // shadowCode
        layerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        layerView.layer.shadowOffset = CGSize(width: 1, height: 4)
        layerView.layer.shadowOpacity = 1
        layerView.layer.shadowRadius = 10
        
        let bgLayer = CALayer()
        bgLayer.frame = layerView.bounds
        bgLayer.cornerRadius = 10
        bgLayer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layerView.layer.addSublayer(bgLayer)
        
        return layerView
    }()
    
    
    //MARK:- 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        ///隐藏系统导航条
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor.init(r: 249, g: 249, b: 249)
        view.addSubview(navigationView)
        //        view.addSubview(cardView)
        if #available(iOS 11.0, *) {
            
        } else {
            //当scrollView是View Controller的第一个subView时，是否自动调整了ScrollView的contentInset
            self.automaticallyAdjustsScrollViewInsets = false
        }
        self.navigationController?.navigationBar.isTranslucent = false
        self.extendedLayoutIncludesOpaqueBars = true
        self.edgesForExtendedLayout = []
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
}
