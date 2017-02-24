//
//  OtherCategroyNavitionBar.swift
//  MySwift
//
//  Created by An on 2017/2/22.
//  Copyright © 2017年 an. All rights reserved.
//  知乎其他主题顶部 假navBar ，毛玻璃效果，下拉显示
//  1.给视图传入Image对象
//  2.将Image对象虚化后 赋值给背景图 blurView
//  3.提供对象方法，接收父容器scrollView的偏移量 ，改变view的高度及模糊率


import UIKit

class OtherCategroyNavitionBar: UIImageView {

    
    lazy var blurView:UIImageView = {
    
        let tmpImageView = UIImageView()
        tmpImageView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 138)
        tmpImageView.backgroundColor = UIColor.clear
        tmpImageView.contentMode = .scaleAspectFill
        tmpImageView.clipsToBounds = true
    
        return tmpImageView
    }()
    
    //背景图
    var blurImage:UIImage? {
    
        didSet{
            self.image = blurImage
            self.configBlurImage()
        }
    }
    
    
    var blurImageUrl:String?{
    
        didSet{
                    
            self.sd_setImage(with: URL.init(string: blurImageUrl!)) { (image, error, type, url) in
                self.blurImage = image
            }
        }
    }
    override init(frame:CGRect){
        super.init(frame: frame)
        self.backgroundColor = UIColor.colorWithCustom(35, g: 42, b: 48)
        self.addSubview(self.blurView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //设置玻璃模糊效果
    fileprivate func configBlurImage(){

        let blurImage:UIImage = (self.blurImage?.applyBlur(withRadius: 12, tintColor: nil, saturationDeltaFactor: 1.0, maskImage: nil))!
        self.blurView.image = blurImage
        
    }
    //滚动时 调整假导航栏的frame及玻璃效果蒙版的透明度
   open func headerScrollWithOffset(offset:CGFloat){
    
        self.frame = CGRect(x: 0, y: -74 - offset/2, width: ScreenWidth, height: 138 - offset/2)
        self.blurView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 138 - offset/2)
        self.blurView.alpha = (74 + offset) / 74
    
    }

}
