//
//  ZHOtherNewsModel.swift
//  MySwift
//
//  Created by An on 2017/2/21.
//  Copyright © 2017年 an. All rights reserved.
//

import UIKit

class ZHOtherNewsModel: NSObject {
    
//    "image_source": "",
//    "name": "大公司日报",
//    "image": "http://p2.zhimg.com/5b/68/5b68d586f273e1408fac1f231d61eb82.jpg",
//    "editors": [
//    {
//    "avatar": "http://pic4.zhimg.com/40f7ca4a683566acbe16a30a4992a943_m.jpg",
//    "id": 87,
//    "url": "http://www.zhihu.com/people/ding-wei",
//    "name": "丁伟",
//    "bio": "商业周刊中文版新媒体主编"
//    }"bio": "律所合伙人，关注公司发展"
//    ],
//    "description": "商业世界变化越来越快，就是这些家伙干的",
//    "background": "http://p1.zhimg.com/46/cb/46cb63bdd2bbcb8e5e4c70719c566c69.jpg",
//    "stories": [
//    {
//    "type": 0,
//    "id": 7483486,
//    "title": "更多大公司内容，都在读读日报里"
//    }
//    ],
//    "color": 1615359
    
    var image_source:String?
    var themeName:String?
    var themeImage:String?
    var editorsArray:NSArray?
    var descriptionString:String?
    var backgroundImage:String?
    var storiesArray:NSArray?
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["themeName":"name","themeImage":"image","backgroundImage":"background","editorsArray":"editors","storiesArray":"stories","descriptionString":"description"]
    }
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["editors":"ZHEditorsModel","stories":"ZHOtherSingleNewModel"]
    }
    

    override  func mj_keyValuesDidFinishConvertingToObject() {

        self.editorsArray = ZHEditorsModel.mj_objectArray(withKeyValuesArray: self.editorsArray).copy() as? NSArray
        
        self.storiesArray = ZHOtherSingleNewModel.mj_objectArray(withKeyValuesArray: self.storiesArray).copy() as? NSArray
        
//        self.storiesArray = ZHOtherSingleNewModel.mj_objectArray(withKeyValuesArray: self.storiesArray).copy() as?[ZHOtherSingleNewModel] as NSArray?
        
    }
    
}
