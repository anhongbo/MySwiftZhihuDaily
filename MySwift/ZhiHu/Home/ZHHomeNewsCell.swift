//
//  ZHHomeNewsCell.swift
//  MySwift
//
//  Created by An on 2017/2/18.
//  Copyright © 2017年 an. All rights reserved.
//

import UIKit


class ZHHomeNewsCell: UITableViewCell {
    
    //重用ID
    static fileprivate let identifier = "HomeNewsCellID"
    //懒加载
   fileprivate lazy var newTile:BaseLabel = {
    
        let title = BaseLabel()
        title.font = UIFont.boldSystemFont(ofSize: 15)
        title.textAlignment = .left
        title.numberOfLines = 3

        return title
    
    }()
    
    fileprivate lazy var newImage:UIImageView = {

        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override init(style : UITableViewCellStyle , reuseIdentifier : String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        let contentV = BaseView()
        contentV.addSubview(self.newTile)
        contentV.addSubview(self.newImage)
        self.contentView.addSubview(contentV)
        
        contentV.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        self.newImage.snp.makeConstraints { (make) in
            make.width.equalTo(75)
            make.height.equalTo(60)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
        }
        self.newTile.snp.makeConstraints { (make) in
            
            make.top.equalTo(self.newImage.snp.top)
            make.left.equalToSuperview().offset(10)
            make.right.equalTo(self.newImage.snp.left).offset(-10)
        }

        
    }
    
    class func cellWithTableView(_ tableView:UITableView) -> ZHHomeNewsCell{
    
        
        var cell = tableView.dequeueReusableCell(withIdentifier:identifier) as? ZHHomeNewsCell
        if cell == nil{
        
            cell = ZHHomeNewsCell(style: .default, reuseIdentifier: identifier)
        }
        return cell!
    }
    
    var newModel:ZHHomeSingleModel?{
    
        didSet{
            newTile.text = newModel?.newsTitle
            //没有图片 更新title约束
            self.updateSnpConstraintsWhenImageIsNil()
        }
    }
    
    
    var isUpdateConstraints = false
    func updateSnpConstraintsWhenImageIsNil() {
        
        if(newModel?.imagesUrl != nil){
            
            newImage.sd_setImage(with:URL(string: newModel?.imagesUrl?[0] as! String), placeholderImage: nil)
            
            if (isUpdateConstraints) {
                
                newImage.snp.updateConstraints({ (make) in
                    make.right.equalToSuperview().offset(-15)
                })
                isUpdateConstraints = false
            }
            
        }else{
            
            newImage.sd_setImage(with:URL(string: ""), placeholderImage: nil)
            newImage.snp.updateConstraints({ (make) in
                make.right.equalToSuperview().offset(70)
            })
            
            isUpdateConstraints = true
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
