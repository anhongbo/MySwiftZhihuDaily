//
//  ZHLeftViewController.swift
//  MySwift
//
//  Created by An on 2017/2/15.
//  Copyright © 2017年 an. All rights reserved.
//

import UIKit

class ZHLeftViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var leftThemeVM = ZHLeftThemeVM()
    var leftContainer :UIView!
    var clickNewsCell:((_ type:Int,_ cateCellType:ZHLeftThemesModel) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configUI()
        self.leftThemeVM.getLeftThemesList {
            self.menuTableView.reloadData()
        }
    }
    
//    fileprivate func getCategoryData(){
//        
//        self.categoryArr = ZHLeftCellCategroyModel.mj_objectArray(withFilename: "CategoryList.plist")
//        self.menuTableView.reloadData()
//    
//    }
    
    fileprivate func configUI(){
    
        //相对于自己的坐标系 所以用bounds， x,y = 0
        self.leftContainer = ZHLeftContainer(frame: self.view.bounds)
        self.view.addSubview(self.leftContainer)
        
        //添加左侧 顶部视图
        let leftTopView = ZHLeftTopView(frame: CGRect(x: 0, y: 0, width: self.leftContainer.width * kDrawerRatio, height: 120))
        self.leftContainer.addSubview(leftTopView)
        
//        添加左侧tableview
        let tableFrame:CGRect = CGRect(x:0, y: 120, width: ScreenWidth * 0.6, height: self.leftContainer.height - leftTopView.height - 50)
//        self.menuTableView = UITableView(frame: tableFrame, style: .plain)
        self.menuTableView.frame = tableFrame
        self.leftContainer.addSubview(self.menuTableView)
        
        //添加底部view
        let bottomView = ZHLeftBottomView(frame: CGRect(x: 0, y: leftContainer.height - 50, width: leftContainer.width, height: 50))
        self.leftContainer.addSubview(bottomView)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.leftThemeVM.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell = ZHDrawerCell.cellWithTableView(tableView)
        let themeModel:ZHLeftThemesModel = self.leftThemeVM.cellModelAtIndexPath(indexPath: indexPath)
        cell.leftCellModel = themeModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! ZHDrawerCell
        cell.setSelected(true, animated: true)
        
        //0:首页
        let type = indexPath.row
        //切换页面
        if (self.clickNewsCell != nil){
            self.clickNewsCell!(type,cell.leftCellModel!)
        }
    }
    
    
    lazy var menuTableView:UITableView={
    
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.colorWithCustom(35, g: 42, b: 48)
        return tableView
    }()
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
