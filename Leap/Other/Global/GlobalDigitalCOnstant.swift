//
//  GlobalDigitalCOnstant.swift
//  Leap
//
//  Created by 梁羽 on 2017/5/21.
//  Copyright © 2017年 梁羽. All rights reserved.
//

import Foundation
import UIKit

//MARK:布局常量--全局
public let Screen_width = UIScreen.main.bounds.size.width
public let Screen_height = UIScreen.main.bounds.size.height
public let NavigationBar_height : CGFloat = 64.0
public let TabBar_height : CGFloat = 49.0

//MARK:登录常量
public let LoginState = "loginState" //登录状态的常量
public let LoginSuccess = "loginSuccess" //登录成功以后需要保存的常量
public let LogoutSuccess = "logoutSuccess" //退出登录成功以后的常量
public let LoginUserName = "loginUserName" //登录成功后保存用户名

//MARK:布局常量--tabbar
public let BarHeight : CGFloat = 49

//MARK:初始化常量
public let TitleArr = ["字","如","其","人"]

//MARK:头像占位图
public let avatarHolder : UIImage = UIImage.init(named: "default_avatar")!
