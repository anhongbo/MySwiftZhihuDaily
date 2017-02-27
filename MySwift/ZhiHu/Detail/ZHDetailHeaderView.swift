//
//  ZHDetailHeaderView.swift
//  MySwiftZhihu
//
//  Created by An on 2017/2/26.
//  Copyright © 2017年 an. All rights reserved.
//

import UIKit

class ZHDetailHeaderView: UIView {
    
    var newImageV:UIImageView!
    var titleLbl :UILabel!
    
    override  init(frame:CGRect){
        super.init(frame:frame)
        configUI()
    }
    
    var detailModel:ZHHomeSingleModel?{
        didSet{
            
            newImageV.sd_setImage(with: URL(string: (detailModel?.imageUrl)!))
            titleLbl.text = detailModel?.newsTitle
//            newsTitleConfig()
        }
    }
    
    func getDetailNews(){
    
        let urlStr = "news/"+self.detailModel!.newId!
        ANHttpReuqest.sharedInstance.getRequest(urlString: urlStr, params: nil, success: { (json) in
//            print(json)
            
            print(json["body"])
            let bodyStr = json["body"]
            let bodyHtml = "<html><head><link rel=\"stylesheet\" href=\(bodyStr)></head><body>%@</body></html>"
        }) { (error) in
            
        }
    }
    private func configUI(){
    
        newImageV = UIImageView()
//        newImageV.frame = self.bounds
        newImageV.contentMode = .scaleAspectFill
        newImageV.clipsToBounds = true
        
        titleLbl = UILabel()
//        titleLbl.frame = CGRect(x: 15, y: self.height - 30 - 20, width: ScreenWidth - 15, height: 30)
        titleLbl.numberOfLines = 0
        titleLbl.font = UIFont.boldSystemFont(ofSize: 21)
        titleLbl.textColor = UIColor.white
        
        addSubview(newImageV)
        addSubview(titleLbl)
        
        
        newImageV.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        titleLbl.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-25)
            make.height.greaterThanOrEqualTo(30)
        }

    }
    
    
    //设置新闻标题样式等
    private func newsTitleConfig(){
        
        let attr = NSAttributedString.init(string: (detailModel?.newsTitle!)!, attributes: [NSFontAttributeName:UIFont.boldSystemFont(ofSize: 21),NSForegroundColorAttributeName:UIColor.white])
        
        //计算title内容的size
        let titleSize = attr.boundingRect(with: CGSize(width:ScreenWidth - 30 ,height:220), options: [.usesLineFragmentOrigin,.usesFontLeading], context: nil).size
        self.titleLbl?.attributedText = attr
        self.titleLbl?.frame = CGRect(x: 15, y:self.height - titleSize.height - 25, width: ScreenWidth - 30, height: titleSize.height)
    
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
