//
//  RecommendViewModel.swift
//  DYZB
//
//  Created by 何凌 on 2020/5/2.
//  Copyright © 2020 heling. All rights reserved.
//

import UIKit
import SwiftyJSON

class RecommendViewModel{
    //
    
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    lazy var cycleModels:[CycleModel] = [CycleModel]()
    private lazy var bigdataGroup : AnchorGroup = AnchorGroup()
    private lazy var prettyGroup : AnchorGroup = AnchorGroup()
}

//Mark: -发送网络请求
extension RecommendViewModel{

    func requestData( finishCallback:@escaping ()->()) {
        //0.定义参数
        let parameters = ["limit":"4","offset":"0","time":NSDate.getCurrentTime()]
        //0创建数组
        let grouppress = DispatchGroup()
        //1.请求第一部分推荐数据
        grouppress.enter()
        NetworkTool.requestData(URLSting: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", type: .get, parmeters: ["time":NSDate.getCurrentTime()]) { (result) in
            //1.1 将result转成字典类型
                guard let resultDict = result as? [String:NSObject] else {return}
            //1.2根据data该key,获取数值
                guard let dataArray = resultDict["data"] as?[[String:NSObject]] else {return}
            //1.3遍历该字典，并且转成模型对象

            //1.3.1创建组的属性
            self.bigdataGroup.tag_name = "热门"
            self.bigdataGroup.icon_name = "home_header_hot"
            //1.3.2获取主播数据
            for dict in dataArray{
                let anchor = AnchorModel(dict: dict)
                self.bigdataGroup.anchors.append(anchor)
            }
            //1.3.3离开组
            grouppress.leave()
            //print("请求到1组数据")
        }
        //2.请求第二部分颜值数据
        grouppress.enter()
        NetworkTool.requestData(URLSting: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", type: .get, parmeters: parameters) { (result) in
            //2.1 将result转成字典类型
            guard let resultDict = result as? [String:NSObject] else {return}
            //2.2根据data该key,获取数值
            guard let dataArray = resultDict["data"] as?[[String:NSObject]] else {return}
            //2.3遍历字典，并且转成模型对象
            //2.3.2设置组的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            //获取主播所有数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                 self.prettyGroup.anchors.append(anchor)
            }
            grouppress.leave()
            //print("请求到2组数据")
        }
        
        //3.请求2-12部分游戏数据
        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time =  print(NSDate.getCurrentTime())
        //  NetworkTool.requestData(URLSting:"http://capi.douyucdn.cn/api/v1/getHotCate?", type: methodType.get) { (result) in
            grouppress.enter()
            NetworkTool.requestData(URLSting: "http://capi.douyucdn.cn/api/v1/getHotCate", type: methodType.get, parmeters: parameters) { (result) in
                //1.将result转成字典类型
                guard let resultDict = result as? [String : NSObject] else { return }
                //2.根据data该key,获取数值
                guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
                //3.遍历数组，获取字典，并且将字典转成模型对象
                //print (dataArray.count)
                
                for dict in dataArray {
                    let group = AnchorGroup(dict:dict) //类实例化,并获值给group
                    self.anchorGroups.append(group)
                }
                grouppress.leave()
                //print("请求到2-12部分")
            }
            grouppress.notify(queue: .main) {
                self.anchorGroups.insert(self.prettyGroup,at:0)
                self.anchorGroups.insert(self.bigdataGroup,at:0)
                finishCallback()
            }
        }
    //4.请求无线轮播数据
    func requestCycleData(finishCallback:@escaping() -> ()) {
        NetworkTool.requestData(URLSting: "http://www.douyutv.com/api/v1/slide/6", type: methodType.get, parmeters: ["version":"6.101"]) { (result) in
            //1.
            guard let resultDict = result as? [String:NSObject] else {
                return
            }
            //2.根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String :NSObject]] else {return}
            
            //3.字典转模型对象
            for dict in dataArray{
                self.cycleModels.append(CycleModel(dict:dict))
            }
           finishCallback()
        }
    }
}

