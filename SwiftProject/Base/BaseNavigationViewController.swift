//
//  BaseNavigationViewController.swift
//  SwiftProject
//
//  Created by YX on 2019/7/20.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    



}


extension BaseNavigationViewController {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }
}
