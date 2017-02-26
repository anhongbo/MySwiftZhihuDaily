
//
//  ZHAutoLoopBannerView.swift
//  MySwift
//
//  Created by An on 2017/2/23.
//  Copyright © 2017年 an. All rights reserved.
//  轮播图banner

import UIKit

class ZHAutoLoopBannerView: UIImageView {

    //下拉scroll时，调整titleLbl距离底部的距离
    var offsetY:CGFloat = 0
    
    //上下滚动时 透明度指数
    var titleAlpha:CGFloat = 1
    
    //图片点击闭包
    var bannerClick:((_ banerModel:ZHHomeSingleModel) -> Void)?
    
    //轮播图 数据模型
    var bannerModel = ZHHomeSingleModel(){
    
        didSet{
            
            self.sd_setImage(with: URL.init(string: bannerModel.imageUrl!), placeholderImage: nil)
            self.newsTitleConfig()
        }
    }
    
    //标题
    var titleLbl:UILabel?
    
    override init(frame:CGRect){
    
        super.init(frame: frame)

        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.isUserInteractionEnabled = true
        //设置跟随父视图自动调整大小，边距
        self.autoresizingMask = [.flexibleBottomMargin,.flexibleHeight,.flexibleLeftMargin,.flexibleRightMargin,.flexibleTopMargin,.flexibleWidth]
        
        self.titleLbl = UILabel()
        self.titleLbl?.numberOfLines = 0
        
        let gestTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapAction))

        self.addGestureRecognizer(gestTap)
        
        self.addSubview(self.titleLbl!)
    }
    
    
    //设置新闻标题样式等
    private func newsTitleConfig(){
    
        let attr = NSAttributedString.init(string: bannerModel.newsTitle!, attributes: [NSFontAttributeName:UIFont.boldSystemFont(ofSize: 21),NSForegroundColorAttributeName:UIColor.white])
        
        //计算title内容的size
        let titleSize = attr.boundingRect(with: CGSize(width:ScreenWidth - 30 ,height:220), options: [.usesLineFragmentOrigin,.usesFontLeading], context: nil).size
        self.titleLbl?.attributedText = attr
        self.titleLbl?.frame = CGRect(x: 15, y:0, width: ScreenWidth - 30, height: titleSize.height)
        
        //距离底部25
        self.titleLbl?.setbottom(bottom: 220 - 25 - offsetY)
        self.titleLbl?.alpha = self.titleAlpha

    }
    
    
    func tapAction(){
    
        if (bannerClick != nil) {
            bannerClick!(self.bannerModel)
        }
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
