//
//  TestVC.swift
//  Leap
//
//  Created by 梁羽 on 2017/6/5.
//  Copyright © 2017年 梁羽. All rights reserved.
//

import UIKit

class TestVC: LYBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "详情页"
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        //testFunc()
    }
    
    func testFunc() {
        let view = UIView.init(frame: CGRect.init(x: 100, y: 100, width: 100, height: 100))
        self.view.addSubview(view)
        view.backgroundColor = UIColor.colorWithHexString("#B0E0E6")
        
        let view2 = UIView.init(frame: CGRect.init(x: 100, y: 320, width: 100, height: 100))
        self.view.addSubview(view2)
        view2.backgroundColor = UIColor.init(r: 176, g: 224, b: 230)
        
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 64, width: Screen_width, height: 100))
        label.numberOfLines = 0
        label.backgroundColor = UIColor.blue.withAlphaComponent(0.2)
        self.view.addSubview(label)
        let str = "发  发发女加点水\n发发大水封 个热伤风"
        //label.text = str.noWhiteSpaceString()
        let strhhh : String = ""
        
        label.attributedText = str.attStringWithString(strhhh, keyWord: "hehe", highlightedColor: UIColor.red, textColor: UIColor.black)
        
        let a = 1
        let b = 2
//        guard a == 1, b == 3 else { //只要有一个条件不符合就会执行else中的语句
//            print("hehe",self)
//            return
//        }
        guard a == 1 || b == 4 else {
            print("lili")
            return
        }
    }
    
    class func cece() {
        print("666",self)
    }
    
}
