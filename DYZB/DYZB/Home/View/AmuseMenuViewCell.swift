//
//  AmuseMenuViewCell.swift
//  DYZB
//
//  Created by 何凌 on 2020/5/18.
//  Copyright © 2020 heling. All rights reserved.
//

import UIKit
private let kGameCellID = "kGameCellID"
class AmuseMenuViewCell: UICollectionViewCell {

    //数据模型
    var groups : [AnchorGroup]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    //控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    //从xib中加载
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.register(UINib(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.width / 4
        let itemH = collectionView.bounds.height / 2
        layout.itemSize = CGSize(width: itemW, height: itemH)
        //设置item的间距为0
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
    }

}

extension AmuseMenuViewCell:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.求出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionViewGameCell
        //2.给cell设置数据
        cell.baseGame = groups![indexPath.item]
        //cell.backgroundColor = UIColor.randomColor()
        return cell
    }
}
