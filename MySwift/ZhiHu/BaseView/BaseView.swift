//
//  BaseView.swift
//  MySwift
//
//  Created by An on 2017/2/21.
//  Copyright © 2017年 an. All rights reserved.
//

import UIKit

//view的基类 实现换肤协议
class BaseView: UIView,ZHSkinProtocol {

    override init(frame:CGRect){
        super.init(frame: frame)
        
        NotificationCenter.default.addObserver(self, selector: #selector(applyTheme), name: NSNotification.Name(rawValue: kChangeNightModelNotifacation), object: nil)
    }
    
    func applyTheme(notifaction:NSNotification) {
        
        print("收到通知")
        let dic:NSDictionary = notifaction.object as! NSDictionary
        let mode = dic.value(forKey: "nightMode")! as! Int
        
        UIView.animate(withDuration: 0.5) {
            if mode == 1 {
                self.backgroundColor = UIColor.darkGray
            }else{
                self.backgroundColor = UIColor.white
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
