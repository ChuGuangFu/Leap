//
//  FunctionOperationViewController.swift
//  Leap
//
//  Created by 梁羽 on 2018/4/8.
//  Copyright © 2018年 梁羽. All rights reserved.
//

import UIKit

class FunctionOperationViewController: LYBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let ocFuncVC = FuncOperationViewController()
        self.pushVc(ocFuncVC)
        let count = withVaList(["hello","hamster","good","morning"]) { args -> Int in
            return ocFuncVC.fooList(args)
        }
        print(count)
    }

}
