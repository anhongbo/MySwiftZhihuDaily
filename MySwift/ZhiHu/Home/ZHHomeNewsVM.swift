//
//  ZHHomeNewsVM.swift
//  MySwift
//
//  Created by An on 2017/2/18.
//  Copyright © 2017年 an. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import MJExtension



class ZHHomeNewsVM: NSObject {
    
    var currentDate:String?     //当前日期
    var newIdArr:[String]?      //存放新闻Id数组  用于翻页
    var newsLayoutArr:NSMutableArray = NSMutableArray() //总数据
    fileprivate var dateList:[String]? //存放日期的数组，用来显示section
    
    
    var lastNewsModel:ZHLastNewsModel?
    
    //获取最新新闻数据
    func getLastNewsData(_ completion:@escaping () ->Void){
        
        weak var weakSelf = self
        let urlStr = "news/latest"
        let requestTool = ANHttpReuqest.sharedInstance
        requestTool.getRequest(urlString: urlStr, success: { (json) in
            
            let model:ZHLastNewsModel = ZHLastNewsModel.mj_object(withKeyValues: json)
            weakSelf?.lastNewsModel = model
            
            weakSelf?.currentDate = model.date
            
            //配置日期数组
            weakSelf?.dateList = [String]()
            weakSelf?.dateList?.append((weakSelf?.currentDate!)! as String)
            
            
            //newsLayoutArr总数据 布局用 对应 tableView代理数据源  section row
            weakSelf?.newsLayoutArr = NSMutableArray()
            
            if (weakSelf?.newIdArr != nil){
                weakSelf?.newIdArr?.removeAll()
                weakSelf?.newIdArr = nil
            }
            weakSelf?.newIdArr = [String]()
            
            
            let tmpArr = NSMutableArray()
            for singleModel:ZHHomeSingleModel in model.storiesArray!{
                weakSelf?.newIdArr?.append(singleModel.newId!)
                let singleModelLayout:ZHSingleModelLayout = ZHSingleModelLayout()
                singleModelLayout.singleNewModel = singleModel
                tmpArr.add(singleModelLayout)
            }
            weakSelf?.newsLayoutArr.add(tmpArr)
            
            
            completion()
            
        }) { (error) in
//            completion(error as NSError)
        }
        
    }
    
    
    func getPreviousNewsData(_ completion:@escaping ()->Void){
    
        
        weak var weakSelf = self
        let urlStr = "news/before/"+self.currentDate!
        let requestTool = ANHttpReuqest.sharedInstance
        requestTool.getRequest(urlString: urlStr, success: { (json) in
            
            let model:ZHLastNewsModel = ZHLastNewsModel.mj_object(withKeyValues: json)
            
            weakSelf?.currentDate = model.date
            weakSelf?.dateList?.append(model.date!)
            
            let tmpArr = NSMutableArray()
            for singleModel:ZHHomeSingleModel in model.storiesArray!{
                weakSelf?.newIdArr?.append(singleModel.newId!)
                let singleModelLayout:ZHSingleModelLayout = ZHSingleModelLayout()
                singleModelLayout.singleNewModel = singleModel
                tmpArr.add(singleModelLayout)
            }
            
            weakSelf?.newsLayoutArr.add(from: tmpArr)
            completion()
            
        }) { (error) in
            
        }
    
    }

    //点击新闻cell跳转详情页
    func didSelectPush( fromVC : UIViewController , newid : String){
    
        let destVC = ZHNewDetailController()
         fromVC.navigationController?.pushViewController(destVC, animated: true)
    
    }
    
    //返回日期
    func dateOfSection(section:Int) -> String {
        
        return self.dateList![section]
    }
    
    //返回顶部轮播图数据
    func dataOfBanners() -> [ZHHomeSingleModel]{
    
        return (self.lastNewsModel?.topStoriesArray)!
    
    }
    
    //MARK:设置tableView数据源
    func numberOfSection() -> Int {
        return (self.newsLayoutArr.count)
    }

    func numberOfRowsInSection(section : Int) -> Int {
        
        //section下标从0开始 （所以.count > section）
        if (self.newsLayoutArr.count) > section {
            return (self.newsLayoutArr[section] as AnyObject).count
        }
        
        return 0
    }
    
    func singleNewModelAtIndexPath(indexPath : NSIndexPath) -> ZHHomeSingleModel{
    
        let singleModel:ZHSingleModelLayout = (self.newsLayoutArr[indexPath.section] as! NSMutableArray) [indexPath.row] as! ZHSingleModelLayout
        return singleModel.singleNewModel
    }
    
    func headerTitleForSection(section:Int) ->NSAttributedString{
    
        let title = self.convertToSectionTitleText(orginDate: self.dateList![section])
        let attr = NSAttributedString.init(string: title, attributes: [NSFontAttributeName:UIFont.boldSystemFont(ofSize: 20),NSForegroundColorAttributeName:UIColor.white])
        return attr
    
    }
    
    
    //时间格式转换
    fileprivate func convertToSectionTitleText(orginDate:String) -> String{
    
        //先把日期字符串 转换成日期类型，然后设置区域 zh-CH
        let formatter:DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let date:Date = formatter.date(from: orginDate)!
        //formatter.setLocalizedDateFormatFromTemplate("zh-CH")
        formatter.dateFormat = "MM月dd日 EEEE"  //02月10日 星期几
        let sectionTitleText:String = formatter.string(from: date)
        return sectionTitleText
        
    
    }
}
