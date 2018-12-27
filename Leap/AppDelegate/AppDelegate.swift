//
//  AppDelegate.swift
//  Leap
//
//  Created by 梁羽 on 2017/5/21.
//  Copyright © 2017年 梁羽. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UITableView.appearance().estimatedRowHeight = 0
        UITableView.appearance().estimatedSectionHeaderHeight = 0
        UITableView.appearance().estimatedSectionFooterHeight = 0
        self.window = creatWindow()
        return true
    }
    
    func creatWindow() -> UIWindow {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
        if LYLogin.init().isLogin() {
            setTabBarViewController()
        }else {
            setLoginViewController()
        }
        return self.window!
    }
    
    func setTabBarViewController() {
        //设置tabbar及其子视图
        self.window?.rootViewController = LYBaseTabBarController()
    }
    
    func setLoginViewController() {
        //设置登录视图
        self.window?.rootViewController = LYLoginViewController()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }


}

