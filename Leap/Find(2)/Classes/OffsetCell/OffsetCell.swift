//
//  OffsetCell.swift
//  Leap
//
//  Created by 梁羽 on 2018/2/8.
//  Copyright © 2018年 梁羽. All rights reserved.
//

import UIKit

class OffsetCell: UITableViewCell {
    
    var photoImg = UIImageView()
    var titleLab = UILabel()
    var descLab = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.clipsToBounds = true
        creatView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatView() {
        photoImg.frame = CGRect.init(x: 18, y: -50, width: Screen_width - 36, height: 300)
        photoImg.contentMode = .scaleAspectFill
        photoImg.backgroundColor = UIColor.cyan
        self.contentView.addSubview(photoImg)
        
        let maskPath = UIBezierPath.init(roundedRect: photoImg.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize.init(width: 5, height: 5))
        
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = photoImg.bounds
        maskLayer.path = maskPath.cgPath
        photoImg.layer.mask = maskLayer
        
        let backView = UIView.init(frame: CGRect.init(x: photoImg.left, y: photoImg.bottom - 50, width: photoImg.width, height: 270))
        backView.backgroundColor = UIColor.white
        self.contentView.addSubview(backView)
        
        titleLab.frame = CGRect.init(x: 0, y: 40, width: 100, height: 30)
        titleLab.font = UIFont.systemFont(ofSize: 30)
        titleLab.textColor = UIColor.colorWithHexString("#333333")
        titleLab.text = "秦生"
        backView.addSubview(titleLab)
        
        descLab.frame = CGRect.init(x: titleLab.left, y: titleLab.bottom + 30, width: backView.width, height: 140)
        descLab.font = UIFont.systemFont(ofSize: 18)
        descLab.textColor = UIColor.colorWithHexString("#999999")
        descLab.numberOfLines = 0
        descLab.text = "我第一次见秦生的时候，她还是一个少女。彼此在十一二月，漫山遍野都是野菊花。秦生蹲在地上，提着竹篮，说是要采野菊花。“秦生，你为什么要采野菊花呢？”我父亲问她。“听村里老大夫说，野菊花可以治疗失眠。阿爹最近......”"
        backView.addSubview(descLab)
    }
    
    public func loadImg(indexPath : IndexPath) {
        photoImg.image = UIImage.init(named: "offset_\(indexPath.row)")
    }
    
    public func cancelAnimation() -> Void {
        photoImg.layer.removeAllAnimations()
    }
    
    public func cellOffset() {
        //获取该视图在window上的rect
        let centerToWindow = self.convert(self.bounds, to: self.window)
        //得到centerToWindow中心点的y坐标 即 window的中心点的y坐标
        let centerY = centerToWindow.midY
        //得到父视图的center
        let windowCenter = self.superview?.center
        //window中心点的y坐标与该视图父视图中心点y坐标的差值
        let cellOffsetY = centerY - (windowCenter?.y)!
        //
        let offsetDig = cellOffsetY / (self.superview?.frame.size.height)! * 2
        let offset = -offsetDig * (-30)
        let transY = CGAffineTransform.init(translationX: 0, y: offset)
        photoImg.transform = transY
    }
}
