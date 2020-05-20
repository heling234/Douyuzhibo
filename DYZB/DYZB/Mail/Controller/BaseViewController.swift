//
//  BaseViewController.swift
//  DYZB
//
//  Created by 何凌 on 2020/5/12.
//  Copyright © 2020 heling. All rights reserved.
//

import UIKit

 

class BaseViewController: UIViewController {
//父控制器，让所有的页面继承
    var contentView:UIView?
    //增加懒加截属性
    fileprivate lazy var animImageView:UIImageView = {[unowned self] in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "img_loading_1")!,UIImage(named: "img_loading_2")!] //两个图片数组
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
        return imageView
    }()

    
    //体统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension BaseViewController{
   @objc  func setupUI(){
        //1. 隐藏内容的View
        contentView?.isHidden = true
        //2.添加执行动画的UIImageView
        view.addSubview(animImageView)
        //3.给anImageView.startAnimating()
        animImageView.startAnimating()
        //4.设置view的背景颜色
        view.backgroundColor = UIColor(r:250,g:250,b:250)
        }
    func loadDataFinished(){
        //1.停止动画
        animImageView.stopAnimating()
        //2.隐藏animImageView
        animImageView.isHidden = true
        //3.显示内容的View
        contentView?.isHidden = false

    }
}
