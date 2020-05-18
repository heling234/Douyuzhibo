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
    func loadAnchorData(URLString:String,parameters:[String: Any]? = nil,finishedCallback:@escaping()->()){
        
        NetworkTool.requestData(URLSting: URLString, type: methodType.get, parameters: parameters  as? [String : NSString]) { (result) in
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
    }
}
