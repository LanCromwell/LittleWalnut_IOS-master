//
//  UITableView+Extension.swift
//  SwiftProject
//
//  Created by YX on 2019/7/22.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit

public extension UITableView {
    
    func mt_register<T: UITableViewCell>(cellWithClass name: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: name))
    }
    
    
    func mt_dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find UITableViewCell for \(String(describing: name)), make sure the view is registered with tableView")
        }
        return cell
        
    }
}

