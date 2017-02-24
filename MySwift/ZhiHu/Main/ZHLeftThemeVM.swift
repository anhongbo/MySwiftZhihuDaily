//
//  ZHLeftThemeMV.swift
//  MySwift
//
//  Created by An on 2017/2/21.
//  Copyright © 2017年 an. All rights reserved.
//

import UIKit

class ZHLeftThemeVM: NSObject {

//    http://news-at.zhihu.com/api/4/themes   "others字典数据中"

    var themesArr:NSMutableArray = NSMutableArray()
    
    func getLeftThemesList(completed:@escaping () -> Void){
    
        let requestTool = ANHttpReuqest.sharedInstance
        
        weak var weakSelf = self
        requestTool.getRequest(urlString: "themes", success: { (json) in
            
            
            let homeThemeModel:ZHLeftThemesModel = ZHLeftThemesModel()
            homeThemeModel.themeId = "0"
            homeThemeModel.themeName = "首页"
            weakSelf?.themesArr = ZHLeftThemesModel.mj_objectArray(withKeyValuesArray: json["others"])
            weakSelf?.themesArr.insert(homeThemeModel, at: 0)
            
            completed()
            
        }) { (error) in
            
        }
    
    }
    
    
    func numberOfRowsInSection() -> Int{
        return self.themesArr.count
    }
    
    func cellModelAtIndexPath(indexPath:IndexPath) -> ZHLeftThemesModel{
    
        return self.themesArr[indexPath.row] as! ZHLeftThemesModel
    
    }
    
    
    
}
