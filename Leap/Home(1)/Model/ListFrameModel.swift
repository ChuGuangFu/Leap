//
//  ListFrameModel.swift
//  Leap
//
//  Created by 梁羽 on 2017/9/1.
//  Copyright © 2017年 梁羽. All rights reserved.
//

import UIKit

class ListFrameModel : NSObject {
    
    var model : ListModel? = nil
    
    var headerViewF = CGRect.zero
    var avatarF = CGRect.zero
    var unameF = CGRect.zero
    var fromF = CGRect.zero
    var levelF = CGRect.zero
    var careBtnF = CGRect.zero
    
    var contentViewF = CGRect.zero
    var contentTitleF = CGRect.zero
    var contentTextF = CGRect.zero
    
    var imgViewF = CGRect.zero
    var imgFrameArr = Array<CGRect>()
    
    var toolBarF = CGRect.zero
    var addressTBF = CGRect.zero
    var diggTBF = CGRect.zero
    var commentTBF = CGRect.zero
    
    var diggViewF = CGRect.zero
    var commentViewF = CGRect.zero
    var cellHeight : CGFloat = 0.00
    
    convenience init(model : ListModel) {
        self.init()
        self.model = model
        
        self.calculateHeaderViewFrame()
        self.calculateContentViewFrame()
        self.calculateImageOrVideoViewFrame()
        self.calculateToolBarFrame()
    }
    
    func calculateHeaderViewFrame() {
        self.headerViewF = CGRect.init(x: 0, y: 0, width: Screen_width, height: CGFloat(homeHeader_leftMargin + homeHeader_avatarHeight + 5))
        
        self.avatarF = CGRect.init(x: homeHeader_leftMargin, y: homeHeader_leftMargin, width: homeHeader_avatarHeight, height: homeHeader_avatarHeight)
        
        let unameWidth = self.model?.user_info.uname?.widthForFont(UIFont.systemFont(ofSize: 16))
        self.unameF = CGRect.init(x: self.avatarF.maxX + 10, y: self.avatarF.origin.y, width: unameWidth!, height: 18)
        
        self.fromF = CGRect.init(x: self.unameF.origin.x, y: self.unameF.maxY + 5, width: 200, height: 13)
        
        self.levelF = CGRect.init(x: self.unameF.maxX + 10, y: self.unameF.origin.y, width: 32, height: 12.3)
        
        self.careBtnF = CGRect.init(x: Screen_width - 56 - 12, y: CGFloat(homeHeader_leftMargin), width: 56, height: 26)
        
        self.cellHeight += self.headerViewF.height
    }
    
    func calculateContentViewFrame() {
        guard self.model?.title != nil || self.model?.content != nil else {
            self.contentViewF = CGRect.init(x: 0, y: self.headerViewF.maxY, width: Screen_width, height: 0)
            return
        }
        let contentTitleHeight : CGFloat = ((self.model?.title) != "") ? 14 : 0
        self.contentTitleF = CGRect.init(x: CGFloat(homeHeader_leftMargin), y: 0, width: Screen_width - CGFloat(2 * homeHeader_leftMargin), height: contentTitleHeight)
        
        var contentTextHeight : CGFloat = 0.0
        if self.model?.content == nil {
            contentTextHeight = 0
        }else {
            contentTextHeight = (self.model?.content?.heightForFont(UIFont.systemFont(ofSize: 13), width: self.contentTitleF.width))!
            //contentTextHeight = contentTextHeight > 100 ? 102 : contentTextHeight
        }
        self.contentTextF = CGRect.init(x: self.contentTitleF.origin.x, y: self.contentTitleF.maxY + (contentTitleHeight > 0 ? 5 : 0), width: self.contentTitleF.width, height: contentTextHeight)
        
        self.contentViewF = CGRect.init(x: 0, y: self.headerViewF.maxY, width: Screen_width, height: self.contentTextF.maxY)
        
        self.cellHeight += self.contentViewF.height
    }
    
    func calculateImageOrVideoViewFrame() {
        guard let typeStr = self.model?.type else { //error type
            self.imgViewF = CGRect.init(x: 0, y: self.contentViewF.maxY, width: 0, height: 0)
            return
        }
        let postImgViewWidth = Screen_width - 2 * homeHeader_leftMargin
        switch typeStr {
            case "weiba_post": //img contains image
                guard let imgCount = self.model?.img.count else {
                    self.imgViewF = CGRect.init(x: homeHeader_leftMargin, y: self.contentViewF.maxY, width: postImgViewWidth, height: 0)
                    return
                }
                calculateAndStorageEveryImgFrame(imgArrayCount: imgCount)
            case "post": //no image
                self.imgViewF = CGRect.init(x: homeHeader_leftMargin, y: self.contentViewF.maxY, width: postImgViewWidth, height: 0)
            case "postimage": //attach_info_img contains image
                guard let imgCount = self.model?.attach_info_img.count else {
                    self.imgViewF = CGRect.init(x: homeHeader_leftMargin, y: self.contentViewF.maxY, width: postImgViewWidth, height: 0)
                    return
                }
                calculateAndStorageEveryImgFrame(imgArrayCount: imgCount)
            case "postvideo": //a video
                self.imgViewF = CGRect.init(x: homeHeader_leftMargin, y: self.contentViewF.maxY, width: postImgViewWidth, height: homeVideoInfoHeight)
            default:
                self.imgViewF = CGRect.init(x: homeHeader_leftMargin, y: self.contentViewF.maxY, width: postImgViewWidth, height: 0)
        }
        self.cellHeight += self.imgViewF.height
    }
    
    func calculateAndStorageEveryImgFrame(imgArrayCount : Int) {
        let postImgViewWidth = Screen_width - 2 * homeHeader_leftMargin
        let imgWidth = (postImgViewWidth - 10) / 3.0  //两个图片的间距为5
        var imgRect = CGRect.zero
        for index in 0..<imgArrayCount {
            let imgX = imgWidth * CGFloat(index % 3) + CGFloat((index % 3) * 5)
            let imgY = imgWidth * CGFloat(index / 3) + CGFloat((index / 3) * 5)
            imgRect = CGRect.init(x: imgX, y: imgY, width: imgWidth, height: imgWidth)
            self.imgFrameArr.append(imgRect)
        }
        self.imgViewF = CGRect.init(x: homeHeader_leftMargin, y: self.contentViewF.maxY, width: postImgViewWidth, height: imgRect.maxY)
    }
    
    func calculateToolBarFrame() {
        self.toolBarF = CGRect.init(x: homeHeader_leftMargin, y: self.imgViewF.maxY, width: Screen_width - 2 * homeHeader_leftMargin, height: homeToolBarHeight)
        
        self.addressTBF = CGRect.init(x: 0, y: 0, width: 120, height: self.toolBarF.height)
        self.commentTBF = CGRect.init(x: self.toolBarF.width - homeToolBarCommentWidth, y: 0, width: homeToolBarCommentWidth, height: self.toolBarF.height)
        self.diggTBF = CGRect.init(x: self.commentTBF.origin.x - homeToolBarCommentWidth - 10, y: 0, width: homeToolBarCommentWidth, height: self.toolBarF.height)
        
        self.cellHeight += self.toolBarF.height
    }
    
    func calculateDiggViewFrame() {
        guard let _ = self.model?.digg_users.count else {
            self.diggViewF = CGRect.init(x: 0, y: self.toolBarF.maxY, width: 0, height: 0)
            return
        }
    }
}
