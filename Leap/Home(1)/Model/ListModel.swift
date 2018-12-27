//
//  ListModel.swift
//  Leap
//
//  Created by 梁羽 on 2017/9/1.
//  Copyright © 2017年 梁羽. All rights reserved.
//

import Foundation
import SwiftyJSON

/*
 长贴 -- weiba_post  图片在img下
 
 微帖 -- post 无图
     -- postimage 带图 --  图片在attach_info下
     -- postvideo 带视频 --  图片在attach_info下
 **/

struct ListModel {
    var feed_id : Int?
    var uid : Int?
    var type : String?
    var publish_time : Int64?
    var address : String?
    var from : String?
    var title : String?
    var content : String?
    var comment_count : Int?
    var digg_count : Int?
    var digg_users = [DiggUsers]()
    var img = [WeibaPostImg]()
    var video_info : AttachInfoVideo?
    var attach_info_img = [AttachInfoImg]()
    var user_info : UserInfo
    var comment_info = [CommentInfo]()
    
    init(jsonData : JSON) {
        feed_id = jsonData["feed_id"].intValue
        uid = jsonData["uid"].intValue
        type = jsonData["type"].stringValue
        publish_time = jsonData["publish_time"].int64Value
        address = jsonData["address"].stringValue
        from = jsonData["from"].stringValue
        title = jsonData["title"].stringValue
        content = jsonData["content"].stringValue
        comment_count = jsonData["comment_count"].intValue
        digg_count = jsonData["digg_count"].intValue
        
        for (_,subjson):(String,JSON) in jsonData["digg_users"] {
            let diggUsers = DiggUsers.init(jsonData: subjson)
            self.digg_users.append(diggUsers)
        }
        
        for (_,subjson):(String,JSON) in jsonData["img"] {
            let img = WeibaPostImg.init(jsonData: subjson)
            self.img.append(img)
        }
        
        if type == "postimage" {
            for (_,subjson):(String,JSON) in jsonData["attach_info"] {
                let attachImage = AttachInfoImg.init(jsonData: subjson)
                self.attach_info_img.append(attachImage)
            }
        }
        
        if type == "postvideo" {
            video_info = AttachInfoVideo.init(jsonData: jsonData["video_info"])
        }
        
        user_info = UserInfo.init(jsonData: jsonData["user_info"])
        
        for (_,subjson):(String,JSON) in jsonData["comment_info"] {
            let commentInfo = CommentInfo.init(jsonData: subjson)
            self.comment_info.append(commentInfo)
        }
    }
}

struct DiggUsers {
    var uid : Int?
    var uname : String?
    var avatar : String?
    
    init(jsonData : JSON) {
        uid = jsonData["uid"].intValue
        uname = jsonData["uname"].stringValue
        avatar = jsonData["avatar"].stringValue
    }
}

struct WeibaPostImg {
    var small : String?
    var big : String?
    
    init(jsonData : JSON) {
        small = jsonData["small"].stringValue
        big = jsonData["big"].stringValue
    }
}

struct AttachInfoVideo {
    var video_id : Int?
    var flashimg : String?
    var flash_width : Int?
    var flash_height : Int?
    var flashvar : String?
    
    init(jsonData : JSON) {
        video_id = jsonData["video_id"].intValue
        flashimg = jsonData["flashimg"].stringValue
        flash_width = jsonData["flash_width"].intValue
        flash_height = jsonData["flash_height"].intValue
        flashvar = jsonData["flashvar"].stringValue
    }
}

struct AttachInfoImg {
    var attach_id : Int?
    var attach_origin : String?
    var attach_middle : String?
    var attach_small : String?
    var attach_origin_width : Int?
    var attach_origin_height : Int?
    
    init(jsonData : JSON) {
        attach_id = jsonData["attach_id"].intValue
        attach_origin = jsonData["attach_origin"].stringValue
        attach_middle = jsonData["attach_middle"].stringValue
        attach_small = jsonData["attach_small"].stringValue
        attach_origin_width = jsonData["attach_origin_width"].intValue
        attach_origin_height = jsonData["attach_origin_height"].intValue
    }
}

struct UserInfo {
    var uid : Int?
    var uname : String?
    var avatar_middle : String?
    
    init(jsonData : JSON) {
        uid = jsonData["uid"].intValue
        uname = jsonData["uname"].stringValue
        avatar_middle = jsonData["avatar"]["avatar_middle"].stringValue
    }
}

struct CommentInfo {
    var uname : String?
    var content : String?
    var comment_id : Int?
    
    init(jsonData : JSON) {
        uname = jsonData["user_info"]["uname"].stringValue
        content = jsonData["content"].stringValue
        comment_id = jsonData["comment_id"].intValue
    }
}
