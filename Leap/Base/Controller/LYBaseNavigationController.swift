//
//  LYBaseNavigationController.swift
//  Leap
//
//  Created by 梁羽 on 2017/5/21.
//  Copyright © 2017年 梁羽. All rights reserved.
//

import UIKit

class LYBaseNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    override class func initialize() {
        //设置不透明
        UINavigationBar.appearance().isTranslucent = false
        //设置导航栏背景色
        UINavigationBar.appearance().barTintColor = UIColor.white
        //设置导航栏标题文字颜色
        //创建字典保存文字大小和颜色
        var dicColor = Dictionary<String,Any>()
        dicColor[NSFontAttributeName] = UIFont.systemFont(ofSize: 18)
        dicColor[NSForegroundColorAttributeName] = UIColor.init(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1)
        UINavigationBar.appearance().titleTextAttributes = dicColor
        
        //拿到整个导航控制器的外观
        let item = UIBarButtonItem.appearance()
        item.tintColor = UIColor.init(red: 0.42, green: 0.42, blue: 0.42, alpha: 1)
        //设置字典的字体大小
        var atts = Dictionary<String,Any>()
        atts[NSFontAttributeName] = UIFont.systemFont(ofSize: 18)
        atts[NSForegroundColorAttributeName] = UIColor.init(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1)
        item.setTitleTextAttributes(atts, for: .normal)
    }
    
    //MARK:解决popRootViewController时tabbar的bug
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        //删除系统自带的tabBarButton
        for tabbar in (self.tabBarController?.tabBar.subviews)! {
            if tabbar.isKind(of: NSClassFromString("UITabBarButton")!) {
                tabbar.removeFromSuperview()
            }
        }
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            //如果在堆栈控制器数量大于1 加返回按钮
            viewController.hidesBottomBarWhenPushed = true
            let btn = UIButton.init(type: .custom)
            btn.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
            btn.setImage(UIImage.init(named: "back_neihan"), for: .normal)
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, -18, 0, 18)
            btn.tintColor = UIColor.init(red: 0.42, green: 0.42, blue: 0.42, alpha: 1)
            let leftItem = UIBarButtonItem.init(customView: btn)
            btn.addTarget(self, action: #selector(popToPre), for: .touchUpInside)
            viewController.navigationItem.leftBarButtonItem = leftItem
        }else {
            
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    func popToPre() -> Void {
        self.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
