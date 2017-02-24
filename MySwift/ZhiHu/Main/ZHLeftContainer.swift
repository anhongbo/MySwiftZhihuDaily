//
//  ZHLeftContainer.swift
//  MySwift
//
//  Created by An on 2017/2/16.
//  Copyright © 2017年 an. All rights reserved.
//  左侧容器视图

import UIKit

class ZHLeftContainer: UIView {

    //手指按下的地方 创建新的layer显示图片动画， 0.25秒后消失
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        let clickLayer = CALayer()
        clickLayer.frame  = CGRect(x: 0, y: 0, width: 30, height: 30)
        clickLayer.cornerRadius = 15
        clickLayer.position = point
        clickLayer.opacity = 0.4
        self.layer.addSublayer(clickLayer)
        clickLayer.contents = UIImage.init(named: "Resource.bundle/leftClick.png")?.cgImage
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { 
            clickLayer.removeFromSuperlayer()
        }

        return true
    }

}
