//
//  ZHLeftTopView.swift
//  MySwift
//
//  Created by An on 2017/2/16.
//  Copyright © 2017年 an. All rights reserved.
//

import UIKit

class ZHLeftTopView: UIView {

    //头像ImageView
    fileprivate var avatarImageView = UIImageView()
    
    
    override init(frame:CGRect){
        super.init(frame: frame)
//        self.backgroundColor = UIColor.white
        
        self.backgroundColor = UIColor.colorWithCustom(35, g: 42, b: 48)
        self.configUI()
    }
    
    fileprivate func configUI(){

        self.avatarImageView.image = UIImage.init(named: "Resource.bundle/leftAvatar.png")
        self.avatarImageView.frame = CGRect(x: 20, y: 25, width: 35, height: 35)
        self.addSubview(self.avatarImageView)
        
        let loginBtn = UIButton.init(type: .custom)
        loginBtn.frame = CGRect(x: 55, y: 20, width: 60, height: self.height / 2 - 10)
        loginBtn.setTitle("请登录", for: .normal)
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        self.addSubview(loginBtn)
        
        
        let btnWith = (self.width - 60) / 3
        let btnHeight = self.height / 2 - 10
        
        //收藏
        let favourBtn = UIButton.init(type: .custom)
        favourBtn.frame = CGRect(x: 0, y: loginBtn.y + loginBtn.height + 10, width: btnWith, height: btnHeight)
        favourBtn.setImage(UIImage.init(named: "Resource.bundle/leftFavour.png"), for: .normal)
        favourBtn.setTitle("收藏", for: .normal)
        self.dealWith(btn: favourBtn)
        self.addSubview(favourBtn)
        
        //消息
        let messgeBtn = UIButton.init(type: .custom)
        messgeBtn.frame = CGRect(x: favourBtn.x + btnWith, y: favourBtn.y, width:btnWith, height: btnHeight)
        messgeBtn.setImage(UIImage.init(named: "Resource.bundle/leftMessage.png"), for: .normal)
        messgeBtn.setTitle("消息", for: .normal)
        self.addSubview(messgeBtn)
        self.dealWith(btn: messgeBtn)

        
        //设置
        let settingBtn = UIButton.init(type: .custom)
        settingBtn.frame = CGRect(x: messgeBtn.x + btnWith, y: favourBtn.y, width:btnWith, height:btnHeight)
        settingBtn.setImage(UIImage.init(named: "Resource.bundle/leftSetting.png"), for: .normal)
        settingBtn.setTitle("设置", for: .normal)
        self.addSubview(settingBtn)
        self.dealWith(btn: settingBtn)
        
        let bottomLine = UIView(frame: CGRect(x: 0, y: self.height - 0.5, width: self.width, height: 0.5))
        bottomLine.backgroundColor = UIColor.darkGray
        self.addSubview(bottomLine)
    
    }
    
    //让button 图片在上 文字在下
    fileprivate func dealWith(btn:UIButton){
        
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 10.0)
        btn.imageEdgeInsets = UIEdgeInsetsMake(-40, 27.0, 0, 0)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
