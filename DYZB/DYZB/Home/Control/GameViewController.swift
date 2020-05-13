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

private let kGameCellID = "kGameCellID"

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
    
    //1.增加懒加截属性\
    fileprivate lazy var gameVM : GameViewModel = GameViewModel()
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        
    //2.创建布局
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: kItemW, height: kItemH)
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
    
    layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
    
     //3.创建UICollectionView
    let collectionView = UICollectionView(frame: self.view.bounds,collectionViewLayout: layout)
        
    collectionView.register(UINib(nibName:"CollectionViewGameCell", bundle:nil) , forCellWithReuseIdentifier: kGameCellID)
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
    }
}

//请求数据
extension GameViewController{
    fileprivate func loadData(){
        gameVM.loadAllGameData {
            self.collectionView.reloadData()
        }
    }
}

