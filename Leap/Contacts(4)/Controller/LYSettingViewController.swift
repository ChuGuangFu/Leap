//
//  LYSettingViewController.swift
//  Leap
//
//  Created by 梁羽 on 2018/3/22.
//  Copyright © 2018年 梁羽. All rights reserved.
//

import UIKit

class LYSettingViewController: LYBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
        creatSubView()
    }

    func creatSubView() {
        let logoutBtn = UIButton.init(title: "退出登录", titleColor: UIColor.white, font: 20, type: .custom, target: self, selector: #selector(logoutClick))
        logoutBtn.frame = CGRect.init(x: 20, y: self.view.height - 46 - 50, width: Screen_width - 40, height: 46)
        logoutBtn.backgroundColor = UIColor.colorWithHexString("#0196e6")
        logoutBtn.addTarget(self, action: #selector(logoutClick), for: .touchUpInside)
        self.view.addSubview(logoutBtn)
    }

    func logoutClick() {
        let alertVC = UIAlertController.init(title: nil, message: "您确定要退出登录吗?", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (action : UIAlertAction) -> Void in
            
        }))
        alertVC.addAction(UIAlertAction.init(title: "确定", style: .default, handler: { (action : UIAlertAction) -> Void in
            LYLogin.init().logoutSuccessful()
            (UIApplication.shared.delegate as! AppDelegate).setLoginViewController()
            self.pop()
        }))
        self.present(alertVC, animated: true, completion: nil)
    }
}
