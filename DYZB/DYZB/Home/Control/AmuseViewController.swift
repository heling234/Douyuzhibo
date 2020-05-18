//
//  AmuseViewController.swift
//  DYZB
//
//  Created by 何凌 on 2020/5/14.
//  Copyright © 2020 heling. All rights reserved.
//

import UIKit


//定义主控制器
class AmuseViewController: BaseAnchorViewController {
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
}



//请求数据

extension AmuseViewController{
    override func loadData() {
        baseVM = amuseVM
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
        }
    }
}


