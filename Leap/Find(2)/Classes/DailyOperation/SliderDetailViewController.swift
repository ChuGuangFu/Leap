//
//  SliderDetailViewController.swift
//  Leap
//
//  Created by 梁羽 on 2018/2/3.
//  Copyright © 2018年 梁羽. All rights reserved.
//

import UIKit

class SliderDetailViewController: LYBaseTableViewController {

    var scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "slide detail"
        creatView()
    }
    
    func creatView() -> Void {
        self.tableView.frame = CGRect.init(x: 0, y: 0, width: self.view.width, height: self.view.height - NavigationBar_height)
        self.view.addSubview(self.tableView)
        
        scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.width, height: self.view.width))
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        tableView.tableHeaderView = scrollView
        
        for index in 0...5 {
            let imgView = UIImageView.init(frame: CGRect.init(x: self.view.width * CGFloat(index), y: 0, width: self.view.width, height: self.view.width))
            imgView.image = UIImage.init(named: "offset_\(index)")
            imgView.contentMode = .scaleAspectFill
            scrollView.addSubview(imgView)
        }
        scrollView.contentSize = CGSize.init(width: self.view.width * CGFloat(6), height: self.view.width)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "cellId"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: cellId)
        }
        cell?.textLabel?.text = "第\(indexPath.row)行"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            return
        }
        let offsetY = scrollView.contentOffset.y
        if offsetY >= 0 && offsetY <= UIScreen.main.bounds.size.width {
            self.scrollView.contentInset = UIEdgeInsets.init(top: offsetY/3.0, left: 0, bottom: -offsetY/3.0, right: 0)
        }
    }
}
