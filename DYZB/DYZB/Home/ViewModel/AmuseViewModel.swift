//
//  AmuseViewModel.swift
//  DYZB
//
//  Created by 何凌 on 2020/5/15.
//  Copyright © 2020 heling. All rights reserved.
//

import UIKit
//类入口
class AmuseViewModel: NSObject {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}

extension AmuseViewModel {
    func loadAmuseData(finishedCallback : @escaping()->()){
        NetworkTool.requestData(URLSting: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", type: methodType.get, parmeters: nil) { (result) in
            //1.对界面进行处理
            guard let resultDict = result as? [String:Any] else {return}
            guard let dataArray = resultDict["data"] as? [[String:Any]] else {return}
            
            //2.遍历数组中的字典
            for dict in dataArray{
                self.anchorGroups.append(AnchorGroup(dict:dict))
            }
            //3.回调数据
            finishedCallback()
        }
        
        //NetworkTool.requestData(URLSting: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", type: methodType.get,
    }
}
