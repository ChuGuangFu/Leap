//
//  UIColor+LYColor.swift
//  Leap
//
//  Created by 梁羽 on 2017/6/5.
//  Copyright © 2017年 梁羽. All rights reserved.
//

import UIKit

extension UIColor {
    /// rgb颜色
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(r: r, g: g, b: b, a: 1)
    }
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    //随机颜色
    class func randomCOlor() -> UIColor {
        return UIColor.init(r: CGFloat(arc4random_uniform(256)) / 255.0, g: CGFloat(arc4random_uniform(256)) / 255.0, b: CGFloat(arc4random_uniform(256)) / 255.0)
    }
    
    //十六进制颜色
    class func colorWithHexString(_ hexStr: String) -> UIColor {
        var r : CGFloat = 0
        var g : CGFloat = 0
        var b : CGFloat = 0
        var a : CGFloat = 0
        guard hexToRGBA(hexStr, r: &r, g: &g, b: &b, a: &a) else {
            return UIColor.clear
        }
        return UIColor.init(red: r, green: g, blue: b, alpha: a)
    }
    
    fileprivate class func hexToRGBA(_ str: String, r: inout CGFloat, g: inout CGFloat, b: inout CGFloat, a: inout CGFloat) -> Bool {
        var hexStr = str
        hexStr = str.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if hexStr.hasPrefix("#") {
            let index = hexStr.index(hexStr.startIndex, offsetBy: 1)
            hexStr = hexStr.substring(from: index)
        }else if hexStr.hasPrefix("0X") {
            let index = hexStr.index(hexStr.startIndex, offsetBy: 2)
            hexStr = hexStr.substring(from: index)
        }
        let strLength = hexStr.characters.count
        //           RGB            RGBA          RRGGBB        RRGGBBAA
        if strLength != 3,strLength != 4,strLength != 6,strLength != 8 {
            return false
        }
        //RGB,RGBA,RRGGBB,RRGGBBAA
        if strLength < 5 {
            let ocHexStr = hexStr as NSString
            r = hexStrToFloat(ocHexStr.substring(with: NSMakeRange(0, 1))) / 255.0
            g = hexStrToFloat(ocHexStr.substring(with: NSMakeRange(1, 1))) / 255.0
            b = hexStrToFloat(ocHexStr.substring(with: NSMakeRange(2, 1))) / 255.0
            if strLength == 4 {
                a = hexStrToFloat(ocHexStr.substring(with: NSMakeRange(3, 1))) / 255.0
            }else {
                a = 1
            }
        } else {
            let ocHexStr = hexStr as NSString
            r = hexStrToFloat(ocHexStr.substring(with: NSMakeRange(0, 2))) / 255.0
            g = hexStrToFloat(ocHexStr.substring(with: NSMakeRange(2, 2))) / 255.0
            b = hexStrToFloat(ocHexStr.substring(with: NSMakeRange(4, 2))) / 255.0
            if strLength == 8 {
                a = hexStrToFloat(ocHexStr.substring(with: NSMakeRange(6, 2))) / 255.0
            }else {
                a = 1
            }
        }
        return true
    }
    
    fileprivate class func hexStrToFloat(_ str: String) -> CGFloat {
        let result = radixConvert(UnsafeMutablePointer<Int8>(mutating: (str as NSString).utf8String))
        return CGFloat(result)
    }
    
    /** color生成image*/
    public func imageWithColor(_ color: UIColor) -> UIImage {
        let rect = CGRect.init(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
