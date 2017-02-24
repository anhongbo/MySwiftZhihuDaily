//
//  ZHLeftBottomView.swift
//  MySwift
//
//  Created by An on 2017/2/16.
//  Copyright © 2017年 an. All rights reserved.
//

import UIKit

class ZHLeftBottomView: UIView {

    var nigthBtn:UIButton?
    override init(frame:CGRect){
    
        super.init(frame: frame)
        self.backgroundColor = UIColor.colorWithCustom(35, g: 42, b: 48)
        self.configUI()
    
    }
    
    
    fileprivate func configUI(){
    
        let offLineBtn = UIButton.init(type: .custom)
        offLineBtn.frame = CGRect(x: 0, y: 0, width: ScreenWidth * kDrawerRatio / 2, height: 50)
        offLineBtn.setImage(UIImage.init(named: "Resource.bundle/leftDownload.png"), for: .normal)
        offLineBtn.setTitle("离线", for: .normal)
        self.dealWithBtn(btn: offLineBtn)
        self.addSubview(offLineBtn)
        
        
        let nightModeBtn = UIButton.init(type: .custom)
        nightModeBtn.frame = CGRect(x: offLineBtn.width, y: offLineBtn.y, width: offLineBtn.width, height: offLineBtn.height)
        nightModeBtn.setImage(UIImage.init(named: "Resource.bundle/leftNight.png"), for: .normal)
        nightModeBtn.setTitle("夜间", for: .normal)
        nightModeBtn.addTarget(self, action: #selector(nigthModeClick), for: .touchUpInside)
        self.dealWithBtn(btn: nightModeBtn)
        self.addSubview(nightModeBtn)
        self.nigthBtn = nightModeBtn
        self.nigthBtn?.tag = 0
    
    }
    
    fileprivate func dealWithBtn(btn : UIButton){
    
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0)
    
    }
    
    func nigthModeClick(){
    
        print("夜间模式 发送通知")
        if (self.nigthBtn?.tag == 0){
            self.nigthBtn?.tag = 1
            self.nigthBtn?.setTitle("白天", for: .normal)
            self.nigthBtn?.setImage(UIImage.init(named: ImageSourcePath+"leftDay"), for: .normal)
        }else{
            self.nigthBtn?.tag = 0
            self.nigthBtn?.setImage(UIImage.init(named: ImageSourcePath+"leftNight"), for: .normal)
            self.nigthBtn?.setTitle("夜间", for: .normal)
        }
        let dic = ["nightMode":self.nigthBtn?.tag]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kChangeNightModelNotifacation), object: dic)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
