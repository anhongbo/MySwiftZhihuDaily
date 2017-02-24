//
//  UIView+Extension.swift
//  LoveFreshBeen
//
//  Created by 维尼的小熊 on 16/1/12.
//  Copyright © 2016年 tianzhongtao. All rights reserved.
//  GitHub地址:https://github.com/ZhongTaoTian/LoveFreshBeen
//  Blog讲解地址:http://www.jianshu.com/p/879f58fe3542
//  小熊的新浪微博:http://weibo.com/5622363113/profile?topnav=1&wvr=6

import UIKit

/// 对UIView的扩展
extension UIView {
    /// X值
    var x: CGFloat {
        return self.frame.origin.x
    }
    /// Y值
    var y: CGFloat {
        return self.frame.origin.y
    }
    /// 宽度
    var width: CGFloat {
        return self.frame.size.width
    }
    ///高度
    var height: CGFloat {
        return self.frame.size.height
    }
    var size: CGSize {
        return self.frame.size
    }
    var point: CGPoint {
        return self.frame.origin
    }

    //MARK:设置距离父控件的底部 Y值
    func setbottom(bottom:CGFloat){
        var frame = self.frame
        frame.origin.y = bottom - frame.size.height
        self.frame = frame
    }
    
    func setX(x:CGFloat){
        var frame = self.frame
        frame.origin.x = x
        self.frame = frame
    }
    func setY(y:CGFloat){
        var frame = self.frame
        frame.origin.y = y
        self.frame = frame
    }

    func setWidth(width:CGFloat){
        var frame = self.frame
        frame.size.width = width
        self.frame = frame
    }

    func setHight(height:CGFloat){
        var frame = self.frame
        frame.size.height = height
        self.frame = frame
    }

}
