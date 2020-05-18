//
//  GameViewController.swift
//  DYZB
//
//  Created by 何凌 on 2020/5/12.
//  Copyright © 2020 heling. All rights reserved.
//

import UIKit

private let kEdgeMargin : CGFloat = 10
private let kItemW:CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
private let kItemH:CGFloat = kItemW * 6 / 5
private let kHeaderViewH:CGFloat = 50
private let kHeaderViewW:CGFloat = kScreenW

private let kGameViewH : CGFloat = 90

private let kGameCellID = "kGameCellID"
// private let kHeaderViewID = "kHeaderViewID"


class GameViewController: UIViewController, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionViewGameCell
        //cell.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
        //cell.backgroundColor = UIColor.randomColor()
        cell.baseGame = gameVM.games[indexPath.item]
        return cell
    }
    
 
    //注册后取出headView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
       let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
          //设置headerView的属性
        headerView.titleLable.text = "全部"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        return headerView
    }
  
    //1.增加懒加截属性\
    fileprivate lazy var gameVM : GameViewModel = GameViewModel()
    fileprivate lazy var topHeaderView:CollectionHeaderView = {
        let headerView = CollectionHeaderView.collectionHeaderView()
        headerView.frame = CGRect(x: 0, y: -(kHeaderViewH + kGameViewH), width: kScreenW, height: kHeaderViewH)
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.titleLable.text = "常见"
        headerView.moreBtn.isHidden = true
        return headerView
    }()
    
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
    //2.创建布局
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: kItemW, height: kItemH)
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
    
        //设置collectionView的内边距
    layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        
    //游戏页面的头部
    layout.headerReferenceSize = CGSize(width: kHeaderViewW, height: kHeaderViewH)
    
     //3.创建UICollectionView
    let collectionView = UICollectionView(frame: self.view.bounds,collectionViewLayout: layout)
        
    collectionView.register(UINib(nibName:"CollectionViewGameCell", bundle:nil) , forCellWithReuseIdentifier: kGameCellID)
        collectionView.register(UINib(nibName:"CollectionHeaderView", bundle:nil) , forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader,withReuseIdentifier: kHeaderViewID)
        
    collectionView.autoresizingMask=[.flexibleHeight,.flexibleWidth]
    collectionView.showsVerticalScrollIndicator = false
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.backgroundColor = UIColor.white
    collectionView.dataSource = self
    
    return collectionView
        
    }()

        //系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
        
    }
}

//设置UI界面
extension GameViewController{
    fileprivate func setupUI(){
        
    //1.将UICollectionView添加到控制顺器的View中
       view.addSubview(collectionView)
    //2.添加顶部的HeaderView
        collectionView.addSubview(topHeaderView)
    //3.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kHeaderViewH + kGameViewH , left: 0, bottom: 0, right: 0)
    //4.将常用游戏的View,添加到collectionView中
        collectionView.addSubview(gameView)
    }
}

//请求数据
extension GameViewController{
    fileprivate func loadData(){
        gameVM.loadAllGameData {
            //1.展示全部游戏
            self.collectionView.reloadData()
            //2.展示我们的常用游戏
            /*
            var tempArray = [BaseGameModel]()
            for i in 0..<10 {
                tempArray.append(self.gameVM.games[i])
            }
            self.gameView.groups = tempArray
            */ //上面的简化
            self.gameView.groups = Array(self.gameVM.games[0..<10])
        }
    }
}

