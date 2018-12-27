//
//  LYHomeViewController.swift
//  Leap
//
//  Created by 梁羽 on 2017/5/21.
//  Copyright © 2017年 梁羽. All rights reserved.
//

import UIKit
import SwiftyJSON

class LYHomeViewController: LYBaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    var dataArray = [ListFrameModel]()
    
    lazy var tableView : LYBaseTableView = {
        let tabView = LYBaseTableView.init(frame: CGRect.init(x: 0, y: 0, width: Screen_width, height: Screen_height - NavigationBar_height - TabBar_height), style: .plain)
        tabView.delegate = self
        tabView.dataSource = self
        return tabView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(self.tableView)
        ListRefresh.addLoadMoreForScrollView(self.tableView) { [weak self]() in
            if let str = self?.dataArray.last?.model?.feed_id {
                self?.requestData(max_id: String(str))
            }
        }
        requestData(max_id: "f")
    }
    
    func requestData(max_id : String) {
        if max_id == "f" {
            showFullLoadingAnimation()
        }
        LYRequestManager.share.requestData(.get, URLString: ListApi + "&max_id=\(max_id)", finishedCallBack: { (responseObject) in
            let json = JSON(responseObject)
            if json["status"].intValue == 1 {
                for (_,subjson):(String,JSON) in json["data"] {
                    let model = ListModel.init(jsonData: subjson)
                    let frameModel = ListFrameModel.init(model: model)
                    self.dataArray.append(frameModel)
                }
            }
            self.hideLoadingAnimation()
            ListRefresh.endLoadMoreForScrollView(self.tableView)
            self.tableView.reloadData()
        }) { (failureStr) in
            self.hideLoadingAnimation()
            ListRefresh.endLoadMoreForScrollView(self.tableView)
            self.showTipHudAnimationWithTipString(failureStr)
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let frameModel = self.dataArray[indexPath.section]
        return frameModel.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "homeListCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? LYHomeListCell
        if cell == nil {
            cell = LYHomeListCell.init(style: .default, reuseIdentifier: cellID)
            cell?.selectionStyle = .none
        }
        cell?.updataModel(frameModel: self.dataArray[indexPath.section])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushVc(TestVC())
    }
}
