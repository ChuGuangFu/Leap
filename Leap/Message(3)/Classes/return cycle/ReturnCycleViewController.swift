//
//  ReturnCycleViewController.swift
//  Leap
//
//  Created by 梁羽 on 2018/2/10.
//  Copyright © 2018年 梁羽. All rights reserved.
//

import UIKit

class ReturnCycleViewController: LYBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "return cycle"
        creatUI()
    }

    func creatUI() {
        let descLabel = UILabel.init(frame: CGRect.init(x: 20, y: 20, width: Screen_width - 20 * 2, height: 1))
        descLabel.textColor = UIColor.colorWithHexString("#999999")
        descLabel.numberOfLines = 0
        self.view.addSubview(descLabel)
        descLabel.text = "当我们给一个类指定一个闭包属性时，这个类的实例便包含了闭包的一个引用。如果在这个闭包中，又引用了类实例本身，这时闭包便创建了一个指向类实例的强引用，这种情况下，又产生了循环引用。我们可以通过“捕获列表”来解决这种循环引用问题。当闭包和捕获实例总是相互引用，且两者同时释放时，我们将“捕获引用”设置为unowned。如果“捕获引用”可能在某个点被设置成nil，则将其设置为weak。weak引用通常都是optional类型，当引用的实例被释放时，被设置成nil。"
        descLabel.sizeToFit()
    }
}
