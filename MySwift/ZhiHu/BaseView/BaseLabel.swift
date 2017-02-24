//
//  BaseLabel.swift
//  MySwift
//
//  Created by An on 2017/2/21.
//  Copyright © 2017年 an. All rights reserved.
//

import UIKit

class BaseLabel: UILabel,ZHSkinProtocol {

    override init(frame:CGRect){
        super.init(frame: frame)
    
        NotificationCenter.default.addObserver(self, selector: #selector(applyTheme), name: NSNotification.Name(rawValue: kChangeNightModelNotifacation), object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func applyTheme(notifaction: NSNotification) {
        print("收到通知")
        let dic:NSDictionary = notifaction.object as! NSDictionary
        let mode = dic.value(forKey: "nightMode")! as! Int
        
        UIView.animate(withDuration: 0.5) {
            if mode == 1 {
                self.textColor = UIColor.white
            }else{
                self.textColor = UIColor.black
            }
        }
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    

}
