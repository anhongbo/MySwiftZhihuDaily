//
//  ZHDetailBottomView.swift
//  MySwiftZhihu
//
//  Created by An on 2017/2/26.
//  Copyright © 2017年 an. All rights reserved.
//

import UIKit


@objc protocol ZHDetailBottomBtnDelegate:NSObjectProtocol {
    
    func detailBottomBtnClick(btn:UIButton)
}

class ZHDetailBottomView: UIView {
    
    let kDetailNewBtnTag:Int = 10000
    weak var delegate:ZHDetailBottomBtnDelegate?

    override init(frame:CGRect){
        super.init(frame: frame)
        configUI()
    }
    
    private func configUI(){
        
        self.backgroundColor = UIColor.white
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: -4.0)
        self.layer.shadowOpacity = 0.4

        let btnW:CGFloat = 50
        let btnH:CGFloat = 50
        let btnX:CGFloat = (ScreenWidth - btnW*5) / 6
        let imageArr = ["detail_Back","detail_Next","detail_Voted","detail_Share","detail_Comment"]
        for i:Int in 0 ..< 5 {
            
            let btn = UIButton.init(type: .custom)
            btn.tag = kDetailNewBtnTag + i
            btn.setImage(UIImage.init(named:ImageSourcePath + imageArr[i]), for: .normal)
            btn.imageView?.contentMode = .scaleAspectFill
            btn.frame = CGRect(x: btnX + (btnW + btnX) * CGFloat(i), y: 0, width: btnW, height: btnH)
            btn.addTarget(self, action: #selector(bottomBtnClick), for: .touchUpInside)
            addSubview(btn)
        }
    }
    
    
    func bottomBtnClick(btn:UIButton){
        
        delegate?.detailBottomBtnClick(btn: btn)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
