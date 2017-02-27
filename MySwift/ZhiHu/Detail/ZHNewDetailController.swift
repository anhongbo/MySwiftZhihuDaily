//
//  ZHNewDetailController.swift
//  MySwift
//
//  Created by An on 2017/2/21.
//  Copyright © 2017年 an. All rights reserved.
//

import UIKit

class ZHNewDetailController: UIViewController,ZHDetailBottomBtnDelegate{

    
    var detailModel:ZHHomeSingleModel?
    var headerView:ZHDetailHeaderView?
    var webView:UIWebView?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.extendedLayoutIncludesOpaqueBars = true

        self.view.backgroundColor = UIColor.white
        configUI()
        headerView?.detailModel = self.detailModel
        getDetailNews()
    }
    
    func getDetailNews(){
        
        let urlStr = "news/"+self.detailModel!.newId!
        ANHttpReuqest.sharedInstance.getRequest(urlString: urlStr, params: nil, success: { (json) in
            let bodyStr:String = json["body"] as! String
            let cssArr:NSArray = json["css"] as! NSArray
            let cssStr = cssArr[0]
            let bodyHtml = "<html><head><link rel=\"stylesheet\" href=\(cssStr)></head><body>\(bodyStr)</body></html>"
            self.webView?.loadHTMLString(bodyHtml, baseURL: nil)
        }) { (error) in
            
        }
    }

    private func configUI(){
        
        headerView = ZHDetailHeaderView()
        webView = ZHNewsWebView()
        let bottomView = ZHDetailBottomView()
        bottomView.delegate = self

        view.addSubview(webView!)
        view.addSubview(headerView!)
        view.addSubview(bottomView)
        
        
        headerView?.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(-40)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(260)
//            make.top.equalTo(-40)
        })
        
        bottomView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        webView?.snp.makeConstraints({ (make) in
            make.top.equalTo(20)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
        })
    }
    
    
    func detailBottomBtnClick(btn: UIButton) {
    
        switch btn.tag {
            
        case 10000:
            
           let _ = self.navigationController?.popViewController(animated: true)
        case 10001:
            print("一下条")
            
        case 10002:
            print("点赞")
            
        case 10003:
            print("分享")
            
        case 10004:
            print("留言")
        default: break
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
