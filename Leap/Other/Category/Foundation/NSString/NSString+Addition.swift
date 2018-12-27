//
//  NSString+Addition.swift
//  Leap
//
//  Created by 梁羽 on 2017/6/8.
//  Copyright © 2017年 梁羽. All rights reserved.
//

import Foundation

extension String {
    
    //祛除字符串中的空格和换行
    public func noWhiteSpaceString() -> String {
        var newString = self
        newString = newString.replacingOccurrences(of: "\r", with: "")
        newString = newString.replacingOccurrences(of: "\n", with: "")
        newString = newString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        newString = newString.replacingOccurrences(of: " ", with: "")
        return newString
    }
    
    //计算字符串的高度
    public func heightForFont(_ font: UIFont, width: CGFloat) -> CGFloat {
        let string : NSString = self as NSString
        return string.boundingRect(with: CGSize.init(width: width, height: CGFloat(HUGE)), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : font], context: nil).size.height
    }
    
    //计算字符串的宽度
    public func widthForFont(_ font: UIFont) -> CGFloat {
        let string : NSString = self as NSString
        return string.boundingRect(with: CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : font], context: nil).size.width
    }
    
    //时间戳转时间
    public func datestrFromData(_ date: Date, format: String) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        return dateFormat.string(from: date)
    }
    
    //几天前  几分钟前....
    public func updateTimeForTimeInterval(_ timeInterval: Int32) -> String {
        //获取当前时间时间戳 1466386762.345715 十位整数 6位小数
        let currentTime = Date().timeIntervalSince1970
        // 创建时间戳(后台返回的时间 一般是13位数字)
        let creatTime : TimeInterval = TimeInterval(timeInterval)
        //时间差
        let time = currentTime - creatTime
        if time < 60 {
            return "刚刚"
        }
        //秒转分钟
        let minutes : Int32 = Int32(time / 60)
        if minutes < 60 {
            return "\(minutes)分钟前"
        }
        //秒转小时
        let hours : Int32 = Int32(time / 3600)
        if hours < 24 {
            return "\(hours)小时前"
        }
        // 秒转天数
        let days : Int32 = Int32(time / 3600 / 24)
        if days < 30 {
            return "\(days)天前"
        }
        // 秒转月
        let months : Int32 = Int32(time / 3600 / 24 / 30)
        if months < 12 {
            return "\(months)月前"
        }
        // 秒转年
        let years : Int32 = Int32(time / 3600 / 24 / 30 / 12)
        return "\(years)年前"
    }
    
    //公共富文本
    public func attStringWithString(_ string: String?, keyWord: String?, font: UIFont = UIFont.systemFont(ofSize: 16), highlightedColor: UIColor, textColor: UIColor, lineSpace: CGFloat = 2.0) -> NSAttributedString {
        
        guard let str = string else {
            return NSAttributedString()
        }
        
        //目标字符串不为空
        let attStr = NSMutableAttributedString.init(string: str)
        guard let keyStr = keyWord else {
            let allRange = NSMakeRange(0, str.characters.count)
            attStr.addAttributes([NSFontAttributeName : font], range: allRange)
            attStr.addAttributes([NSForegroundColorAttributeName : textColor], range: allRange)
            let style = NSMutableParagraphStyle()
            style.lineSpacing = lineSpace
            attStr.addAttributes([NSParagraphStyleAttributeName : style], range: allRange)
            return attStr
        }
        //关键字不为空
        let range : NSRange = (str as NSString).range(of: keyStr, options: .caseInsensitive)
        if range.location != NSNotFound {
            //找到了关键字
            let allRange = NSMakeRange(0, str.characters.count)
            attStr.addAttributes([NSFontAttributeName : font], range: allRange)
            attStr.addAttributes([NSForegroundColorAttributeName : textColor], range: allRange)
            attStr.addAttributes([NSForegroundColorAttributeName : highlightedColor], range: range)
            let style = NSMutableParagraphStyle()
            style.lineSpacing = lineSpace
            attStr.addAttributes([NSParagraphStyleAttributeName : style], range: allRange)
        } else {
            let allRange = NSMakeRange(0, str.characters.count)
            attStr.addAttributes([NSFontAttributeName : font], range: allRange)
            attStr.addAttributes([NSForegroundColorAttributeName : textColor], range: allRange)
            let style = NSMutableParagraphStyle()
            style.lineSpacing = lineSpace
            attStr.addAttributes([NSParagraphStyleAttributeName : style], range: allRange)
            return attStr
        }
        return attStr
    }
    
    /**
     *  计算当前文件\文件夹的内容大小
     */
    public static func fileSize(_ filePath: String) -> UInt64 {
        let mgr = FileManager.default
        //判断是否为文件 默认为no
        var dir : ObjCBool = false
        let exists = mgr.fileExists(atPath: filePath, isDirectory: &dir)
        guard exists else {
            return 0
        }
        if dir.boolValue { //文件
            //遍历caches里面的所有内容 -- 直接和间接内容
            let subPaths = mgr.subpaths(atPath: filePath)
            var totalByteSize : UInt64 = 0
            guard let subpath = subPaths else {
                return totalByteSize
            }
            for subPStr in subpath {
                //获得全路径
                let fullSubPath = filePath.appending("/\(subPStr)")
                //判断是否为文件
                var dirB : ObjCBool = false
                mgr.fileExists(atPath: fullSubPath, isDirectory: &dirB)
                if dirB.boolValue == false { //文件
                    do {
                        totalByteSize += (try mgr.attributesOfItem(atPath: fullSubPath))[FileAttributeKey.size] as! UInt64
                    }catch {
                        print("读取文件大小出错了")
                    }
                }
            }
            return totalByteSize
        }else { //文件夹
            do {
                return (try mgr.attributesOfItem(atPath: filePath))[FileAttributeKey.size] as! UInt64
            }catch {
                return 0
            }
        }
    }
}
