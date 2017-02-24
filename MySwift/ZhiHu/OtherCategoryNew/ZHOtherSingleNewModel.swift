//
//  ZHOtherSingleNewModel.swift
//  MySwift
//
//  Created by An on 2017/2/21.
//  Copyright © 2017年 an. All rights reserved.
//

import UIKit

class ZHOtherSingleNewModel: NSObject {
//    "id": 7195467,
//    "title": "停车应用野心勃勃抢占停车场",
//    "type": 2,
//    "images": [
//    "http://pic1.zhimg.com/418dc54bacb648126a9da15ef23a7ae0_t.jpg"
//    ]
    
    var newId:String?
    var newsTitle:String?
    var imageUrl:String?
    var newType:String?
    var imagesUrl:NSArray?
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["newId":"id","newsTitle":"title","imageUrl":"image","newType":"type","imagesUrl":"images"]
    }

}
