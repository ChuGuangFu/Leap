//
//  UIView+Hud.swift
//  Leap
//
//  Created by 梁羽 on 2017/6/4.
//  Copyright © 2017年 梁羽. All rights reserved.
//

import Foundation
import MBProgressHUD

extension UIView {
    
    private struct ly_hudkey {
        static var hudkey = "hudkey"
    }
    
    private var HUD : MBProgressHUD {
        get {
            return objc_getAssociatedObject(self, &ly_hudkey.hudkey) as! MBProgressHUD
        }
        set {
            objc_setAssociatedObject(self, &ly_hudkey.hudkey, newValue as MBProgressHUD, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func showHudInCenterView(_ view : UIView) {
        showHudIncenterView(view, isFilled: false)
    }
    
    public func showHudInCenterFilledView(_ view : UIView) {
        showHudIncenterView(view, isFilled: true)
    }
    
    fileprivate func showHudIncenterView(_ view : UIView, isFilled : Bool) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        if !isFilled {
            hud.frame = CGRect.init(x: 0, y: 64, width: view.width, height: view.height - 64)
        }
        HUD = hud
    }
    
    public func hideHud() {
        HUD.hide(animated: true)
    }
    
    public func showTipHudInCenterView(_ view: UIView, tipString: String) {
        guard tipString.lengthOfBytes(using: String.Encoding(rawValue: String.Encoding.unicode.rawValue)) > 0 else {
            return
        }
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .text
        hud.label.text = tipString
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: 1)
    }
}
