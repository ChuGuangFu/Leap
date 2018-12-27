//
//  UIView+frame.swift
//  Leap
//
//  Created by 梁羽 on 2017/5/25.
//  Copyright © 2017年 梁羽. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    public var x : CGFloat {
        get{
            return self.frame.origin.x
        }
        set{
            var rect = self.frame
            rect.origin.x = newValue
            self.frame = rect
        }
    }
    public var y : CGFloat {
        get{
            return self.frame.origin.y
        }
        set{
            var rect = self.frame
            rect.origin.y = newValue
            self.frame = rect
        }
    }
    public var centerX : CGFloat {
        get{
            return self.center.x
        }
        set{
            var center = self.center
            center.x = newValue
            self.center = center
        }
    }
    public var centerY : CGFloat {
        get{
            return self.center.y
        }
        set{
            var center = self.center
            center.y = newValue
            self.center = center
        }
    }
    public var width : CGFloat {
        get{
            return self.frame.size.width
        }
        set{
            var rect = self.frame
            rect.size.width = newValue
            self.frame = rect
        }
    }
    public var height : CGFloat {
        get{
            return self.frame.size.height
        }
        set{
            var rect = self.frame
            rect.size.height = newValue
            self.frame = rect
        }
    }
    public var top : CGFloat {
        get{
            return self.frame.origin.y
        }
        set{
            var rect = self.frame
            rect.origin.y = newValue
            self.frame = rect
        }
    }
    public var bottom : CGFloat {
        get{
            return self.frame.origin.y + self.frame.size.height
        }
        set{
            var rect = self.frame
            rect.origin.y = newValue - rect.size.height
            self.frame = rect
        }
    }
    public var left : CGFloat {
        get{
            return self.frame.origin.x
        }
        set{
            var rect = self.frame
            rect.origin.x = newValue
            self.frame = rect
        }
    }
    public var right : CGFloat {
        get{
            return self.frame.origin.x + self.frame.size.width
        }
        set{
            var rect = self.frame
            rect.origin.x = newValue - rect.size.width
            self.frame = rect
        }
    }
    public var size : CGSize {
        get{
            return self.frame.size
        }
        set{
            var rect = self.frame
            rect.size = newValue
            self.frame = rect
        }
    }
    public var origin : CGPoint {
        get{
            return self.frame.origin
        }
        set{
            var rect = self.frame
            rect.origin = newValue
            self.frame = rect
        }
    }
}
