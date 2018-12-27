//
//  LYBaseViewController.swift
//  Leap
//
//  Created by 梁羽 on 2017/5/21.
//  Copyright © 2017年 梁羽. All rights reserved.
//

import UIKit

let RVC_NAVIGATION_TITLE = "RVC_NAVIGATION_TITLE"
let RVC_TABBAR_TITLE = "RVC_TBBBAR_TITLE"

class LYBaseViewController: UIViewController {
    
    var safeInsets = UIEdgeInsets.init(top: 20, left: 0, bottom: 0, right: 0)
    
    public func initAttributed(title : String) {
        self.title = title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.setAnimationsEnabled(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        //let gestureArray = self.navigationController?.view.gestureRecognizers
        if let gestureArray = self.navigationController?.view.gestureRecognizers {
            //当是侧滑手势的时候设置scrollview需要此手势失效才生效即可
            for gesture in gestureArray {
                guard gesture.isKind(of: UIScreenEdgePanGestureRecognizer.self) else {
                    return
                }
                for subView in self.view.subviews {
                    if subView.isKind(of: UIScrollView.self) {
                        let sc = subView as! UIScrollView
                        sc.panGestureRecognizer.require(toFail: gesture)
                    }
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        UIView.setAnimationsEnabled(true)
        self.automaticallyAdjustsScrollViewInsets = false
        self.edgesForExtendedLayout = .all
    }
    
    override func viewSafeAreaInsetsDidChange() {
        if #available(iOS 11.0, *) {
            super.viewSafeAreaInsetsDidChange()
            safeInsets = self.view.safeAreaInsets
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print(NSStringFromClass(self.classForCoder), "页面成功销毁了")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print(NSStringFromClass(self.classForCoder), "页面收到了内存警告⚠️")
    }
}

//MARK:提示框的扩展
extension LYBaseViewController {
    /** 上方留白加载中*/
    final func showLoadingAnimation() {
        self.view.showHudInCenterView(self.view)
    }
    /** 上方不留白加载中*/
    final func showFullLoadingAnimation() {
        self.view.showHudInCenterFilledView(self.view)
    }
    /** 文字提示框*/
    final func showTipHudAnimationWithTipString(_ tipString: String) {
        self.view.showTipHudInCenterView(self.view, tipString: tipString)
    }
    /** 停止加载*/
    final func hideLoadingAnimation() {
        self.view.hideHud()
    }
}

//MARK:页面跳转
extension LYBaseViewController {
    
    final func pop() {
        guard self.navigationController != nil else {
            return
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    final func popToRootVc() {
        guard self.navigationController != nil else {
            return
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    final func popToVc(_ vc: UIViewController) {
        guard vc.isKind(of: UIViewController.self) else {
            return
        }
        guard self.navigationController != nil else {
            return
        }
        self.navigationController?.popToViewController(vc, animated: true)
    }
    
    final func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    final func dismissWithCompletetion(completion: (() -> Void)?) {
        self.dismiss(animated: true, completion: completion)
    }
    
    final func presentVC(_ vc: UIViewController) {
        guard vc.isKind(of: UIViewController.self) else {
            return
        }
        self.presentVC(vc)
    }
    
    final func presentVc(_ vc: UIViewController, completion: (() -> Void)) {
        guard vc.isKind(of: UIViewController.self) else {
            return
        }
        self.presentVc(vc, completion: completion)
    }
    
    final func pushVc(_ vc: UIViewController) {
        guard vc.isKind(of: UIViewController.self) else {
            return
        }
        guard self.navigationController != nil else {
            return
        }
        if vc.hidesBottomBarWhenPushed == false {
            vc.hidesBottomBarWhenPushed = true
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    final func removeChildVc(_ vc: UIViewController) {
        guard vc.isKind(of: UIViewController.self) else {
            return
        }
        vc.view.removeFromSuperview()
        vc.willMove(toParentViewController: nil)
        vc.removeFromParentViewController()
    }
    
    final func addChildVc(_ vc: UIViewController) {
        guard vc.isKind(of: UIViewController.self) else {
            return
        }
        vc.willMove(toParentViewController: self)
        self.addChildVc(vc)
        self.view.addSubview(vc.view)
        vc.view.frame = self.view.frame
    }
}

//MARK:结束事件
extension LYBaseViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
