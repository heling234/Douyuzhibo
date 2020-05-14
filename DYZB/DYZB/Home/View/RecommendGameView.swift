//
//  RecommendGameView.swift
//  DYZB
//
//  Created by 何凌 on 2020/5/11.
//  Copyright © 2020 heling. All rights reserved.
//

import UIKit
private let kGameCellID = "kGameCellID"
private let kEdgeInsetMargin : CGFloat = 10
class RecommendGameView: UIView {
//定义数据的属性
    var groups:[BaseGameModel]?{
        didSet{
            /*
            //1.移除两组数据
            groups?.removeFirst()
            groups?.removeFirst()
            
            //2.添加更多组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
  */
            //2.刷新表格
            collectionView.reloadData()

        }
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //系统回调
       override func awakeFromNib() {
          super.awakeFromNib()
        //让控件不随父控件的拉伸而拉伸
        autoresizingMask = []
        //注册cell
        
    collectionView.register(UINib(nibName:"CollectionViewGameCell", bundle:nil) , forCellWithReuseIdentifier: kGameCellID)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        //给collectionView添加内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
    }
}


extension RecommendGameView{
    class func recommendGameView()->RecommendGameView{
        return Bundle.main.loadNibNamed("RecommendGameView",owner:nil,options:nil)?.first as!RecommendGameView
    }
}

//mark:遵守UICollectionView的数据源协议


extension RecommendGameView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionViewGameCell
        cell.baseGame = groups![indexPath.item]
        
        //cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.blue
      
        return cell
    }
}
