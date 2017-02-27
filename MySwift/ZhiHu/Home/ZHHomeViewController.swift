//
//  ZHHomeViewController.swift
//  MySwift
//
//  Created by An on 2017/2/17.
//  Copyright © 2017年 an. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MJExtension
import MJRefresh

class ZHHomeViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate{
    
    
    var isLoading:Bool = false
    var showFlag = false
    
    var arr:NSArray = NSArray()
    var lastNewsModel : ZHLastNewsModel?
    var homeNewsVM : ZHHomeNewsVM = ZHHomeNewsVM()
    
//    var header = MJRefreshNormalHeader()
    var footer = MJRefreshFooter()
    
    var navBarView:UIView?
    var navBarTitleLbl:UILabel?
    var navStatusBar:UIView?
    
    var autoLoopHeaderView:ZHAutoLoopView?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "最新热点"
        self.configUI()
        self.configNavBar()

        weak var weakSelf = self
        self.homeNewsVM.getLastNewsData {
            //获取最新数据、添加轮播
            weakSelf?.addAotuView()
            weakSelf?.tableView.reloadData()
        }
    }
    

    private func configUI(){
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.extendedLayoutIncludesOpaqueBars = true

        self.view.addSubview(tableView)
//        self.header.setRefreshingTarget(self, refreshingAction: #selector(headerFresh))
//        self.tableView.mj_header = self.header
        self.footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(footerFresh))
        self.tableView.mj_footer = self.footer
    }
    
    //假的导航栏
    private func configNavBar(){
    
        
        let statusBar = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 20))
        statusBar.backgroundColor = UIColor.colorWithCustom(5, g: 143, b: 214)
        self.navStatusBar = statusBar
        self.navStatusBar?.alpha = 0
        self.view.addSubview(statusBar)
        
        let navBarView = UIView(frame: CGRect(x: 0, y: 20, width: ScreenWidth, height: 44))
        navBarView.backgroundColor = UIColor.colorWithCustom(5, g: 143, b: 214)
        self.view.addSubview(navBarView)
        self.navBarView = navBarView
        self.navBarView?.alpha = 0
        
        let naviBarTitle = UILabel()
        naviBarTitle.frame = CGRect(x: 50, y: 20, width: ScreenWidth - 100, height: 44)
        naviBarTitle.text = "今日热闻"
        naviBarTitle.textAlignment = .center
        naviBarTitle.font = UIFont.boldSystemFont(ofSize: 18)
        naviBarTitle.textColor = UIColor.white
        naviBarTitle.backgroundColor = UIColor.clear
        self.navBarTitleLbl = naviBarTitle
        self.view.addSubview(naviBarTitle)
        
        //展开、关闭抽屉按钮    最后添加，会显示在最上面
        let leftBarItemButton = UIButton(type: .custom)
        leftBarItemButton.setImage(UIImage.init(named: ImageSourcePath+"leftIcon"), for: .normal)
        leftBarItemButton.frame = CGRect(x: 0, y: 20, width: 44, height: 44)
        leftBarItemButton.addTarget(self, action: #selector(openLeftDrawer), for: .touchUpInside)
        self.view.addSubview(leftBarItemButton)
    
    }
    
    func openLeftDrawer(){
    
        //获取父视图调用其方法
        let window:UIWindow = ((UIApplication.shared.delegate?.window)!)!
        if (window.rootViewController is ZHMainViewController){
            let mainVC:ZHMainViewController = window.rootViewController as! ZHMainViewController
            if (mainVC.isFold) {
                mainVC.hideDrawerList()
            }else{
                mainVC.showDrawerList()
            }
        
        }
    }
    //添加轮播图 -- 获取数据之后添加
    private func addAotuView(){
    
        //如果不为空重新设置轮播
        if ((self.autoLoopHeaderView) != nil){
            self.autoLoopHeaderView?.removeFromSuperview()
            self.tableView.tableHeaderView = nil
        }
        
        //初始化时指定frame 里面的子控件才能使用父控件的frame设定子frame
        self.autoLoopHeaderView = ZHAutoLoopView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 220))
        self.autoLoopHeaderView?.autoLoopArr = homeNewsVM.dataOfBanners()
        self.autoLoopHeaderView?.autoLoopBannerClick = {(newModel) -> Void in
            let detailVC:ZHNewDetailController = ZHNewDetailController()
            detailVC.detailModel = newModel
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        self.tableView.tableHeaderView = self.autoLoopHeaderView
    }
    
    func headerFresh(){
        print("下拉刷新")
        self.isLoading = true
        //获取热门新闻
        weak var weakSelf = self
        self.homeNewsVM.getLastNewsData {
            self.isLoading = false
//            weakSelf?.tableView.mj_header.endRefreshing()
            //获取最新数据 、重新添加轮播
            weakSelf?.addAotuView()
            weakSelf?.tableView.reloadData()

        }
    }
    
    func footerFresh(){
        print("上拉刷新")
        //获取热门新闻
        weak var weakSelf = self
        self.homeNewsVM.getPreviousNewsData {
            weakSelf?.tableView.mj_footer.endRefreshing()
            weakSelf?.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.homeNewsVM.numberOfSection())
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0){
            return 0
        }
        return 40
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if (section == 0) {return nil} //第一个headerView是今天，不显示
        let headerView = ZHHomeNewsHeaderView(reuseIdentifier: "headerReuseId")
        headerView.textLabel?.attributedText = self.homeNewsVM.headerTitleForSection(section: section)
        headerView.contentView.backgroundColor = UIColor.colorWithCustom(5, g: 143, b: 214)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (self.homeNewsVM.numberOfRowsInSection(section: section))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = ZHHomeNewsCell.cellWithTableView(tableView)
        let model:ZHHomeSingleModel = self.homeNewsVM.singleNewModelAtIndexPath(indexPath: indexPath as NSIndexPath)
        cell.newModel = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//        homeNewsVM.didSelectPush(fromVC: self, indexPath: indexPath)
    }
    
    //MARK:lazy tableView
    lazy var tableView:UITableView = {
    
        let mainTableView = UITableView()
        mainTableView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.tableFooterView = UIView()
        mainTableView.separatorStyle = .none
        return mainTableView

    }()
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if(scrollView == self.tableView){
            
            let offsetY = scrollView.contentOffset.y
            
            //控制上拉假的navBar等透明度
            let alphaDelta:CGFloat = (offsetY / 220) > 1 ? 1 : (offsetY / 220)
            self.navBarView?.alpha  = alphaDelta
            self.navStatusBar?.alpha = alphaDelta
            
            //控制上拉轮播图 title的透明度，下拉轮播图放大
            if (self.tableView.tableHeaderView is ZHAutoLoopView) {
                self.autoLoopHeaderView!.headerScrollWithOffset(offsetY: offsetY)
            }
            
            
            let dateHeaderHeight:CGFloat = 44;
            if (offsetY <= dateHeaderHeight && offsetY >= 0) {
                
                scrollView.contentInset = UIEdgeInsetsMake(-offsetY, 0, 0, 0);
            }
            else if (offsetY >= dateHeaderHeight) {//偏移20
                
                scrollView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
            }
            
            
            //行高 * 行数 + 220(headerView的高度)
            if (offsetY >= CGFloat( 92 * (self.homeNewsVM.numberOfRowsInSection(section: 0)) + 220)) {//第一个section到达后 隐藏navbar 和 标题
                self.navBarView?.alpha = 0
                self.navBarTitleLbl?.text = ""
            }else{//透明度变化上面已经设置完成
                self.navBarTitleLbl?.text = "今日热闻"
            }

            //下拉刷新
            if (offsetY <= -40 && offsetY >= -80 && !scrollView.isDragging && !isLoading) {
                self.headerFresh()
            }
        }
    }
    
}
    
    

