//
//  TestRotationViewController.swift
//  Leap
//
//  Created by 梁羽 on 2018/9/3.
//  Copyright © 2018年 梁羽. All rights reserved.
//

import UIKit

class TestRotationViewController: LYBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "xuan zhuan"
        creatUI()
    }

    func creatUI() {
        let btn2 = UIButton.init(type: .custom)
        btn2.frame = CGRect.init(x: 0, y: 50, width: 100, height: 50)
        btn2.backgroundColor = UIColor.red
        btn2.tag = 1
        btn2.setTitle("横屏", for: .normal)
        btn2.addTarget(self, action: #selector(buttonClick(btn:)), for: .touchUpInside)
        self.view.addSubview(btn2)
        
        let bsd = UIButton.init(type: .custom)
        bsd.frame = CGRect.init(x: 300, y: 50, width: 100, height: 50)
        bsd.backgroundColor = UIColor.red
        bsd.tag = 2
        bsd.setTitle("竖屏", for: .normal)
        bsd.addTarget(self, action: #selector(buttonClick(btn:)), for: .touchUpInside)
        self.view.addSubview(bsd)
        
    }
    
    func buttonClick(btn : UIButton) {
        if btn.tag == 1 {
            //横屏
        }
        
        if btn.tag == 2 {
            //竖屏
        }
    }

}
