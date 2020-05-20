//
//  AmuseViewController.swift
//  DYZB
//
//  Created by 何凌 on 2020/5/14.
//  Copyright © 2020 heling. All rights reserved.
//

import UIKit

private let kMenuViewH :CGFloat = 200
//定义主控制器
class AmuseViewController: BaseAnchorViewController {
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    
    fileprivate lazy var menuView:AmuseMenuView = {
        let menuView = AmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width:kScreenW, height: kMenuViewH)
        //menuView.backgroundColor = UIColor.purple
        return menuView
    }()
}

extension AmuseViewController{
    override func setupUI(){
        super.setupUI()
        //将菜单的View添加到collectionView中
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
}


//请求数据
extension AmuseViewController{
    override func loadData() {
        baseVM = amuseVM
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
            //删除“最热”项
            var tempGroups = self.amuseVM.anchorGroups
            tempGroups.removeFirst()
            self.menuView.groups = tempGroups
            self.loadDataFinished()
        }
    }
}


