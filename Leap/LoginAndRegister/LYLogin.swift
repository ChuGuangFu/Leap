//
//  LYLogin.swift
//  Leap
//
//  Created by 梁羽 on 2018/3/22.
//  Copyright © 2018年 梁羽. All rights reserved.
//

import UIKit

class LYLogin: NSObject {
    //MARK:用于判断是否登录
     func isLogin() -> Bool {
        if let string : String = UserDefaults.standard.object(forKey: LoginSuccess) as? String {
            if string.isEmpty {
                return false
            }else {
                if string == LoginSuccess {
                    return true
                }else {
                    return false
                }
            }
        }
        return false
    }
    
    //MARK:登录成功后保存的数据
    func loginSuccessful(userName : String) {
        let defaults = UserDefaults.standard
        defaults.setValue(LoginSuccess, forKey: LoginSuccess)
        defaults.setValue(userName, forKey: LoginUserName)
        defaults.synchronize()
    }
    
    //MARK:退出登录成功后需要清除的东西
    func logoutSuccessful() {
        let defaults = UserDefaults.standard
        defaults.setValue("", forKey: LoginSuccess)
        defaults.setValue("", forKey: LoginUserName)
        defaults.synchronize()
    }
}
