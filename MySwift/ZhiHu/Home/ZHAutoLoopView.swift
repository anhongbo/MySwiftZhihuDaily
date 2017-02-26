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
    
    //点击Banner事件 闭包
    var autoLoopBannerClick:((_ model:ZHHomeSingleModel)->Void)?
    
    fileprivate var pageControl:UIPageControl?
    fileprivate var bannerScrollView:UIScrollView?
    fileprivate var currentIndex:Int?
    fileprivate var timer:Timer?
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        self.autoLoopInteral = 3.0
        self.autoLoop = true
        self.currentIndex = 0
        self.configUI()
    }
    
    private func configUI(){
    
        //轮播图容器
        self.bannerScrollView = UIScrollView()
        self.bannerScrollView?.frame = self.bounds
        self.bannerScrollView?.contentSize = CGSize(width: kScreenWidth * 3, height: 0)
        self.bannerScrollView?.showsVerticalScrollIndicator = false
        self.bannerScrollView?.showsHorizontalScrollIndicator = false
        self.bannerScrollView?.isPagingEnabled = true
        self.addSubview(self.bannerScrollView!)
        self.bannerScrollView?.delegate = self

        //首先构建三张轮播图，用于无限滚动重用
        for i:Int in 0..<3{
            
            let bannerView = ZHAutoLoopBannerView(frame:CGRect.zero)
            self.bannerScrollView?.addSubview(bannerView)
            bannerView.bannerClick = {(model) -> Void in
                if (self.autoLoopBannerClick != nil) {
                    self.autoLoopBannerClick!(model)
                }
            }
             bannerView.frame = CGRect(x: CGFloat(i) * (bannerScrollView?.width)!, y: 0, width: (bannerScrollView?.width)!, height: (bannerScrollView?.height)!)
        }
        
        //分页控件
        self.pageControl = UIPageControl()
        self.pageControl?.numberOfPages = 3
        self.pageControl?.isEnabled = false
        self.pageControl?.autoresizingMask = [.flexibleBottomMargin,.flexibleLeftMargin,.flexibleRightMargin]
        self.pageControl?.frame = CGRect(x: 0, y: self.height - 30, width: ScreenWidth, height: 20)
        self.insertSubview(self.pageControl!, aboveSubview: self.bannerScrollView!)
    }
    
    //顶部轮播模型数组
    var autoLoopArr: [ZHHomeSingleModel]?{
        
        didSet{
            
            if self.timer != nil {
                self.timer?.invalidate()
                self.timer = nil
            }
            //scrollView
            if autoLoopArr?.count == 0  { return }
            self.configPageControl()
            self.configBanners()
            self.startTimer()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configPageControl(){
        let count = autoLoopArr?.count
        //            self.bannerScrollView?.contentSize = CGSize(width:CGFloat(count!) * ScreenWidth , height: 0)
        self.pageControl?.numberOfPages = count!
        let pageControlSize = self.pageControl?.size(forNumberOfPages: count!)
        self.pageControl?.frame = CGRect(x: (self.width - (pageControlSize?.width)!) * 0.5, y: self.height - (pageControlSize?.height)!, width: (pageControlSize?.width)!, height: (pageControlSize?.height)!)
        self.pageControl?.currentPage = 0

    }
    //MARK:计算循环轮播图index
    private func configBanners(){
        
        for i in 0 ..< (bannerScrollView?.subviews.count)! {
            
            let bannerV = bannerScrollView?.subviews[i] as! ZHAutoLoopBannerView
            var index:Int = (pageControl?.currentPage)!
            
            if i == 0 {
                index -= 1
            } else if i == 2 {
                index += 1
            }
            
            if index < 0 {
                index = (self.pageControl?.numberOfPages)! - 1
            } else if index >= (pageControl?.numberOfPages)! {
                index = 0
            }
            
            bannerV.tag = index
            let dataModel:ZHHomeSingleModel = self.autoLoopArr![index]
            bannerV.offsetY = currentOffsetY
            bannerV.bannerModel = dataModel
        }
        
        bannerScrollView?.contentOffset = CGPoint(x: (bannerScrollView?.width)!, y: 0)
    }
    
 
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for i:Int in 0 ..< (bannerScrollView?.subviews.count)! {
            
            let bannerV = bannerScrollView?.subviews[i] as! ZHAutoLoopBannerView
            bannerV.bannerClick = {(model) -> () in
                if (self.autoLoopBannerClick != nil) {
                    self.autoLoopBannerClick!(model)
                }
            }
        }
        self.configBanners()
    }
    
    func startTimer(){
        timer = Timer(timeInterval: autoLoopInteral!, target: self, selector: #selector(nextBanner), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .commonModes)
    }
    
    func stopTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    func nextBanner(){
        bannerScrollView?.setContentOffset(CGPoint(x: 2.0 * (bannerScrollView?.width)!, y: 0), animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopTimer()
    }
    // 触摸屏幕并拖拽画面，再松开，最后停止时，触发该函数
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
    // 滚动停止时，触发该函数
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        configBanners()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        configBanners()
    }

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //计算pageControl的当前页
        var page: Int = 0
        var minDistance: CGFloat = CGFloat(MAXFLOAT)
        for i:Int in 0 ..< (bannerScrollView?.subviews.count)! {
            let bannerV = bannerScrollView?.subviews[i] as! ZHAutoLoopBannerView
            let distance:CGFloat = abs(bannerV.x - bannerScrollView!.contentOffset.x)
            
            if distance < minDistance {
                minDistance = distance
                page = bannerV.tag
            }
        }
        pageControl?.currentPage = page
    }


    //MARK:headerView下拉放大 上拉改变标题透明度
    func headerScrollWithOffset(offsetY:CGFloat) {
        
        //上拉
        var frame:CGRect = (self.bannerScrollView?.frame)!
        if (offsetY > 0) {
            
            //frame.origin.y = max(offsetY/2, 0)
            currentOffsetY = max(offsetY/2, 0)
            frame.origin.y = currentOffsetY
            self.bannerScrollView?.frame = frame
            self.clipsToBounds = true
            
            //调整标题透明度  200(轮播图控件高度)
            let alpha:CGFloat =  offsetY / 220
            self.titleAlpha = 1 - (alpha > 1 ? 1 : alpha)
            
            //调整新闻标题lbl的Y 随着scrollView的size调整与banner底部距离
            for view in (self.bannerScrollView?.subviews)!{
                if view is ZHAutoLoopBannerView{
                    let item = view as! ZHAutoLoopBannerView
                    item.titleLbl?.setbottom(bottom: (self.bannerScrollView?.height)! - currentOffsetY - 25)
                    item.titleLbl?.alpha = self.titleAlpha
                }
            }
            
        }else{
            //下拉
            
            var delta:CGFloat = 0
            var rect = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            
            delta = CGFloat(fabsf(Float(min(CGFloat(0), offsetY))))
            //下拉时设置scrollView的frame 放大
//            delta = -offsetY
            rect.origin.y -= delta
            rect.size.height += delta
            var newPoint = bannerScrollView?.center;
            newPoint?.y += delta;
            self.bannerScrollView?.frame = rect
            
            //调整新闻标题lbl的Y 随着scrollView的size调整与banner底部距离
            for view in (self.bannerScrollView!.subviews)  {
                if(view is ZHAutoLoopBannerView){
                    let item:ZHAutoLoopBannerView = view as! ZHAutoLoopBannerView
                    item.titleLbl?.setbottom(bottom: (self.bannerScrollView!.height) - 25)
                }
            }
            
            self.currentOffsetY = offsetY
            self.titleAlpha = 1
            self.clipsToBounds = false
            
        }
    }
    
        
}

