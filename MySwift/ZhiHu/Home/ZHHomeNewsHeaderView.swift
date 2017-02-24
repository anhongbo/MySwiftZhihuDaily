//
//  ZHHomeNewsHeaderView.swift
//  MySwift
//
//  Created by An on 2017/2/20.
//  Copyright © 2017年 an. All rights reserved.
//

import UIKit

class ZHHomeNewsHeaderView: UITableViewHeaderFooterView {

    override func layoutSubviews() {
        super.layoutSubviews()
        self.textLabel?.center.x = self.width / 2
    }
    
    
}
