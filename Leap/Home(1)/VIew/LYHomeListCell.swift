//
//  LYHomeListCell.swift
//  Leap
//
//  Created by 梁羽 on 2017/9/7.
//  Copyright © 2017年 梁羽. All rights reserved.
//

import UIKit

class LYHomeListCell: UITableViewCell {
    
    var frameModel : ListFrameModel?
    
    lazy var headerView : HeaderView = {
        let view = HeaderView.init(frame: CGRect.zero)
        self.contentView.addSubview(view)
        return view
    }()
    
    lazy var textView : ContentView = {
        let view = ContentView.init(frame: CGRect.zero)
        self.contentView.addSubview(view)
        return view
    }()
    
    lazy var imgView : ImgView = {
        let view = ImgView.init(frame: CGRect.zero)
        self.contentView.addSubview(view)
        return view
    }()
    
    lazy var toolBarView : ToolBarView = {
        let view = ToolBarView.init(frame: CGRect.zero)
        self.contentView.addSubview(view)
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func updataModel(frameModel : ListFrameModel?) {
        guard let model = frameModel else {
            return
        }
        self.frameModel = model
        
        self.headerView.frame = model.headerViewF
        self.headerView.setModel(frameModel: model)
        
        self.textView.frame = model.contentViewF
        self.textView.setModel(frameModel: model)
        
        self.imgView.frame = model.imgViewF
        self.imgView.setModel(frameModel: model)
        
        self.toolBarView.frame = model.toolBarF
        self.toolBarView.setModel(frameModel: model)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HeaderView: UIView {
    
    lazy var avatar : UIImageView = {
        let imgView = UIImageView.init(frame: CGRect.zero)
        self.addSubview(imgView)
        return imgView
    }()
    
    lazy var uname : UILabel = {
        let name = UILabel.init(frame: CGRect.zero)
        name.font = UIFont.systemFont(ofSize: 16)
        name.textColor = UIColor.colorWithHexString("#0073B1")
        self.addSubview(name)
        return name
    }()
    
    lazy var fromLab : UILabel = {
        let lab = UILabel.init(frame: CGRect.zero)
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.textColor = UIColor.colorWithHexString("#BBBBBB")
        self.addSubview(lab)
        return lab
    }()
    
    lazy var careBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitleColor(UIColor.colorWithHexString("#0196E6"), for: .normal)
        btn.setTitle("关注", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(btn)
        return btn
    }()
    
    func setModel(frameModel : ListFrameModel) {
        self.avatar.frame = frameModel.avatarF
        self.avatar.sd_setImage(with: URL.init(string: (frameModel.model?.user_info.avatar_middle)!), placeholderImage: avatarHolder)
        
        self.uname.frame = frameModel.unameF
        self.uname.text = frameModel.model?.user_info.uname
        
        self.fromLab.frame = frameModel.fromF
        self.fromLab.text = frameModel.model?.from
        
        self.careBtn.frame = frameModel.careBtnF
    }
}

class ContentView: UIView {
    
    lazy var titleLab : UILabel = {
        let lab = UILabel.init(frame: CGRect.zero)
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.textColor = UIColor.black
        self.addSubview(lab)
        return lab
    }()
    
    lazy var contentLab : UILabel = {
        let lab = UILabel.init(frame: CGRect.zero)
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.numberOfLines = 0
        lab.textColor = UIColor.colorWithHexString("#666666")
        self.addSubview(lab)
        return lab
    }()
    
    func setModel(frameModel : ListFrameModel) {
        self.titleLab.frame = frameModel.contentTitleF
        self.titleLab.text = frameModel.model?.title
        
        self.contentLab.frame = frameModel.contentTextF
        self.contentLab.text = frameModel.model?.content
    }
}

class ImgView: UIView {
    
    lazy var imgArr : [UIImageView] = {
        var arr = [UIImageView]()
        for _ in 0...8 {
            let imageV = UIImageView.init(frame: CGRect.zero)
            imageV.backgroundColor = UIColor.white
            imageV.isHidden = true
            self.addSubview(imageV)
            arr.append(imageV)
        }
        return arr
    }()
    
    lazy var videoImg : UIImageView = {
        let img = UIImageView.init(frame: CGRect.zero)
        img.backgroundColor = UIColor.white
        img.isHidden = true
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        self.addSubview(img)
        return img
    }()
    
    lazy var holderPause : UIImageView = {
        let pauseImg = UIImageView.init(frame: CGRect.zero)
        pauseImg.size = CGSize.init(width: 38, height: 38)
        pauseImg.image = UIImage.init(named: "pauseIcon")
        self.videoImg.addSubview(pauseImg)
        return pauseImg
    }()
    
    func setModel(frameModel : ListFrameModel) {
        if let type = frameModel.model?.type {
            self.noneImageView()
            switch type {
            case "postimage":
                self.videoImg.isHidden = true
                guard frameModel.model?.attach_info_img.count != 0 else {
                    return
                }
                setImage(frameModel: frameModel, postType: "postimage")
            case "postvideo":
                self.videoImg.frame = CGRect.init(x: 0, y: 0, width: homeVideoInfoWidth, height: homeVideoInfoHeight)
                self.videoImg.sd_setImage(with: URL.init(string: (frameModel.model?.video_info?.flashimg)!))
                self.videoImg.isHidden = false
                self.holderPause.center = self.videoImg.center
            case "weiba_post":
                self.videoImg.isHidden = true
                guard frameModel.model?.img.count != 0 else {
                    return
                }
                setImage(frameModel: frameModel, postType: "weiba_post")
            default:
                self.videoImg.isHidden = true
            }
        }
    }
    
    func setImage(frameModel : ListFrameModel, postType type : String) {
        if type == "postimage" {
            let imageArr = frameModel.model?.attach_info_img
            let imgNum = imageArr?.count
            for index in 0...8 {
                let imageV = self.imgArr[index]
                if index < imgNum! {
                    let imgModel = imageArr?[index]
                    imageV.isHidden = false
                    imageV.frame = frameModel.imgFrameArr[index]
                    imageV.sd_setImage(with: URL.init(string: (imgModel?.attach_small)!))
                }else {
                    imageV.isHidden = true
                }
            }
        }else {
            let imageArr = frameModel.model?.img
            let imgNum = imageArr?.count
            for index in 0...8 {
                let imageV = self.imgArr[index]
                if index < imgNum! {
                    let imgModel = imageArr?[index]
                    imageV.isHidden = false
                    imageV.frame = frameModel.imgFrameArr[index]
                    imageV.sd_setImage(with: URL.init(string: (imgModel?.small)!))
                }else {
                    imageV.isHidden = true
                }
            }
        }
    }
    
    func noneImageView() {
        for index in 0...8 {
            let imageV = self.imgArr[index]
            imageV.isHidden = true
        }
    }
}

class ToolBarView: UIView {
    
    lazy var addressBtn : UIButton = {
        let adresBtn = UIButton.init(type: .custom)
        adresBtn.frame = CGRect.zero
        adresBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        adresBtn.titleLabel?.textAlignment = .left
        adresBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        adresBtn.setTitleColor(UIColor.black, for: .normal)
        self.addSubview(adresBtn)
        return adresBtn
    }()
    
    lazy var commentBtn : UIButton = {
        let comBtn = UIButton.init(type: .custom)
        comBtn.frame = CGRect.zero
        comBtn.setTitleColor(UIColor.black, for: .normal)
        comBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(comBtn)
        return comBtn
    }()
    
    lazy var diggBtn : UIButton = {
        let digBtn = UIButton.init(type: .custom)
        digBtn.frame = CGRect.zero
        digBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        digBtn.setTitleColor(UIColor.black, for: .normal)
        self.addSubview(digBtn)
        return digBtn
    }()
    
    func setModel(frameModel : ListFrameModel) {
        self.addressBtn.frame = frameModel.addressTBF
        self.addressBtn.setTitle(frameModel.model?.address, for: .normal)
        
        self.commentBtn.frame = frameModel.commentTBF
        self.commentBtn.setTitle("评论"+String(0), for: .normal)
        if let commCount = frameModel.model?.comment_count {
            self.commentBtn.setTitle("评论 "+String(commCount), for: .normal)
        }
        
        self.diggBtn.frame = frameModel.diggTBF
        self.diggBtn.setTitle("点赞"+String(0), for: .normal)
        if let diggCount = frameModel.model?.digg_count {
            self.diggBtn.setTitle("点赞 "+String(diggCount), for: .normal)
        }
    }
}


