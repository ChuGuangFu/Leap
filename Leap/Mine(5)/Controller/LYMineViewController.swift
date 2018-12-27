//
//  LYMineViewController.swift
//  Leap
//
//  Created by 梁羽 on 2017/5/21.
//  Copyright © 2017年 梁羽. All rights reserved.
//

import UIKit

class LYMineViewController: LYBaseViewController,CardViewDelegate, CardViewDataSource {
    
    var dataArray = Array<CardItemModel>()
    lazy var cardView : CardView = {
        let cardV = CardView.init(frame: CGRect.init(x: 20.0, y: 50.0, width: self.view.width - 40.0, height: 400))
        cardV.delegate = self
        cardV.dataSource = self
        return cardV
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.cardView.backgroundColor = UIColor.red.withAlphaComponent(0.3)
        self.view.addSubview(self.cardView)
        loadData()
    }
    
    func loadData() -> Void {
        self.dataArray.removeAll()
        for i in 0...5 {
            let model = CardItemModel()
            model.imageName = "\(i+1)" + ".jpg"
            self.dataArray.append(model)
        }
        self.cardView.reloadData()
    }
    
    func numberOfItemViewsInCardView(_ cardView: CardView) -> Int {
        return self.dataArray.count
    }
    
    func cardView(_ cardView: CardView, itemViewAtIndex index: NSInteger) -> CardItemView {
        let itemView = CardItemView.init(frame: self.cardView.bounds)
        itemView.sendModel(model: self.dataArray[index])
        return itemView
    }
    
    func cardViewNeedMoreData(_ cardView: CardView) {
        loadData()
        self.cardView.reloadData()
    }
    
    
}
