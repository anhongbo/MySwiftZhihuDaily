//
//  ZHEditorsModel.swift
//  MySwift
//
//  Created by An on 2017/2/21.
//  Copyright © 2017年 an. All rights reserved.
//

import UIKit

class ZHEditorsModel: NSObject {
//    "avatar": "http://pic4.zhimg.com/40f7ca4a683566acbe16a30a4992a943_m.jpg",
//    "id": 87,
//    "url": "http://www.zhihu.com/people/ding-wei",
//    "name": "丁伟",
    
    var avatar:String?
    var editorId:String?
    var editorUrl:String?
    var editorName:String?
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["editorId":"id","editorUrl":"url","editorName":"name"]
    }

}
