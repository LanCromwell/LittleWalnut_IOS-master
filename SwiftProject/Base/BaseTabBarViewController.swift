//
//  BaseTabBarViewController.swift
//  SwiftProject
//
//  Created by YX on 2019/7/20.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController {
    ///首页
    let homeVC = HomeViewController()
    ///专家严选
//    let expertVC = ExpertViewController()
    /// 商城
    let expertVC = ExpertWebViewController()
    
    /// 客服
    let serviceVC = ServiceWebViewController()
    ///我的
    let mineVC = MineViewController()

    //MARK:- 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///设置全局样式
        setupTabbarStyles()
        ///添加视图
        setupChildViewControllers()
        
        self.delegate = self as UITabBarControllerDelegate
    }
    
}



//MARK:- tabbar 样式设置
extension BaseTabBarViewController {
    
    public func setupTabbarStyles() {
        /*改变UITabBarItem 上title的字体大小和颜色*/
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)], for: .selected)
        
        /*设置tabBar 高亮颜色*/
        tabBar.tintColor = UIColor.white;
        tabBar.backgroundColor = UIColor.init(r: 241, g: 155, b: 81)
        tabBar.backgroundImage = UIImage()
   
    }
    
    
    func changeItemColor(viewController: UIViewController, type: NSInteger) {
        if let vcs = self.viewControllers {
            if type == 0 {
                for vc in vcs {
                    vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
                    vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
                }
            } else {
                for vc in vcs {
                    if vc == viewController {
                        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Color_tabbar_tintColor], for: .normal)
                        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Color_tabbar_tintColor], for: .selected)
                    } else {
                        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Color_Gray85], for: .normal)
                        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Color_Gray85], for: .selected)
                    }
                }
            }
        }
    }
    
    
}



//MARK:- 添加子视图控制器
extension BaseTabBarViewController {
    
    /*
     *  添加控件到UITabbarController
     */
    public func setupChildViewControllers() {
        
        addChildViewController(childController: homeVC, title: "育儿管家", imageName: "tab_icon_home_white", selectedImageName: "tab_icon_home_white")
        addChildViewController(childController: expertVC, title: "商城", imageName: "商城_默认", selectedImageName: "商城_选中")
         addChildViewController(childController: serviceVC, title: "客服", imageName: "客服_默认", selectedImageName: "客服_选中")
        addChildViewController(childController: mineVC, title: "我的", imageName: "tab_icon_mine_white", selectedImageName: "tab_icon_mine_white")

    }
    

    /*
     *    Params Annotations
     *    childController    试图控制器对象
     *    title              tabbarItem title
     *    imageName          tabbarItem 普通状态下image
     *    selectedImageName  tabbarItem 选中状态下image
     */
    public func addChildViewController(childController: UIViewController, title: String, imageName: String, selectedImageName: String) {
        childController.title = title;
        childController.tabBarItem.image = UIImage(named: imageName)!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        childController.tabBarItem.selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        childController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        childController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        addChild(BaseNavigationViewController(rootViewController: childController))
    }
}

extension BaseTabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        changeItemColor(viewController: viewController, type: tabBarController.selectedIndex)
        ///首页
        if tabBarController.selectedIndex == 0 {
            tabBar.backgroundColor = Color_tabbar_tintColor
            homeVC.tabBarItem.selectedImage = UIImage(named: "tab_icon_home_white")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal);
            expertVC.tabBarItem.image = UIImage(named: "tab_icon_find_white")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
              serviceVC.tabBarItem.image = UIImage(named: "客服_默认")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            mineVC.tabBarItem.image = UIImage(named: "tab_icon_mine_white")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal);
        
        } else if tabBarController.selectedIndex == 1 { // 商城
            tabBar.backgroundColor = UIColor.white
            
            homeVC.tabBarItem.image = UIImage(named: "tab_icon_home_gray")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal);
            expertVC.tabBarItem.selectedImage = UIImage(named: "tab_icon_find_orange")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
              serviceVC.tabBarItem.image = UIImage(named: "tab_icon_server_gray")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            mineVC.tabBarItem.image = UIImage(named: "tab_icon_mine_gray")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal);
            
        }else if tabBarController.selectedIndex == 2 { // 服务
            tabBar.backgroundColor = UIColor.white
            
            homeVC.tabBarItem.image = UIImage(named: "tab_icon_home_gray")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal);
             expertVC.tabBarItem.image = UIImage(named: "tab_icon_find_gray")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            mineVC.tabBarItem.image = UIImage(named: "tab_icon_mine_gray")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal);
            
        } else { // 我的
            tabBar.backgroundColor = UIColor.white
            
            homeVC.tabBarItem.image = UIImage(named: "tab_icon_home_gray")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal);
            expertVC.tabBarItem.image = UIImage(named: "tab_icon_find_gray")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
             serviceVC.tabBarItem.image = UIImage(named: "tab_icon_server_gray")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            mineVC.tabBarItem.selectedImage = UIImage(named: "tab_icon_mine_orange")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal);

        }
        
        
     
    }
    
    

}
