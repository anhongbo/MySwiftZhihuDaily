//
//  ZHAutoLoopView.swift
//  MySwift
//
//  Created by An on 2017/2/22.
//  Copyright © 2017年 an. All rights reserved.
//  轮播图控件

import UIKit

private let kScreenWidth:CGFloat = UIScreen.main.bounds.size.width


class ZHAutoLoopView: UIView,UIScrollViewDelegate {

    //存储上拉时 scrollView Y的偏移量
    var currentOffsetY:CGFloat = 0
    //存储上拉时 titleLbl 的透明度
    var titleAlpha:CGFloat = 1
    
    //轮播间隔时间 单位 s
    var autoLoopInteral:TimeInterval?
    //是否自动轮播
    var autoLoop:Bool?
    //点击图片事件 闭包
    var clickImageCallBack:(()->Void)?
    
    fileprivate var pageControl:UIPageControl?
    fileprivate var scrollView:UIScrollView?
    fileprivate var currentIndex:Int?
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        self.autoLoopInteral = 5
        self.autoLoop = true
        self.currentIndex = 0
        self.configUI()
    }
    
    private func configUI(){
    
        //轮播图容器
        self.scrollView = UIScrollView()
        self.scrollView?.frame = self.bounds
        self.scrollView?.contentSize = CGSize(width: kScreenWidth * 3, height: 0)
        self.scrollView?.showsVerticalScrollIndicator = false
        self.scrollView?.showsHorizontalScrollIndicator = false
        self.scrollView?.isPagingEnabled = true
        self.addSubview(self.scrollView!)
        self.scrollView?.delegate = self
        
        //分页控件
        self.pageControl = UIPageControl()
        self.pageControl?.numberOfPages = 3
        self.pageControl?.isEnabled = false
        self.pageControl?.autoresizingMask = [.flexibleBottomMargin,.flexibleLeftMargin,.flexibleRightMargin]
        self.pageControl?.frame = CGRect(x: 0, y: self.height - 30, width: ScreenWidth, height: 20)
        self.insertSubview(self.pageControl!, aboveSubview: self.scrollView!)
    }
    
    //顶部轮播模型数组
    var autoLoopArr: [ZHHomeSingleModel]?{
        
        didSet{
            
            //reload scrollView
            self.reloadBanner()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:重新加载
    private func reloadBanner(){
        
        for item in (self.scrollView?.subviews)! {
            item.removeFromSuperview()
        }
        
        let count = autoLoopArr?.count
        self.scrollView?.contentSize = CGSize(width: CGFloat(count!) * ScreenWidth + ScreenWidth, height: 0)
        self.pageControl?.numberOfPages = count!
        var bannerX:CGFloat = 0
        for item:ZHHomeSingleModel in autoLoopArr! {
            
            let rect = CGRect(x: bannerX, y: 0, width: ScreenWidth, height: self.height)
            let bannerV = ZHAutoLoopBannerView(frame: rect)
            bannerX += ScreenWidth
            bannerV.bannerModel = item
            self.scrollView?.addSubview(bannerV)
        }
    }
    
    //MARK:headerView下拉放大 上拉改变标题透明度
    func headerScrollWithOffset(offsetY:CGFloat) {
        
        //上拉
        var frame:CGRect = (self.scrollView?.frame)!
        if (offsetY > 0) {
            
            //frame.origin.y = max(offsetY/2, 0)
            currentOffsetY = max(offsetY/2, 0)
            frame.origin.y = currentOffsetY
            self.scrollView?.frame = frame
            self.clipsToBounds = true
            
            //调整标题透明度  200(轮播图控件高度)
            let alpha:CGFloat =  offsetY / 220
            self.titleAlpha = 1 - (alpha > 1 ? 1 : alpha)
            
            //调整新闻标题lbl的Y 随着scrollView的size调整与banner底部距离
            for view in (self.scrollView?.subviews)!{
                if view is ZHAutoLoopBannerView{
                    let item = view as! ZHAutoLoopBannerView
                    item.titleLbl?.setbottom(bottom: (self.scrollView?.height)! - currentOffsetY - 25)
                    item.titleLbl?.alpha = self.titleAlpha
                }
            }
            
        }else{
        //下拉

            var delta:CGFloat = 0
            var rect = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            
//            delta = CGFloat(fabsf(Float(min(CGFloat(0), offsetY))))
            //下拉时设置scrollView的frame 放大
            delta = -offsetY
            rect.origin.y -= delta
            rect.size.height += delta
            self.scrollView?.frame = rect
            
            //调整新闻标题lbl的Y 随着scrollView的size调整与banner底部距离
            for view in (self.scrollView?.subviews)!  {
                
                    if(view is ZHAutoLoopBannerView){
                        let item:ZHAutoLoopBannerView = view as! ZHAutoLoopBannerView
                        item.titleLbl?.setbottom(bottom: (self.scrollView?.height)! - 25)

                    }
            }
            
            self.currentOffsetY = 0
            self.titleAlpha = 1
            self.clipsToBounds = false
        
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetX = scrollView.contentOffset.x
        var pageIndex = Int(offsetX / ScreenWidth)
        
        if (Int(offsetX) % Int(ScreenWidth)) > Int(ScreenWidth * 0.5) {
            
             pageIndex += 1
            if pageIndex == (self.autoLoopArr?.count)! {
                
                pageIndex = 0
                scrollView.contentOffset = CGPoint(x: 0, y: 0)
            }
           
        }
        
        self.currentIndex = pageIndex
        self.pageControl?.currentPage = pageIndex
    }
    
    
}

