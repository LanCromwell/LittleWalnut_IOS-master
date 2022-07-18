//
//  PopViewController.swift
//  SwiftProject
//
//  Created by YX on 2019/8/24.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit

class ClockViewController: BaseViewController {
    
    ///contentView
    lazy var contentView: UIImageView = {
        let contentView = UIImageView()
        contentView.image = UIImage.init(named: "clock_bg")
        return contentView
    }()
    
    ///关闭按钮
    lazy var closeBtn: UIButton = {
        let btn = UIButton.init()
        btn.setImage(UIImage.init(named: "clock_close"), for: .normal)
        btn.setImage(UIImage.init(named: "clock_close"), for: .highlighted)
        btn.addTarget(self, action: #selector(closeEvent), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
        loadFrame()
    }
    
  
}


extension ClockViewController {
    @objc func closeEvent() {
        self.popController?.dismiss()
    }
}


extension ClockViewController {
    func loadUI() {
        self.contentSizeInPop = CGSize.init(width: 240, height: 390)
        self.contentSizeInPopWhenLandscape = CGSize.zero
        
        view.addSubview(contentView)
        view.addSubview(closeBtn)
        
        ///透明设置
        self.popController?.containerView.backgroundColor = UIColor.clear
        self.popController?.contentView.backgroundColor = UIColor.clear
        view.backgroundColor = UIColor.clear
        
        ///禁止空白区域点击
        self.popController?.shouldDismissOnBackgroundTouch = false
    }
    
    func loadFrame() {
        contentView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(335)
        }
        
        closeBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 32, height: 32))
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(contentView.snp.bottom).offset(19)
        }
    }
}


