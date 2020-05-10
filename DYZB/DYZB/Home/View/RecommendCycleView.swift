//
//  RecommendCycleView.swift
//  DYZB
//
//  Created by 何凌 on 2020/5/8.
//  Copyright © 2020 heling. All rights reserved.
//

import UIKit
private let kCycelCellID = "kCycelCellID"
class RecommendCycleView: UIView {
    //定义属性
    var cycleTimer:Timer?
    
    var cycleModels:[CycleModel]?{
        didSet{
            //1.刷新collectView
            collectionView.reloadData()
            //2.设置pageControl的个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            //3.默认滚动到中间某一个位置
            let indexPath = NSIndexPath(item : (cycleModels?.count ?? 0) * 10,section: 0)
            collectionView.scrollToItem(at: indexPath as IndexPath, at: UICollectionView.ScrollPosition.left, animated: false)
        
            //4.添加定时器
            removeCycleTimer()
            addCycleTimer()
        }
    }
    
    
    //控件属性
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
   
    //系统回调
    override func awakeFromNib() {
       super.awakeFromNib()
                 //设置该控件不随父控件的拉伸而拉伸
                 autoresizingMask = []
        //注册cell
        collectionView.register(UINib(nibName:"CollectionCycleCell", bundle:nil) , forCellWithReuseIdentifier: kCycelCellID)
        
    }

    override func layoutSubviews() {
            super.layoutSubviews()
        //设置CollectionViewCell的layout
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.itemSize = collectionView.bounds.size
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.scrollDirection = .horizontal
            collectionView.isPagingEnabled = true
        
    }
    
}

//提供一个快速创建类的方法
extension RecommendCycleView {
    class func recommendCycleView() ->RecommendCycleView{
        return Bundle.main.loadNibNamed("RecommendCycleView",owner:nil,options:nil)?.first as! RecommendCycleView

    }
}

//遵守 UICollectionView数据源协议
extension RecommendCycleView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //* 10000为了循环轮播
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycelCellID, for: indexPath) as! CollectionCycleCell
        // % cycleModels!.count 循环轮播
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        return cell
    }
}
 //遵守 UICollectionView代理协议
extension RecommendCycleView: UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetx = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        self.pageControl.currentPage = Int(offsetx/scrollView.bounds.width) % (cycleModels?.count ?? 1)
        
        
         
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

extension RecommendCycleView{
    private func addCycleTimer(){
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector:#selector(self.scrolltoNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!,forMode:RunLoop.Mode.common)
    }
    private func removeCycleTimer(){
        cycleTimer?.invalidate()//从运行循环中移除
        cycleTimer = nil
    }
    @objc private func scrolltoNext(){
        //获取滚动的偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        //2.滚动该位置
        collectionView.setContentOffset(CGPoint(x:offsetX,y:0), animated: true)
        
    }
}

//let currentOffsetX = self.collectionView.centerXAnchor
//let offsetX = currentOffsetX + collectionView.bounds.width
//
