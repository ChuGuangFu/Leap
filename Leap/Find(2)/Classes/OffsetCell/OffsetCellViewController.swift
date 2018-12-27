//
//  OffsetCellViewController.swift
//  Leap
//
//  Created by 梁羽 on 2018/2/8.
//  Copyright © 2018年 梁羽. All rights reserved.
//

import UIKit

class OffsetCellViewController: LYBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "offset cell"
        creatView()
    }
    
    func creatView() -> Void {
        self.tableView.frame = CGRect.init(x: 0, y: 0, width: Screen_width, height: Screen_height - NavigationBar_height)
        self.view.addSubview(self.tableView)
        self.tableView.register(OffsetCell.classForCoder(), forCellReuseIdentifier: "OffsetCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 440 + 30
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let offsetCell : OffsetCell = tableView.dequeueReusableCell(withIdentifier: "OffsetCell") as! OffsetCell
        offsetCell.loadImg(indexPath: indexPath)
        return offsetCell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let offsetCell = cell as! OffsetCell
        offsetCell.cellOffset()
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let offsetCell = cell as! OffsetCell
        offsetCell.cancelAnimation()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let array : [OffsetCell] = self.tableView.visibleCells as! [OffsetCell]
        for cell : OffsetCell in array {
            cell.cellOffset()
        }
    }
}
