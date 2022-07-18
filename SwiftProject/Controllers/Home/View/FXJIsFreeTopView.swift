//
//  FXJIsFreeTopView.swift
//  SwiftProject
//
//  Created by 方新俊 on 2020/3/30.
//  Copyright © 2020 MT. All rights reserved.
//

import UIKit

class FXJIsFreeTopView: UIView {
    
    ///背景
       lazy var bgView: UIView = {
           let bottomV = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 314*kWIDTHBASE, height: 154*kWIDTHBASE))
           bottomV.backgroundColor = UIColor.white;
        bottomV.layer.cornerRadius = 4*kWIDTHBASE;
        bottomV.clipsToBounds = true
           return bottomV
       }()

    //关闭
          lazy var closedBtn: UIButton = {
              let btn = UIButton()
              btn.setTitle("x", for: .normal)
           btn.backgroundColor = UIColor.white
           btn.setTitleColor(.black, for: .normal)
           btn.addTarget(self, action: #selector(backEvent), for: .touchUpInside)
              return btn
          }()
    
    ///转发
    lazy var sendBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: "转发"), for: .normal)
        return btn
    }()
    
    
    ///免转发
    lazy var noSendBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: "免转发"), for: .normal)
        return btn
    }()
    
    lazy var titleLabel: UILabel = {
           let lab = UILabel()
           lab.textColor = UIColor.black
           lab.text = "试用期倒数3天,转发赠送七天"
           lab.textAlignment = .center
           lab.font = UIFont.font(size: 14, weight: .medium)
           return lab
       }()
    
    override init(frame: CGRect) {
                   super.init(frame: frame)
                   loadUI()
                   loadFrame()
   
               }
               
               required init?(coder aDecoder: NSCoder) {
                   fatalError("init(coder:) has not been implemented")
               }
    
}

extension FXJIsFreeTopView
{
    ///返回事件
    @objc func backEvent() {

       self.removeFromSuperview()
    }
    
    func loadUI() {
             self.addSubview(bgView)
            bgView.addSubviews([closedBtn,titleLabel,sendBtn,noSendBtn])
         }
         
    func loadFrame() {
        
        bgView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.height.equalTo(154*kWIDTHBASE)
            make.width.equalTo(314*kWIDTHBASE)
          }
        
        
        closedBtn.snp.makeConstraints { (make) in
              make.top.equalTo(bgView)
            make.right.equalTo(bgView)
            make.height.width.equalTo(40*kWIDTHBASE)
          }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(bgView).offset(40*kWIDTHBASE)
          make.right.left.equalTo(bgView)
          make.height.equalTo(30*kWIDTHBASE)
        }
        
        sendBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(bgView).offset(-32*kWIDTHBASE)
            make.left.equalTo(bgView).offset(30*kWIDTHBASE)
          make.height.equalTo(32*kWIDTHBASE)
            make.width.equalTo(112*kWIDTHBASE)

        }
        
        noSendBtn.snp.makeConstraints { (make) in
                   make.centerY.equalTo(sendBtn)
                 make.right.equalTo(bgView).offset(-30*kWIDTHBASE)
                 make.height.equalTo(32*kWIDTHBASE)
                   make.width.equalTo(112*kWIDTHBASE)

               }
        
    }
}
