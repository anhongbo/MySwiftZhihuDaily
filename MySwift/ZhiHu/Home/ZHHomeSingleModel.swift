//
//  ZHHomeSingleModel.swift
//  MySwift
//
//  Created by An on 2017/2/17.
//  Copyright © 2017年 an. All rights reserved.
//

import UIKit

class ZHHomeSingleModel: NSObject {
    
    var newId:String?
    var newsTitle:String?
    var imageUrl:String?
    var newType:String?
    var gaPrefix:String?
    var imagesUrl:NSArray?

    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["newId":"id","newsTitle":"title","imageUrl":"image","newType":"type","gaPrefix":"ga_prefix","imagesUrl":"images"]
    }
}
