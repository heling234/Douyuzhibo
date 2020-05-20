//
//  BaseViewModel.swift
//  DYZB
//
//  Created by 何凌 on 2020/5/18.
//  Copyright © 2020 heling. All rights reserved.
//

import UIKit

class BaseViewModel {
    
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()

}
extension BaseViewModel{
    func loadAnchorData(isGroupData:Bool,URLString:String,parameters:[String: Any]? = nil,finishedCallback:@escaping()->()){
        
        NetworkTool.requestData(URLSting: URLString, type: methodType.get, parameters: parameters  as? [String : NSString]) { (result) in
            
        //1.对界面进行处理
        guard let resultDict = result as? [String:Any] else {return}
        guard let dataArray = resultDict["data"] as? [[String:Any]] else {return}
        
        //2.判断是否分组数据
        if isGroupData {
        // 2.1遍历数组中的字典
            for dict in dataArray{
            self.anchorGroups.append(AnchorGroup(dict:dict))
            }
        }else{
            //2.2创建组
            let group = AnchorGroup()
            //2.3遍历dataArray的所有字典
            for dict in dataArray{
                group.anchors.append(AnchorModel(dict: dict))
            }
            //2.3 将group添加到anchorGroups
            self.anchorGroups.append(group)
        }
        //3.回调数据
        finishedCallback()
        }
    }
}
