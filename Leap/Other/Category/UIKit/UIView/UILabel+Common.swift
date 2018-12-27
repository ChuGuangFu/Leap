//
//  UILabel+Common.swift
//  Leap
//
//  Created by 梁羽 on 2018/3/22.
//  Copyright © 2018年 梁羽. All rights reserved.
//

import Foundation

extension UILabel {
    convenience init(text : String, textColor : UIColor, font : CGFloat) {
        self.init()
        self.text = text
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: font)
        self.adjustsFontSizeToFitWidth = true
    }
}
