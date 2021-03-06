//
//  OtherCategoryViewController.swift
//  MySwift
//
//  Created by An on 2017/2/20.
//  Copyright © 2017年 an. All rights reserved.
//

import UIKit

class OtherCategoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {
    
    var showFlag = false
    var otherVM = OtherCategoryVM()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //根据按所在界面的status bar，navigationbar，与tabbar的高度，自动调整scrollview的 inset,设置为no，不让viewController调整，自己修改布局
        self.automaticallyAdjustsScrollViewInsets = false
        //延伸视图包含不包含不透明的Bar,是用来指定导航栏是透明的还是不透明，IOS7中默认是YES，当滚动页面的时候我们隐约能在导航栏下面看到我们页面的视图
        self.extendedLayoutIncludesOpaqueBars = true
        
        self.view.addSubview(self.otherTableView)
        self.otherTableView.tableHeaderView = editorsView
        self.view.addSubview(self.naviBar)
        
    }
    
    var commModel:ZHLeftThemesModel?{
    
        didSet{
        
            if(commModel != oldValue || oldValue == nil)
            {
                self.title = commModel?.themeName
                self.getData()
            }
        }
    
    }
    
    lazy var naviBar:OtherCategroyNavitionBar={
    
        let otherNavBar = OtherCategroyNavitionBar(frame: CGRect(x: 0, y: -74, width: ScreenWidth, height: 138))
        return otherNavBar
    
    }()
    
    func getData(){
    
        weak var  weakSelf = self
        self.otherVM.getLastDataWithCate(cateModel: self.commModel!) { 
            weakSelf?.editorsView.editorsArry = weakSelf?.otherVM.editorsArr.copy() as? [ZHEditorsModel]
            //返回顶部
            weakSelf?.otherTableView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: false)
            
            DispatchQueue.main.async {
                //刷新tableView
                weakSelf?.otherTableView.reloadData()
            }
            //获取主题背景图片
            weakSelf?.naviBar.blurImageUrl = weakSelf?.otherVM.commModel?.themeImage
        }
    }
    
    //获取主题背景图片
//    func getNavBarImage(){
//    
//        let urlStr = NSURL(string:(self.otherVM.commModel?.themeImage)!)!
//        let request = NSURLRequest(url: urlStr as URL)
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest) { (data, reponse, error) -> Void in
//            if (error != nil){
//                NSLog("下载顶部图片失败")
//            }
//            else{
//                let img = UIImage.init(data: data!)
//                DispatchQueue.main.async(execute: {
//                    self.naviBar.blurImage = img
//                })
//            }
//        }
//        dataTask.resume()
//    
//    }
//    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        
        if ( -offSetY <= 74 && -offSetY >= 0) {
             self.naviBar.headerScrollWithOffset(offset: offSetY)
        }
        
        if(-offSetY > 74){
            //如果下拉滚动超过 图片高度，不让滚动
            self.otherTableView.contentOffset = CGPoint(x: 0, y: -74)
        }
        print(offSetY)
    }
    
    lazy var otherTableView:UITableView={
    
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRect(x: 0, y: 64, width: ScreenWidth, height: ScreenHeight - 64)
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 15)
        return tableView
    }()
    
    lazy var editorsView:ZHOtherEditorsView={
        let edView = ZHOtherEditorsView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 40))
        return edView
    }()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.otherVM.numOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 90
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = ZHOtherCategoryNewsCell.cellWithTableView(tableView)
        cell.newModel = self.otherVM.cellModelForRowAt(indexPath: indexPath)
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
