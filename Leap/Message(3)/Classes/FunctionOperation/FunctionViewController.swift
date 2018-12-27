//
//  FunctionViewController.swift
//  Leap
//
//  Created by 梁羽 on 2018/4/8.
//  Copyright © 2018年 梁羽. All rights reserved.
//

import UIKit

class FunctionViewController: LYBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "function calling"
    }
    
    @IBAction func swiftUseOcFunction(_ sender: UIButton) {
        let swiftFuncVC = FunctionOperationViewController()
        self.pushVc(swiftFuncVC)
    }
    
    @IBAction func ocUseSwiftFunction(_ sender: UIButton) {
        
    }
}
