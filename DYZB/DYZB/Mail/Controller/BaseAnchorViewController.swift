//
//  BaseAnchorViewController.swift
//  DYZB
//
//  Created by 何凌 on 2020/5/18.
//  Copyright © 2020 heling. All rights reserved.
//

import UIKit
let kItemMargin:CGFloat = 10
private let kHeaderViewH:CGFloat = 50

let kNormalItemW = (kScreenW - 3*kItemMargin)/2
let kNormalItemH = kNormalItemW * 3/4
let kPrettyItemH = kNormalItemW * 3/3

let kNormalCellID = "kNormalCellID"
let kPrettyCellID = "kPrettyCellID"
let kHeaderViewID = "kHeaderViewID"

class BaseAnchorViewController: BaseViewController {

    //定义属性
    var baseVM:BaseViewModel!
    lazy var collectionView:UICollectionView = {[unowned self] in
          // 1.创建布局流水布局
           let layout = UICollectionViewFlowLayout()
           layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
           
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
    
    //系统回调
    override func viewDidLoad() {
      super.viewDidLoad()
        setupUI()
        loadData()
    }
}

//

extension BaseAnchorViewController{
    override func setupUI(){
        //1.给父类中内容View的引用进行赋值
        contentView = collectionView
        //2.添加collectionView
        view.addSubview(collectionView)
        //3.调用父类super.setupUI
        super.setupUI()
        
    }
}

//请求数据

extension BaseAnchorViewController{
    @objc  func loadData(){
    }
}

// 遵守UICollectionView的数据源协议&代理协议
extension BaseAnchorViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        //2.给cell设置数据
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        //
        
        return cell
    }
    //section标题
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as!  CollectionHeaderView
        //2.给headerView设置数据
        headerView.group = baseVM.anchorGroups[indexPath.section]
        return headerView
    }
    
}
