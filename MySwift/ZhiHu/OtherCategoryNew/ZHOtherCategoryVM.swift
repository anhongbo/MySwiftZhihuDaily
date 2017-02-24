//
//  OtherCategoryVM.swift
//  MySwift
//
//  Created by An on 2017/2/21.
//  Copyright © 2017年 an. All rights reserved.
//

import UIKit
import SwiftyJSON

class OtherCategoryVM: NSObject {
    
    var otherNewsArr = NSArray()
    var editorsArr = NSArray()
    var commModel:ZHOtherNewsModel? = nil
    
    func getLastDataWithCate(cateModel:ZHLeftThemesModel,completion:@escaping ()->Void){
    
        let requestTool = ANHttpReuqest.sharedInstance
        
        let urlStr = "theme/"+cateModel.themeId!
        requestTool.getRequest(urlString: urlStr, success: { (json) in
            

            let model = ZHOtherNewsModel.mj_object(withKeyValues: json)
            self.commModel = model
            self.otherNewsArr = (model?.storiesArray)!
            self.editorsArr = (model?.editorsArray)!
            
            completion()
            
        }) { (error) in
            
        }
    }
    

    func numOfRowsInSection(section:Int) -> Int{
        return self.otherNewsArr.count
    }
    
    func cellModelForRowAt(indexPath :IndexPath) -> ZHOtherSingleNewModel{
    
        let model:ZHOtherSingleNewModel = self.otherNewsArr.object(at: indexPath.row) as! ZHOtherSingleNewModel
        
        return model
    
    }
    
}
