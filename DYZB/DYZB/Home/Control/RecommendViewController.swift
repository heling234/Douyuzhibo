//
//  RecommendViewController.swift
//  DYZB
//
//  Created by 何凌 on 2020/4/29.
//  Copyright © 2020 heling. All rights reserved.
//

import UIKit
import Alamofire

private let kItemMargin:CGFloat = 10
private let kItemW = (kScreenW - 3*kItemMargin)/2
private let kNormalItemH = kItemW * 3/4
private let kPrettyItemH = kItemW * 3/3
private let kHeaderViewH:CGFloat = 50

private let  kCycleViewH = kScreenW * 3/8
private let  kCycleViewW = (kScreenW - 2*kItemMargin)

private let kGameViewH : CGFloat = 90

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"


class RecommendViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }

    func collectionView(_ collectionView:UICollectionView,numberOfItemsInSection section:Int)->Int{
        let group = recommendVM.anchorGroups[section]
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出section的headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        headerView.group  = recommendVM.anchorGroups[indexPath.section]
        return headerView
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1{
                return CGSize(width: kItemW, height: kPrettyItemH)
        }else{
                return CGSize(width: kItemW, height: kNormalItemH)
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //0.取出模型对象
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        //1.定义cell
       
        //2.获取cell
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionViewPrettyCell
                cell.anchor = anchor
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
                cell.anchor = anchor
            return cell
        }
        
    }
    

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
    
    private lazy var collectionView:UICollectionView = {[unowned self] in
       // 1.创建布局流水布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
       // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleWidth]
        collectionView.register(UINib(nibName:"CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName:"CollectionViewPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName:"CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        return collectionView
    }()
    
    
    //MARK：-系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1.设置UI界面
        setupUI()
        //2.发送网络请求
        loadData()


    }
}

//MKRK:-设置UI界面内容
extension RecommendViewController {
    fileprivate func setupUI(){
        //1.将UICollectionView添加到控制顺器的View中
        view.addSubview(collectionView)
        
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
    private func loadData(){
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
        }
        //2.请求轮播数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
        
    }
}


