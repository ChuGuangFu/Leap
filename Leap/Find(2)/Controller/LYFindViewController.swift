//
//  LYFindViewController.swift
//  Leap
//
//  Created by 梁羽 on 2017/5/21.
//  Copyright © 2017年 梁羽. All rights reserved.
//

import UIKit

class LYFindViewController: LYBaseViewController, UITableViewDelegate, UITableViewDataSource {

    var dataArray = [String]()
    var classArray = [String]()
    var tableView = LYBaseTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creatDataSource()
        creatTableView()
    }
    
    func creatDataSource() -> Void {
        //列表展示的数据源
        self.dataArray = ["slide detail", "offset cell", "border line", "xuan zhuan"]
        //列表要跳转类的数据源
        self.classArray = ["SliderDetailViewController", "OffsetCellViewController", "BorderLineViewController", "TestRotationViewController"]
    }
    
    func creatTableView() -> Void {
        tableView = LYBaseTableView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.width, height: self.view.height - NavigationBar_height - BarHeight), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "cellId"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: cellId)
        }
        cell?.textLabel?.text = self.dataArray[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //动态获取命名空间
        let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        let className : AnyObject = NSClassFromString(nameSpace + "." + self.classArray[indexPath.row])!
        let vcClass = className as! UIViewController.Type
        let vc = vcClass.init()
        self.pushVc(vc)
    }
}
