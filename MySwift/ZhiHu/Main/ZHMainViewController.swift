//
//  ZHMainViewController.swift
//  MySwift
//
//  Created by An on 2017/2/15.
//  Copyright © 2017年 an. All rights reserved.
//

import UIKit

class ZHMainViewController: UIViewController {
 
    var leftMenuView:UIView?
    var containerController:UIViewController?
    var leftController:ZHLeftViewController?
    
    //手势开始时的原点
    var orginx:CGFloat = 0.0
    var isFold:Bool = false
    
    //拖拽、点击手势
    var panGesture = UIPanGestureRecognizer()
    var tapGesture = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpGesture()
        self.setUpUI()
    }

    //MARK: 添加手势
    fileprivate func setUpGesture(){
        
        panGesture = UIPanGestureRecognizer()
        panGesture.addTarget(self, action: #selector(handlePanGesture))
        
        tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(handleTapGesture))
        self.view.addGestureRecognizer(panGesture)
    
    }
    
    //MARK: 设置左侧抽屉视图和容器视图
    fileprivate func setUpUI(){
    
        //设置左侧view
        
        //添加自控制器到MainVC，再将leftMenu视图添加到当前控制器的view，不然无法触发tableView的代理delegate，只能触发tableView的dataSource代理
        self.leftController = ZHLeftViewController()
        self.addChildViewController(self.leftController!)

        self.leftMenuView = self.leftController?.view
        self.leftMenuView?.frame = CGRect(x: -ScreenWidth * kDrawerRatio, y: 0, width: ScreenWidth*kDrawerRatio, height: ScreenHeight)
        self.view.addSubview(leftMenuView!)
        
        //新闻 控制器 容器
        self.containerController = UIViewController()
        self.addChildViewController(self.containerController!)
        self.view.addSubview((self.containerController?.view)!)
        
        //首页控制器
        let homeVC = ZHHomeViewController()
        homeVC.showFlag = true
        let homeNav = ZHNavViewController(rootViewController: homeVC)
        self.containerController?.addChildViewController(homeNav)
        self.containerController?.view.addSubview(homeNav.view)
        
        //其他分类控制器
        let otherCateVC = OtherCategoryViewController()
        let otherCateNav = ZHNavViewController(rootViewController: otherCateVC)
        self.containerController?.addChildViewController(otherCateNav)
        self.containerController?.view.insertSubview(otherCateNav.view, belowSubview: homeNav.view)
        
        weak var weakSelf = self
        self.leftController?.clickNewsCell={ (type,cateModel) -> () in
            
            weakSelf?.hideDrawerList()

            if (type == 0){ //显示首页
                if (!otherCateVC.showFlag){ return}
                otherCateVC.showFlag = false
                weakSelf?.containerController?.view.bringSubview(toFront: homeNav.view)
                
            }else{
                //显示其他分类页面
                otherCateVC.commModel = cateModel
                
                if (otherCateVC.showFlag){ return}
                otherCateVC.showFlag = true
                weakSelf?.containerController?.view.bringSubview(toFront: otherCateNav.view)
            }
        }

}

    //MARK: 打开抽屉
    func showDrawerList(){
        
        UIView.animate(withDuration: 0.4, animations: {
            
            self.leftMenuView?.frame =  CGRect(x:0, y:0, width: ScreenWidth * kDrawerRatio, height: ScreenHeight)
            
            self.containerController?.view.frame = CGRect(x:ScreenWidth * kDrawerRatio, y:0, width: ScreenWidth, height: ScreenHeight)
            
        }) { (finish) in
            self.containerController?.view.addGestureRecognizer(self.tapGesture)
            self.isFold = true;
            
        }
    }
    //MARK: 隐藏抽屉
    func hideDrawerList (){
        
        UIView.animate(withDuration: 0.4, animations: {
            
            self.leftMenuView?.frame =  CGRect(x:-ScreenWidth * kDrawerRatio, y:0, width: ScreenWidth * kDrawerRatio, height: ScreenHeight)
            
            self.containerController?.view.frame = CGRect(x:0, y:0, width: ScreenWidth, height: ScreenHeight)
            
        }) { (finish) in
            self.containerController?.view.removeGestureRecognizer(self.tapGesture)
            self.isFold = false;
            
        }
    }

    func handlePanGesture(sender:UIPanGestureRecognizer) {
        
        //获取手势在View中的坐标
        let touchPoint = sender.location(in: self.view)
        
        switch sender.state {
        case .began:
            
            orginx = touchPoint.x
            break
        case .changed:
            
            //获取滑动偏移量
            var offSet = touchPoint.x - orginx
//            print(offSet)
            //超出leftView的宽度就等于left的宽度，反之
            if offSet >= ScreenWidth * kDrawerRatio{
                offSet = ScreenWidth * kDrawerRatio
            }
            
            if offSet <= -ScreenWidth * kDrawerRatio{
                offSet = -ScreenWidth * kDrawerRatio
            }
            
            if  isFold == false{
            
                self.leftMenuView?.frame = CGRect(x:  -ScreenWidth * kDrawerRatio + offSet, y: 0, width: ScreenWidth * kDrawerRatio, height: ScreenHeight)
                
                self.containerController?.view.frame =  CGRect(x:offSet, y:0, width: ScreenWidth, height: ScreenHeight)
                
                let x:CGFloat! = self.containerController?.view.x
                
                if  x <= 0 {
                     self.containerController?.view.frame = CGRect(x:0, y:0, width: ScreenWidth, height: ScreenHeight)
                }
                
                
                if (leftMenuView?.x)! <= -ScreenWidth * kDrawerRatio {
                    self.leftMenuView?.frame = CGRect(x:  -ScreenWidth * kDrawerRatio, y: 0, width: ScreenWidth * kDrawerRatio, height: ScreenHeight)
                }

            }else{

                
                leftMenuView?.frame = CGRect(x:offSet, y: 0, width: ScreenWidth * kDrawerRatio, height: ScreenHeight)
                
                self.containerController?.view.frame =  CGRect(x:ScreenWidth * kDrawerRatio + offSet, y:0, width: ScreenWidth, height: ScreenHeight)
                
                let x:CGFloat! = self.containerController?.view.x
                if x >= ScreenWidth * kDrawerRatio {
                    self.containerController?.view.frame = CGRect(x:ScreenWidth * kDrawerRatio, y:0, width: ScreenWidth, height: ScreenHeight)
                }
                
                if (leftMenuView?.x)! >= 0{
                    self.leftMenuView?.frame = CGRect(x:0, y: 0, width: ScreenWidth * kDrawerRatio, height: ScreenHeight)
                }
            }
            
            break
        case .ended:
            print("拖拽  end --- ")
            let currentOffsetX = (self.leftMenuView?.frame.origin.x)! + ScreenWidth * kDrawerRatio
            //偏移量临界值、判定是隐藏 还是 打开
            let maxMovingOffsetX = ScreenWidth * 0.2
            
            if currentOffsetX < maxMovingOffsetX {
                
                UIView.animate(withDuration: 0.2, animations: {
                    
                    self.leftMenuView?.frame =  CGRect(x:-ScreenWidth * kDrawerRatio, y:0, width: ScreenWidth * kDrawerRatio, height: ScreenHeight)
                    
                    self.containerController?.view.frame = CGRect(x:0, y:0, width: ScreenWidth, height: ScreenHeight)
                    
                }) { (finish) in
                    
                    //关闭视图容器的tap手势
                    self.containerController?.view.removeGestureRecognizer(self.tapGesture)
                    self.isFold = false;
                    
                }

            }else{
            
                //打开
                let duringTime:TimeInterval = Double(0.4 * currentOffsetX / (ScreenWidth * kDrawerRatio));

                UIView.animate(withDuration: duringTime, animations: {
                    
                self.leftMenuView?.frame =  CGRect(x:0, y:0, width: ScreenWidth * kDrawerRatio, height: ScreenHeight)
                    
                self.containerController?.view.frame = CGRect(x:ScreenWidth * kDrawerRatio, y:0, width: ScreenWidth, height: ScreenHeight)
                    
                }) { (finish) in
                    
                self.containerController?.view.addGestureRecognizer(self.tapGesture)
                self.isFold = true;
                    
                }
            
            }
            
            break
            
        default:
            print("default -- ")
            break
            
        }

    }
    
    //MARK: 点击页面如果打开就 隐藏
    func handleTapGesture(sender:UITapGestureRecognizer) {
        
        if self.isFold {self.hideDrawerList()}
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
