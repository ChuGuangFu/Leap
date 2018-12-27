//
//  UIButton+Common.swift
//  Leap
//
//  Created by 梁羽 on 2018/3/22.
//  Copyright © 2018年 梁羽. All rights reserved.
//

import Foundation

extension UIButton {
    convenience init(title : String, titleColor : UIColor, font : CGFloat, type : UIButtonType, target : Any?, selector : Selector) {
        self.init(type: type)
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: font)
        addTarget(target, action: selector, for: .touchUpInside)
    }
}
