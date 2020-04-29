//
//  HomeViewController.swift
//  DYZB
//
//  Created by 何凌 on 2020/4/27.
//  Copyright © 2020 heling. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 60

class HomeViewController: UIViewController {
    
    //Mark：懒加载属性
    private lazy var pageTitleView :PageTitleView = { [weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩","视频"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        //titleView.backgroundColor = UIColor.orange
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var pageContentView :PageContentView = {[weak self] in
        //1.确定内容的frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabbarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH+kNavigationBarH+kTitleViewH, width: kScreenW, height: contentH)
        
        //2.确定所有的子控制器
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        for _ in 0 ..< 4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()
    
    
    //系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

        // Do any additional setup after loading the view.
    }
}

//设置UI界面
    extension HomeViewController {
        private func setupUI(){
             //0.不需要设置scrollView的内边距
             UIScrollView().contentInsetAdjustmentBehavior = .never
             //1.设置导航栏
             setupNavigationBar()
            
            // 2.添加了TitleView
            view.addSubview(pageTitleView)
            
            //3.增加ContentView
            view.addSubview(pageContentView)
            pageContentView.backgroundColor = UIColor.purple
        }
       
        private func setupNavigationBar(){
            //设置左侧的item
            let btn = UIButton()
            btn.setImage(UIImage(named: "logo"), for: .normal)
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
            
            //设置右侧的Item
            //1. 采用单个创建，重复代码多
            
            
            
            let size = CGSize(width: 50, height: 50)
//
//            let historyBtn = UIButton()
//            historyBtn.setImage(UIImage(named: "image_my_history"), for: .normal)
//            historyBtn.setImage(UIImage(named: "image_my_history_clicked"), for: .highlighted)
//            //historyBtn.sizeToFit()
//           // historyBtn.frame = CGRect(origin: CGPoint, size: size)
//            historyBtn.frame = CGRect(origin: CGPoint.init(x: 0, y: 0), size: size)
//            let historyItem = UIBarButtonItem(customView: historyBtn)
            
            //2. 调用 Tools UIBarButtonItemExtension.swift ，这种写法比较简洁
//            let historyItem = UIBarButtonItem.screateItem(imageName: "image_my_history", hightImageName: "image_my_history_clicked", size: size)
            
            //3.构造函数
            let historyItem = UIBarButtonItem(imageName: "image_my_history", hightImageName: "image_my_history_clicked", size: size)
//            let searchBtn = UIButton()
//            searchBtn.setImage(UIImage(named: "btn_search"), for: .normal)
//            searchBtn.setImage(UIImage(named: "btn_search_clicked"), for: .highlighted)
//            //searchBtn.sizeToFit()
//            searchBtn.frame = CGRect(origin: CGPoint.init(x: 0, y: 0), size: size)
//            let searchItem = UIBarButtonItem(customView: searchBtn)
            
            //调用 Tools UIBarButtonItemExtension.swift ，这种写法比较简洁
//            let searchItem = UIBarButtonItem.screateItem(imageName: "btn_search", hightImageName: "btn_search_clicked", size: size)
            //3.构造函数
            let searchItem = UIBarButtonItem(imageName: "btn_search", hightImageName: "btn_search_clicked", size: size)
//            let qrcodeBtn = UIButton()
//            qrcodeBtn.setImage(UIImage(named: "Image_scan"), for: .normal)
//            qrcodeBtn.setImage(UIImage(named: "Image_scan_click"), for: .highlighted)
//            //qrcodeBtn.sizeToFit()
//            qrcodeBtn.frame = CGRect(origin: CGPoint.init(x: 0, y: 0), size: size)
//            let qrcodeItem = UIBarButtonItem(customView: qrcodeBtn)
            
            //调用 Tools UIBarButtonItemExtension.swift ，这种写法比较简洁
//             let qrcodeItem = UIBarButtonItem.screateItem(imageName: "Image_scan", hightImageName: "Image_scan_click", size: size)
            
            //3.构造函数
               let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", hightImageName: "Image_scan_click", size: size)
            //screateItem(imageName:String,hightImageName:String,size:CGSize) -> UIBarButtonItem {
            navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
        
        }
    }
    
//遵守PageTitleViewDelegate协议
extension HomeViewController:PageTitleViewDelegate{
    func pageTitleView(titleView: PageTitleView, selectIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
        
    }
}

//遵守PageContentViewDelegate协议
extension HomeViewController:PageContentViewDelegate{
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress,souceIndex:sourceIndex,targetIndex:targetIndex)
    }
}


