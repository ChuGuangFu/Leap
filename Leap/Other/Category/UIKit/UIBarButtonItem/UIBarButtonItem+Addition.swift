//
//  UIBarButtonItem+Addition.swift
//  Leap
//
//  Created by 梁羽 on 2017/5/26.
//  Copyright © 2017年 梁羽. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    /**
     *  快速创建一个UIBarButtonItem对象 通过给定的标题和tintColor
     */
//    func itemWithTitle(_ title : String, tintColor : UIColor, touchBlock : ) -> Void {
//        
//    }
    
    convenience init(_ title : String?, tintColor : UIColor?, image : UIImage?, target : Any?, selector : Selector?) {
        self.init(image: image, style: .plain, target: target, action: selector)
    }
}
