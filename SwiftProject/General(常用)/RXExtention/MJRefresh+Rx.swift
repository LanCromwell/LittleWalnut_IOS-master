//
//  MJRefresh+Rx.swift
//  SwiftDemo
//
//  Created by liyan on 2018/9/7.
//  Copyright © 2018年 liyan. All rights reserved.
//

import RxSwift
import RxCocoa
import MJRefresh


//对MJRefreshComponent 增加rx 扩展

extension Reactive where Base: MJRefreshComponent {
    
    //正在刷新事件
    var refreshing: ControlEvent<Void> {
        
        let source: Observable<Void> = Observable.create {[weak control = self.base] (observer) -> Disposable in
            
            if let control = control {
                control.refreshingBlock = {
                    observer.on(.next(()))
                }
            }
            
            return Disposables.create()
        }
        
        return ControlEvent(events: source)
        
    }
    
    
    
    
    //停止刷新
    var endRefreshing: Binder<Bool> {
        
        return Binder(base) { refresh, isEnd in
            if isEnd {
                refresh.endRefreshing()
            }
        }
    }
    
}

