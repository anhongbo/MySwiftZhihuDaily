//
//  ZHOtherEditorsView.swift
//  MySwift
//
//  Created by An on 2017/2/21.
//  Copyright © 2017年 an. All rights reserved.
//

import UIKit
import SnapKit

class ZHOtherEditorsView: BaseView {

//    var editorsModel:ZHEditorsModel?
    var avatarScrollView:UIScrollView?
    override init(frame:CGRect){
        super.init(frame: frame)
        self.configUI()
    }
    
    
   private func configUI(){
        
        let editorLbl = BaseLabel()
        editorLbl.textAlignment = .left
        editorLbl.text = "主编"
        editorLbl.font = UIFont.systemFont(ofSize: 14)
        editorLbl.textColor = UIColor.lightGray
        self.addSubview(editorLbl)

        let arrowImageView = UIImageView()
        arrowImageView.image = UIImage.init(named: ImageSourcePath+"leftEnter.png")
        self.addSubview(arrowImageView)
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        self.addSubview(bottomLine)
        
        let avatarScrollV = UIScrollView()
        avatarScrollView?.showsVerticalScrollIndicator = false
        self.avatarScrollView = avatarScrollV
        self.addSubview(avatarScrollV)
        
        editorLbl.snp.makeConstraints { (make) in
            make.width.equalTo(30)
            make.height.equalTo(40)
            make.left.equalTo(10)
            make.centerY.equalToSuperview()
        }
        
        arrowImageView.snp.makeConstraints { (make) in
            make.size.equalTo(15)
            make.centerY.equalTo(editorLbl)
            make.right.equalToSuperview().offset(-10)
        }
        
        bottomLine.snp.makeConstraints { (make) in
            make.width.equalTo(self.snp.width)
            make.height.equalTo(0.5)
            make.bottom.equalToSuperview().offset(1)
        }
        
        avatarScrollV.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            make.centerY.equalToSuperview()
            make.left.equalTo(editorLbl.snp.right).offset(5)
            make.right.equalTo(arrowImageView.snp.left).offset(-5)
        }
        
//        avatarScrollView?.backgroundColor = UIColor.red
    }
    
    var editorsArry:[ZHEditorsModel]?{
    
        didSet{
         //布局主编头像
            self.setUpEditorsIcon()
        
        }
    
    }

    private func setUpEditorsIcon(){
        
        if(self.editorsArry?.count == 0) {return};
        //刷新、重新布局
        for subView:UIView in (self.avatarScrollView?.subviews)!{
            subView.removeFromSuperview()
        }
        self.configUI()
        
        let avatarWidth:CGFloat = 26
        var avatarX:CGFloat = 10

        for item:ZHEditorsModel in editorsArry!{
            let imageV = UIImageView()
            imageV.tag = 100
            imageV.sd_setImage(with:URL.init(string: item.avatar!), placeholderImage: UIImage.init(named: ImageSourcePath+"leftAvatar"))
            imageV.contentMode = .scaleAspectFill
            imageV.layer.cornerRadius = 13
            imageV.clipsToBounds = true
            imageV.frame = CGRect(x: avatarX, y: 7, width: avatarWidth, height: avatarWidth)
            imageV.backgroundColor = UIColor.clear
            self.avatarScrollView?.addSubview(imageV)
            avatarX += avatarWidth + 5
            
            self.avatarScrollView?.contentSize = CGSize(width: avatarX , height: 0)
        }
        
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
