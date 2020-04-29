//
//  PageContentView:UIView.swift
//  DYZB
//
//  Created by 何凌 on 2020/4/28.
//  Copyright © 2020 heling. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(contentView : PageContentView,progress : CGFloat,sourceIndex:Int,targetIndex:Int)
}


private  let ContentCellID = "ContentCellID"

//遵守UICollectionViewDataSource
class PageContentView: UIView, UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        for view in cell .contentView.subviews{
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
    

    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startoffsetX = scrollView.contentOffset.x
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //0.判断是否点击事件
        if isForbidScrollDelegate {return}
        //1.获取数据，滚动进度progress、sourceIndex、targetIndex,判断是滚左还是滚右
        var progress:CGFloat = 0
        var sourceIndex:Int = 0
        var targetIndex:Int = 0
        //2.判断是滚左还是滚右
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        if currentOffsetX > startoffsetX {//滚左
            //1.计算progress
            progress = currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW)
            //2.计算sourceIndex
            sourceIndex = Int(currentOffsetX/scrollViewW)
            //3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count{
                targetIndex = childVcs.count - 1
            }
            //4.如果完全滚过去应该为1
            if currentOffsetX - startoffsetX == scrollViewW{
                progress = 1
                targetIndex = sourceIndex
            }
        }else{//滚右
            //1.计算progress
            progress = 1 - (currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW))
            //2.计算targetIndex
            targetIndex = Int(currentOffsetX/scrollViewW)
            //3.计算targetIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count{
                sourceIndex = childVcs.count - 1
            }
        }
        //3.将Progress/sourceIndex/targetIndex传递给titleView
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    


    
    //定议属性
    private var childVcs : [UIViewController]
    private weak var parentViewController : UIViewController?
    private var startoffsetX:CGFloat = 0
    private var isForbidScrollDelegate:Bool = false
    weak var delegate:PageContentViewDelegate?
    
    //增加懒加载属性
    private lazy var collectionView:UICollectionView = {[weak self] in
        //1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero,collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
    }()
    //自定义构造函数
    init(frame: CGRect,childVcs:[UIViewController],parentViewController:UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame:frame)
        
   //设置UI
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}


     //设置UI界面
extension PageContentView{
    private func setupUI(){
        //1.将所有子控制器添加到父控制器
        for childVc in childVcs{
            parentViewController?.addChild(childVc)
        }
        //2.添加UICollectionView,用于在cell中存放控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

//对外暴露的方法
extension PageContentView{
    func setCurrentIndex(currentIndex:Int) {
        //1.记录需要进行的代理方法
        isForbidScrollDelegate = true
        //2.滚到正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x:offsetX,y:0), animated: false)
        
    }
}



