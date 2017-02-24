//
//  ZHLunchViewController.swift
//  MySwift
//
//  Created by An on 2017/2/24.
//  Copyright © 2017年 an. All rights reserved.
//

import UIKit

class ZHLunchViewController: UIViewController {

    lazy var lunchImageView:UIImageView? = {
        
        let imageV = UIImageView()
        imageV.contentMode = .scaleAspectFill
        return imageV
        }()
    
    let defaultImageView : UIImageView? = {
    
        let defaultV = UIImageView()
        defaultV.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight)
        defaultV.image = UIImage(named: ImageSourcePath + "Default")
        defaultV.contentMode = .scaleAspectFill
        return defaultV
    
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lunchImageView?.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight)
//        view.addSubview(lunchImageView!)
        view.addSubview(defaultImageView!)
        self.loadLunchImage()
    }

    func loadLunchImage(){
        //此链接已无法返回图片
//    "http://news-at.zhihu.com/api/4/start-image/1366*768"
        let request = URLRequest.init(url: URL.init(string: "http://p2.zhimg.com/10/7b/107bb4894b46d75a892da6fa80ef504a.jpg")!)
        
        let session = URLSession.shared
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let dataTask = session.dataTask(with: request,
                completionHandler: {(data, response, error) -> Void in
                    if error != nil{
                        self.defaultImageView?.removeFromSuperview()
                        self.lunchImageView?.removeFromSuperview()
                        self.view.removeFromSuperview()
                    }else{
                        
                        let image = UIImage(data: data!)
                        self.lunchImageView?.image = image
                        UIView.animate(withDuration: 1.5, animations: {
                            self.defaultImageView?.alpha = 0
                            
                        }, completion: { (finish) in
                            
                            self.defaultImageView?.removeFromSuperview()
                            self.view.removeFromSuperview()

//                            UIView.animate(withDuration: 0.5, animations: {
//                                
//                                self.lunchImageView?.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
//                                self.lunchImageView?.alpha = 0
//
//                            }, completion: { (finish) in
//                                
//                                self.lunchImageView?.removeFromSuperview()
//                                self.view.removeFromSuperview()
//
//                            })
                        })
                        
                    }
                    
                    semaphore.signal()
        }) as URLSessionTask
        
        //使用resume方法启动任务
        dataTask.resume()
        
        _ = semaphore.wait(timeout: DispatchTime.now() + 3)
        print("数据加载完毕！")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    deinit {
        print("启动页已销毁")
    }

}
