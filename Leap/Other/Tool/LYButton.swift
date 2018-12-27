//
//  LYButton.swift
//  Leap
//
//  Created by 梁羽 on 2017/5/21.
//  Copyright © 2017年 梁羽. All rights reserved.
//

import UIKit

class LYButton: UIButton {

    //MARK:设置button内部的image的范围
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let imageW = contentRect.size.width
        return CGRect.init(x: (imageW - 25)/2, y: 4, width: 25, height: 25)
    }
    
    //MARK:设置button内部的title的范围
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleY = contentRect.size.height * 0.4
        let titleW = contentRect.size.width
        let titleH = contentRect.size.height - titleY
        return CGRect.init(x: 0, y: titleY + 4, width: titleW, height: titleH)
    }

}
