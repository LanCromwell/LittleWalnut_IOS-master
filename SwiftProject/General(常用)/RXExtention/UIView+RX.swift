//
//  UIView+RX.swift
//  SwiftDemo
//
//  Created by liyan on 2018/4/27.
//  Copyright © 2018年 liyan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


extension Reactive where Base: UIView {
    
    /*
     view.rx.tapGesture.subscribe(onNext: { _ in
     kLog("点击一下")
     }).disposed(by: rx.disposeBag)
     */
    
    var tapGesture: Observable<UITapGestureRecognizer> {
        let tapGesture = base.addTapGesture()
        return tapGesture.rx.event.asObservable()
    }
    
    
    /*
     view.rx.longPressGesture.subscribe(onNext: { (gesture: UILongPressGestureRecognizer) in
     kLog("长按一下")
     
     if gesture.state == .began {
     }
     
     }).disposed(by: rx.disposeBag)
     */
    
    var longPressGesture: Observable<UILongPressGestureRecognizer> {
        let longPressGesture = base.addLongPressGesture()
        return longPressGesture.rx.event.asObservable()
    }
    
}
