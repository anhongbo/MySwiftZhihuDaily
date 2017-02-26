//
//  ZHDrawerCell.swift
//  MySwift
//
//  Created by An on 2017/2/16.
//  Copyright © 2017年 an. All rights reserved.
//

import UIKit

class ZHDrawerCell: UITableViewCell {

    //私有静态常量 重用标识符
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style : UITableViewCellStyle , reuseIdentifier : String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.backgroundColor = UIColor.colorWithCustom(35, g: 42, b: 48)
        self.contentView.addSubview(self.lblfenlei)
        self.contentView.addSubview(self.imageArror)
        
    }
    
    //MARK: 类方法 创建Cell
    class func cellWithTableView(_ tableView: UITableView) -> ZHDrawerCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "lefMenuCell") as? ZHDrawerCell
        if cell == nil {
            cell = ZHDrawerCell(style: .default, reuseIdentifier: "lefMenuCell")
        }
        return cell!
    }
    
    lazy var imageArror:UIImageView={
        let image = UIImageView()
        image.frame = CGRect(x: ScreenWidth * kDrawerRatio - 55, y: 13, width: 15, height: 18)
        image.image = UIImage.init(named: "Resource.bundle/leftEnter.png")
        return image
    }()
    
    lazy var lblfenlei:UILabel={
        let lblCate = UILabel()
        lblCate.frame = CGRect(x: 10, y: 0, width: 150, height: 44)
        lblCate.textColor = UIColor.lightGray
        lblCate.font = UIFont.systemFont(ofSize: 15.0)
        return lblCate
    }()
    
    var leftCellModel : ZHLeftThemesModel?{
        didSet{
            self.lblfenlei.text = leftCellModel?.themeName
        }
    }
    
    //强制要求实现
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            self.backgroundColor = UIColor.colorWithCustom(20, g: 20, b: 20)
            self.lblfenlei.textColor = UIColor.white

        }else{
            self.backgroundColor = UIColor.colorWithCustom(35, g: 42, b: 48)
            self.lblfenlei.textColor = UIColor.lightGray
        }
        
    }

}
