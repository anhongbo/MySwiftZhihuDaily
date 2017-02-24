//
//  ZHLastNewsModel.swift
//  MySwift
//
//  Created by An on 2017/2/19.
//  Copyright © 2017年 an. All rights reserved.
//

import UIKit
import MJExtension
class ZHLastNewsModel: NSObject {

    var date:String?
    var topStoriesArray:[ZHHomeSingleModel]?
    var storiesArray:[ZHHomeSingleModel]?
    
    
    //在swift中使用MJEXtension解析 模型嵌套数组模型中 需要这样使用，在解析完的数组中再将模型中的字典数组转成对应模型数组
    override func mj_keyValuesDidFinishConvertingToObject() {
        
        if (self.topStoriesArray != nil){
            self.topStoriesArray = ZHHomeSingleModel.mj_objectArray(withKeyValuesArray: self.topStoriesArray).copy() as? [ZHHomeSingleModel]
        }

        self.storiesArray = ZHHomeSingleModel.mj_objectArray(withKeyValuesArray: self.storiesArray).copy() as? [ZHHomeSingleModel]
    }

    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        
        return ["topStoriesArray":"top_stories","storiesArray":"stories"]
    }
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        
        return ["topStoriesArray":"ZHHomeSingleModel","storiesArray":"ZHHomeSingleModel"]
    }
}
