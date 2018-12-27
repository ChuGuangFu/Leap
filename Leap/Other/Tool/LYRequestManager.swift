//
//  LYRequestManager.swift
//  Leap
//
//  Created by 梁羽 on 2017/5/26.
//  Copyright © 2017年 梁羽. All rights reserved.
//

import UIKit
import AFNetworking
import Alamofire

enum MethodType {
    case get
    case post
}

class LYRequestManager {
    
    static let share : LYRequestManager = LYRequestManager()
    private init() {}

    func httpRequest() -> Void {
        let manager = AFHTTPSessionManager.init()
        manager.get("11", parameters: nil, progress: { (progress) in
            
        }, success: { (task, responseObject) in
            
        }) { (task, error) in
            
        }
    }
    
    func requestData(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallBack : @escaping (_ result : Any) -> (), failureCallback : @escaping (_ reason : String) -> ()) {
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            switch response.result {
                case .success:
                    if let result = response.result.value {
                        finishedCallBack(result)
                    }
                case .failure:
                    failureCallback("请求失败，请重试")
            }
        }
    }
}
