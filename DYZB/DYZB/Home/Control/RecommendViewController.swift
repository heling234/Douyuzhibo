//
//  RecommendViewController.swift
//  DYZB
//
//  Created by 何凌 on 2020/4/29.
//  Copyright © 2020 heling. All rights reserved.
//

import UIKit
import Alamofire



private let  kCycleViewH = kScreenW * 3/8
private let  kCycleViewW = (kScreenW - 2*kItemMargin)
private let kGameViewH : CGFloat = 90
private let kPrettyItemW = (kScreenW - 3*kItemMargin)/2

class RecommendViewController: BaseAnchorViewController {

    //MARK：-增加懒加载属性
    private lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    //无线轮播
    private lazy var cycleView:RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        
        cycleView.frame = CGRect(x:kItemMargin, y: -(kCycleViewH + kGameViewH), width: kCycleViewW, height: kCycleViewH)
        return cycleView
    }()
    
    //RecommendGame
    private lazy var gameView:RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: kItemMargin, y: -kGameViewH, width: kCycleViewW, height: kGameViewH)
        return gameView
    }()
    
    

}

//MKRK:-设置UI界面内容
extension RecommendViewController {
     override func setupUI(){
        //1.先调用super.setupUI()
        super.setupUI()
        
        //2.将CycleView添加到UICollectionView中
       collectionView.addSubview(cycleView)
        
        //3.将gameView添加到collectView中
        collectionView.addSubview(gameView)
        //4.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}
 //发送网络请求数据
extension RecommendViewController{
         override func loadData(){
            //0.给父类中的ViewModel进行赋值
            baseVM = recommendVM
            //1.请求推荐数据
            recommendVM.requestData(){
            //1.1展示推荐数据
            self.collectionView.reloadData()
            //1.2将数据传递给gameview
            var groups = self.recommendVM.anchorGroups
            //1.2.1移除两条数据
            groups.removeFirst()
            groups.removeFirst()
            //1.2.2添加更多数据
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            self.gameView.groups = groups
            //1.2.3数据请求完成
            self.loadDataFinished()
        }
        //2.请求轮播数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}

//颜值cell的大小设置
extension RecommendViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, CellforItemAt indexPath: IndexPath)->UICollectionViewCell {
        if indexPath.section == 1 {
            //取出prettyCell
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionViewPrettyCell
            //2.设置数据
            prettyCell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            return prettyCell
        } else {
            return super.collectionView(collectionView,cellForItemAt: indexPath)
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kPrettyItemW, height: kPrettyItemH)
        }
        return CGSize(width: kPrettyItemW, height: kNormalItemH)
    }
}
