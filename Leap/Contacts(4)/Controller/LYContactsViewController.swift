//
//  LYContactsViewController.swift
//  Leap
//
//  Created by 梁羽 on 2017/5/21.
//  Copyright © 2017年 梁羽. All rights reserved.
//

import UIKit

class LYContactsViewController: LYBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let btn = UIButton.init(title: "设置", titleColor: UIColor.colorWithHexString("#333333"), font: 16, type: UIButtonType.custom, target: self, selector: #selector(rightButtonClick))
        btn.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
        let btnItem = UIBarButtonItem.init(customView: btn)
        self.navigationItem.rightBarButtonItem = btnItem
    }

    func rightButtonClick() {
        self.pushVc(LYSettingViewController())
    }

}
