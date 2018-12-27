//
//  LYBaseTabBarController.swift
//  Leap
//
//  Created by 梁羽 on 2017/5/21.
//  Copyright © 2017年 梁羽. All rights reserved.
//

import UIKit

class LYBaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabbar = UITabBar.appearance()
        tabbar.tintColor = UIColor.colorWithHexString("#333333")
        addChildViewControllers()
    }
    
    //添加子控制器
    private func addChildViewControllers() {
        setChildViewController(LYHomeViewController(), title: "字", imageName: "Home")
        setChildViewController(LYFindViewController(), title: "如", imageName: "sort")
        setChildViewController(LYMessageViewController(), title: "其", imageName: "cart")
        setChildViewController(LYContactsViewController(), title: "人", imageName: "User")
    }
    
    //初始化子控制器
    private func setChildViewController(_ controller : UIViewController, title : String, imageName : String) {
        controller.tabBarItem.image = UIImage.init(named: imageName)
        controller.tabBarItem.selectedImage = UIImage.init(named: imageName + "_s")
        controller.title = title
        let nav = LYBaseNavigationController.init(rootViewController: controller)
        addChildViewController(nav)
    }
    
}
