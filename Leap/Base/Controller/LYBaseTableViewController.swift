//
//  LYBaseTableViewController.swift
//  Leap
//
//  Created by 梁羽 on 2017/5/21.
//  Copyright © 2017年 梁羽. All rights reserved.
//

import UIKit

public enum LYBaseTableVcRefreshType {
    /** 无法刷新*/
    case LYBaseTableVcRefreshTypeNone
    /** 只能刷新*/
    case LYBaseTableVcRefreshTypeOnlyCanRefresh
    /** 只能上拉加载*/
    case LYBaseTableVcRefreshTypeOnlyCanLoadMore
    /** 能刷新*/
    case LYBaseTableVcRefreshTypeRefreshAndLoadMore
}

class LYBaseTableViewController: LYBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
//    public var refreshType : LYBaseTableVcRefreshType
    
    public var dataArray = Array<Any>()
    
    /** 是否需要系统分割线*/
    public var isNeedCellSepLine : Bool {
        get {
            return self.tableView.separatorStyle == .none
        }
        set {
            self.isNeedCellSepLine = newValue
            self.tableView.separatorStyle = self.isNeedCellSepLine ? .singleLine : .none
        }
    }
    
    public lazy var tableView : LYBaseTableView = {
       let table = LYBaseTableView.init(frame: self.view.bounds, style: .plain)
        table.delegate = self
        table.dataSource = self
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "cellId"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: cellId)
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard isNeedCellSepLine else {
            return
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//刷新相关
extension LYBaseTableViewController {
    //刷新数据
    public func ly_reloadData() {
        tableView.reloadData()
    }
    //开始下拉
    public func ly_beginRefresh() {
        
    }
}
