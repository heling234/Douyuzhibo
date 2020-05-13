//
//  GameViewModel.swift
//  DYZB
//
//  Created by 何凌 on 2020/5/12.
//  Copyright © 2020 heling. All rights reserved.
//

import UIKit

class GameViewModel:NSObject {
    lazy var games : [GameModel] = [GameModel]()
}

extension GameViewModel{
    func loadAllGameData(finishedCallback : @escaping()->()) {
        NetworkTool.requestData(URLSting: "http://capi.douyucdn.cn/api/v1/getColumnDetail", type: methodType.get,parmeters: nil) { (result) in
           // ["shortName":"game"]
        
            //1.获取到数据
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataArray = resultDict["data"] as? [[String:Any]] else {return}//有可能有值，有可能没有值，guard校验
            //2.字典转模型
            
            for dict in dataArray{
                self.games.append(GameModel(dict: dict))
            }
            finishedCallback()
        }
    }
}
