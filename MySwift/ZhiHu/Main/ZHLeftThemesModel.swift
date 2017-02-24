//
//  ZHLeftThemesModel.swift
//  MySwift
//
//  Created by An on 2017/2/21.
//  Copyright © 2017年 an. All rights reserved.
//

import UIKit

class ZHLeftThemesModel: NSObject {
    
//    "color": 16046124,
//    "thumbnail": "http://pic1.zhimg.com/bcf7d594f126e5ceb22691be32b2650a.jpg",
//    "description": "关注体育，不吵架。",
//    "id": 8,
//    "name": "体育日报"
    
    var themesColor:Int?
    var thumbnail:String?
    var themeDescription:String?
    var themeId:String?
    var themeName:String?
    
//    init(themeId:String,themeName:String,themeDescription:String) {
//        super.init()
//        self.themeId = themeId
//        self.themeName = themeName
//        self.themesColor = 0
//        self.thumbnail = ""
//        self.themeDescription = ""
//    }
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["themesColor":"color","themeDescription":"description","themeId":"id","themeName":"name"]
    }
 
}
