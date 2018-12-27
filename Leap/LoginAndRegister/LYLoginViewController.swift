//
//  LYLoginViewController.swift
//  Leap
//
//  Created by 梁羽 on 2018/3/22.
//  Copyright © 2018年 梁羽. All rights reserved.
//

import UIKit
import TPKeyboardAvoiding

class LYLoginViewController: LYBaseViewController, UITextFieldDelegate {
    
    var userNameString = String()
    var passwordString = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        creatSubView()
    }

    func creatSubView() {
        let backScrollView = TPKeyboardAvoidingScrollView.init(frame: CGRect.init(x: 0, y: 20, width: Screen_width, height: Screen_height - 20))
        backScrollView.backgroundColor = UIColor.white
        backScrollView.contentSize = CGSize.init(width: Screen_width, height: Screen_height)
        backScrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(backScrollView)
        
        let label = UILabel.init(text: "登录", textColor: UIColor.colorWithHexString("#333333"), font: 24)
        label.frame = CGRect.init(x: 20, y: 100, width: 100, height: 30)
        backScrollView.addSubview(label)
        
        for index in 0..<2 {
            let textField = UITextField.init(frame: CGRect.init(x: 20, y:160 + CGFloat(index) * 50, width: Screen_width - 40, height: 46))
            textField.placeholder = ["手机 / 邮箱 / 用户名","密码"][index]
            textField.clearButtonMode = .whileEditing
            index == 1 ? textField.isSecureTextEntry = true : nil
            textField.tag = index
            textField.delegate = self
            backScrollView.addSubview(textField)
            
            let lineLayer = CALayer.init()
            lineLayer.backgroundColor = UIColor.colorWithHexString("#dddddd").cgColor
            lineLayer.frame = CGRect.init(x: textField.x, y: textField.bottom, width: textField.width, height: 0.5)
            backScrollView.layer.addSublayer(lineLayer)
            
            if index == 0 {
                if let str : String = UserDefaults.standard.object(forKey: LoginUserName) as? String {
                    textField.text = str
                    userNameString = str
                }
            }
        }
        
        let loginButton = UIButton.init(title: "登录", titleColor: UIColor.white, font: 18, type: .custom, target: self, selector: #selector(loginButtonClick))
        loginButton.frame = CGRect.init(x: 20, y: 300, width: Screen_width - 40, height: 46)
        loginButton.backgroundColor = UIColor.colorWithHexString("#0196e6")
        loginButton.layer.cornerRadius = 5
        backScrollView.addSubview(loginButton)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textString : NSString = textField.text! as NSString
        let str = textString.replacingCharacters(in: range, with: string)
        if textField.tag == 0 {
            userNameString = str
        }else {
            passwordString = str
        }
        return true
    }
    
    func loginButtonClick() {
        if userNameString.isEmpty || passwordString.isEmpty {
            self.showTipHudAnimationWithTipString("请输入账号信息")
            return
        }
        LYLogin.init().loginSuccessful(userName: userNameString)
        self.showFullLoadingAnimation()
//        DispatchQueue.global(qos: .default).asyncAfter(deadline: DispatchTime.now() + 2.0) {
//            DispatchQueue.main.async {
//                self.hideLoadingAnimation()
//            }
//            (UIApplication.shared.delegate as! AppDelegate).setTabBarViewController()
//        }
        DispatchQueue.main.async {
            self.hideLoadingAnimation()
            (UIApplication.shared.delegate as! AppDelegate).setTabBarViewController()
        }
    }

}
