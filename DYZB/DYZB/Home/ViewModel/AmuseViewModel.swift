//
//  AmuseViewModel.swift
//  DYZB
//
//  Created by 何凌 on 2020/5/15.
//  Copyright © 2020 heling. All rights reserved.
//

import UIKit
//类入口
class AmuseViewModel: BaseViewModel {
    
}

extension AmuseViewModel {
    func loadAmuseData(finishedCallback : @escaping ()->()) {
        loadAnchorData(URLString:"http://capi.douyucdn.cn/api/v1/getHotRoom/2",
                       finishedCallback:finishedCallback)
        
        }
        //NetworkTool.requestData(URLSting: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", type: methodType.get,
    }

