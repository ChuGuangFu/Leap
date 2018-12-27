//
//  CardItemView.swift
//  Leap
//
//  Created by 梁羽 on 2017/6/20.
//  Copyright © 2017年 梁羽. All rights reserved.
//

/**
 处理每个视图的 左滑 右滑 事件 等
 */

import UIKit

protocol CardItemViewDelegate {
    func cardItemViewDidRemoveFromSuperView(_ cardItemView: CardItemView) -> Void
}

class CardItemView: UIView {

    var delegate : CardItemViewDelegate? = nil
    var originalCenter : CGPoint = CGPoint.init(x: 0, y: 0)
    var currentAngle : CGFloat = 0.0
    var isLeft : Bool = false
    var model : CardItemModel?
    
    lazy var imageView : UIImageView = {
        let imageV = UIImageView.init()
        imageV.clipsToBounds = true
        return imageV
    }()
    
    func sendModel(model: CardItemModel) -> Void {
        self.imageView.image = UIImage.init(named: model.imageName!)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView.frame = self.bounds
        self.addSubview(self.imageView)
        originalCenter = CGPoint.init(x: frame.size.width / 2.0, y: frame.size.height / 2.0)
        addPanGest()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:添加拖拽手势
    func addPanGest() {
        self.isUserInteractionEnabled = true
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(panGestHandle(_:)))
        self.addGestureRecognizer(pan)
    }
    
    func configLayer() -> Void {
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
        self.layer.shouldRasterize = true
    }
    
    //MARK:拖拽手势的响应事件
    func panGestHandle(_ panGest: UIPanGestureRecognizer) -> Void {
        if panGest.state == .changed { //拖拽开始
            /*
             locationInView:获取到的是手指点击屏幕实时的坐标点；
             translationInView：获取到的是手指移动后，在相对坐标中的偏移量
             velocityInView： 手指在视图上移动的速度（x,y）, 正负也是代表方向，值得一体的是在绝对值上|x| > |y| 水平移动， |y|>|x| 竖直移动。
             */
            let movePoint = panGest.translation(in: self)
            isLeft = (movePoint.x < 0) //偏移量<0说明是往左滑了
            self.center = CGPoint.init(x: self.center.x + movePoint.x, y: self.center.y + movePoint.y)
            let angle = (self.center.x - self.width / 2.0) / self.width / 4.0
            currentAngle = angle
            self.transform = CGAffineTransform.init(rotationAngle: angle)
            panGest.setTranslation(CGPoint.zero, in: self)
        }else if panGest.state == .ended { //拖拽结束
            let vel = panGest.velocity(in: self)
            if vel.x > 800 || vel.x < -800 {
                remove()
                return
            }
            if self.x + self.width > 150, self.x < self.width - 150 {
                UIView.animate(withDuration: 0.5, animations: { 
                    self.center = self.originalCenter
                    self.transform = CGAffineTransform.init(rotationAngle: 0.0)
                })
            }else {
                remove()
            }
        }
    }
    
    func remove() -> Void {
        UIView.animate(withDuration: 0.3, animations: { 
            if !self.isLeft { //right
                self.center = CGPoint.init(x: self.width + 1000, y: self.centerY + self.currentAngle * self.height)
            } else { //left
                self.center = CGPoint.init(x: -1000, y: self.centerY - self.currentAngle * self.height)
            }
        }) { (finished) in
            if finished {
                self.removeFromSuperview()
                self.delegate?.cardItemViewDidRemoveFromSuperView(self)
            }
        }
    }
    
    func removeWithLeft(_ left: Bool) -> Void {
        UIView.animate(withDuration: 0.5, animations: { 
            //right
            if !self.isLeft {
                self.center = CGPoint.init(x: self.width + 1000, y: self.centerY + self.currentAngle * self.height + (self.currentAngle == 0 ? 100 : 0))
            } else {
                self.center = CGPoint.init(x: -1000, y: self.centerY - self.currentAngle * self.height + (self.currentAngle == 0 ? 100 : 0))
            }
        }) { (finished) in
            if finished {
                self.removeFromSuperview()
                self.delegate?.cardItemViewDidRemoveFromSuperView(self)
            }
        }
    }
}
