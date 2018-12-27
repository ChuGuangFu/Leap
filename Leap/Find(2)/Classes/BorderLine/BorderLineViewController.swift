//
//  BorderLineViewController.swift
//  Leap
//
//  Created by 梁羽 on 2018/8/29.
//  Copyright © 2018年 梁羽. All rights reserved.
//

import UIKit
import WebKit

class BorderLineViewController: LYBaseViewController, WKNavigationDelegate {

    var imgV = UIImageView()
    var webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "border line"
        creatView()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        imgV.top = self.safeInsets.top + NavigationBar_height + 30
    }
    
    func creatView() {
        imgV = UIImageView.init(frame: CGRect.init(x: 18, y: 10, width: Screen_width - 36, height: 300))
        imgV.contentMode = .scaleAspectFill
        imgV.image = UIImage.init(named: "offset_4")
        imgV.clipsToBounds = true
        self.view.addSubview(imgV)
        
        let path = UIBezierPath.init(roundedRect: imgV.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize.init(width: 10, height: 10))
        
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = imgV.bounds
        maskLayer.path = path.cgPath
        
        let borderLayer = CAShapeLayer.init()
        borderLayer.frame = imgV.bounds
        borderLayer.path = path.cgPath
        borderLayer.lineWidth = 3
        borderLayer.strokeColor = UIColor.red.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        imgV.layer.addSublayer(borderLayer)
        
        imgV.layer.mask = maskLayer
        
        let descLab = UILabel.init(frame: CGRect.init(x: 18, y: imgV.bottom + 10, width: imgV.width, height: 1))
        descLab.textColor = UIColor.colorWithHexString("#666666")
        descLab.font = UIFont.systemFont(ofSize: 14)
        descLab.numberOfLines = 0
        self.view.addSubview(descLab)
        descLab.text = "控件倒圆角以及加边框\n\n1.通过CAShapeLayer与UIBezierPath结合来实现\n\n2.需要创建两个CAShapeLayer，maskLayer与borderLayer，其中maskLayer负责倒圆角添加方式为imgV.layer.maks = maskLayer。borderLayer负责添加边框需要多设置lineWidth、strokeColor(边框色)、fillColor(填充色)三个属性来实现，添加方式为imgV.layer.addSublayer(borderlayer)"
        descLab.sizeToFit()
    }

}
