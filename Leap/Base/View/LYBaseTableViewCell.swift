//
//  LYBaseTableViewCell.swift
//  Leap
//
//  Created by 梁羽 on 2017/6/11.
//  Copyright © 2017年 梁羽. All rights reserved.
//

import UIKit

class LYBaseTableViewCell: UITableViewCell {

    //这么写有问题--暂时没解决了，先就不封装了
    class func cellWithTableView(_ tableView: UITableView?) -> UITableViewCell {
        guard let table = tableView else {
            return self.init()
        }
        let className = NSStringFromClass(self)
        let identifier = className.appending("CellID")
        table.register(self, forCellReuseIdentifier: identifier)
        return (table.dequeueReusableCell(withIdentifier: identifier))!
    }

}
