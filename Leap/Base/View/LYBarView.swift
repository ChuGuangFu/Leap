//
//  LYBarView.swift
//  Leap
//
//  Created by 梁羽 on 2017/5/21.
//  Copyright © 2017年 梁羽. All rights reserved.
//

import UIKit

let TabBarCount = 4

protocol TabBarButtonClickDelegate {
    func tabBarButtonClick(index : Int) -> Void
}

class LYBarView: UIView {
    
    let BtnTag = 5000
    let DefaultSelectBtn = 0
    private let TABBAR_IMAGE = ["Home","sort","cart","User"]
    private let TABBAR_IMAGE_SELECT = ["Home_s","sort_s","cart_s","User_s"]
    
    var tabBarDelegate : TabBarButtonClickDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        creatButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatButton() -> Void {
        for index in 0..<TabBarCount {
            let i = CGFloat(index)
            let button = UIButton.init(type: .custom)
            button.frame = CGRect.init(x: Screen_width/CGFloat(TabBarCount)*i, y: 0, width: Screen_width/CGFloat(TabBarCount), height: CGFloat(BarHeight))
            //button.setTitle(TitleArr[index], for: .normal)
            button.setTitleColor(UIColor.colorWithHexString("#333333"), for: .normal)
            button.setTitleColor(UIColor.colorWithHexString("#333333"), for: .selected)
            button.setImage(UIImage.init(named: TABBAR_IMAGE[index]), for: .normal)
            button.setImage(UIImage.init(named: TABBAR_IMAGE_SELECT[index]), for: .selected)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
            button.titleLabel?.textAlignment = .center
            button.adjustsImageWhenHighlighted = false
            button.contentMode = .center
            button.tag = BtnTag + index
            button.isSelected = index == DefaultSelectBtn ? true : false
            button.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
            self.addSubview(button)
        }
    }
    
    func buttonClick(sender : UIButton) -> Void {
        for view in self.subviews {
            if view .isKind(of: UIControl.self) {
                let button = view as! UIButton
                button.isSelected = button.tag == sender.tag ? true : false
            }
        }
        tabBarDelegate?.tabBarButtonClick(index: sender.tag - BtnTag)
    }

}
