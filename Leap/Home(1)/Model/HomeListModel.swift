//
//  HomeListModel.swift
//  Leap
//
//  Created by 梁羽 on 2017/9/3.
//  Copyright © 2017年 梁羽. All rights reserved.
//

import Foundation
import HandyJSON

class HomeListModel : HandyJSON {
    var feed_id : Int?
    var uid : Int?
    var type : String?
    var publish_time : Int64?
    var address : String?
    var from : String?
    var content : String?
    var comment_count : Int?
    var digg_count : Int?
    var digg_users : [HomeDiggUsers]?
    var img : [HomeWeibaPostImg]?
//    var attach_info_video : HomeAttachInfoVideo
    var attach_info_img : [HomeAttachInfoImg]?
//    var user_info : HomeUserInfo
    var comment_info : [HomeCommentInfo]?
    
    required init() {}
}

class HomeDiggUsers : HandyJSON {
    var uid : Int?
    var uname : String?
    var avatar : String?
    required init() {}
}

class HomeWeibaPostImg : HandyJSON{
    var small : String?
    var big : String?
    required init() {}
}

class HomeAttachInfoVideo {
    var video_id : Int?
    var flashimg : String?
    var flash_width : Int?
    var flash_height : Int?
    var flashvar : String?
    required init() {}
}

class HomeAttachInfoImg : HandyJSON {
    var attach_id : Int?
    var attach_origin : String?
    var attach_middle : String?
    var attach_small : String?
    var attach_origin_width : Int?
    var attach_origin_height : Int?
    required init() {}
}

class HomeUserInfo : HandyJSON {
    var uid : Int?
    var uname : String?
    var avatar_middle : String?
    required init() {}
}

class HomeCommentInfo : HandyJSON {
    var uname : String?
    var content : String?
    required init() {}
}
