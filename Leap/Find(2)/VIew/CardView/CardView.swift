//
//  CardView.swift
//  Leap
//
//  Created by 梁羽 on 2017/6/20.
//  Copyright © 2017年 梁羽. All rights reserved.
//

import UIKit

protocol CardViewDelegate : NSObjectProtocol {
    func cardView(_ cardView: CardView, didClickItemAtIndex index: NSInteger)
}

extension CardViewDelegate {
    func cardView(_ cardView: CardView, didClickItemAtIndex index: NSInteger) {
        
    }
}

protocol CardViewDataSource {
    func numberOfItemViewsInCardView(_ cardView: CardView) -> Int
    func cardView(_ cardView: CardView, itemViewAtIndex index: NSInteger) -> CardItemView
    func cardViewNeedMoreData(_ cardView: CardView)
    func cardView(_ cardView: CardView, sizeForItemViewAtIndex index: NSInteger) -> CGSize
}

extension CardViewDataSource {
    func cardView(_ cardView: CardView, sizeForItemViewAtIndex index: NSInteger) -> CGSize {
        return CGSize.init(width: 0, height: 0)
    }
}

class CardView: UIView {

    var delegate : CardViewDelegate? = nil
    var dataSource : CardViewDataSource? = nil
    var itemViewCount = 0 //item的个数

    public func deleteTheTopItemViewWithLeft(_ left: Bool) {
        let itemView = self.subviews.last as! CardItemView
        itemView.removeWithLeft(left)
    }
    
    public func reloadData() {
        guard self.dataSource != nil else {
            return
        }
        //1.移除
        _ = self.subviews.map {$0.removeFromSuperview()}
        //2.创建
        self.itemViewCount = self.numberOfItemViews()
        for i in 0..<self.itemViewCount {
            //let size = self.itemViewSizeAtIndex(i)
            let itemView = self.itemViewAtIndex(i)
            itemView.backgroundColor = UIColor.green
            self.addSubview(itemView)
            itemView.delegate = self as? CardItemViewDelegate
            //itemView.frame = CGRect.init(x: self.width / 2.0 - size.width / 2.0, y: self.height / 2.0 - size.height / 2.0, width: size.width, height: size.height)
            itemView.frame = self.bounds
            itemView.tag = i + 1
            //itemView.transform = .init(translationX: self.width + 500, y: 400)
//            UIView.animateKeyframes(withDuration: 0.15, delay: 0, options: .calculationModeLinear, animations: { 
//                //let scaleTransform = CGAffineTransform.init(scaleX: CGFloat(1 - 0.005 * Double((10 - i))), y: 1)
//                itemView.transform = CGAffineTransform.init(scaleX: 0, y: CGFloat(0.5 * Double((10 - i))))
//            }, completion: { (finished) in
//                
//            })
            itemView.isUserInteractionEnabled = true
            itemView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(tapGestHandle(_:))))
        }
    }
}

//MARK: CardViewDataSource
extension CardView {
    //MARK:返回item的size
    fileprivate func itemViewSizeAtIndex(_ index: Int) -> CGSize {
        guard index < self.numberOfItemViews() else {
            return self.frame.size
        }
        var size = self.dataSource?.cardView(self, sizeForItemViewAtIndex: index)
        if (size?.width)! > self.width || size?.width == 0 {
            size?.width = self.width
        } else if (size?.height)! > self.height || size?.height == 0 {
            size?.height = self.height
        }
        return size!
    }
    
    //MARK:返回item的view的视图
    fileprivate func itemViewAtIndex(_ index: Int) -> CardItemView {
        let itemView = self.dataSource?.cardView(self, itemViewAtIndex: index)
        guard itemView != nil else {
            return CardItemView()
        }
        return itemView!
    }
    
    //MARK:item的个数
    fileprivate func numberOfItemViews() -> Int {
        return (self.dataSource?.numberOfItemViewsInCardView(self))!
    }
}

//MARK:CardViewDelegate
extension CardView {
    @objc fileprivate func tapGestHandle(_ tapGest: UITapGestureRecognizer) {
        self.delegate?.cardView(self, didClickItemAtIndex: (tapGest.view?.tag)! - 1)
    }
}
