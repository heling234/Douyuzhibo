//
//  RecommendViewModel.swift
//  DYZB
//
//  Created by 何凌 on 2020/5/2.
//  Copyright © 2020 heling. All rights reserved.
//

import UIKit
//import Alamofire
class RecommendViewModel{
    
}


//Mark: -发送网络请求
extension RecommendViewModel{
    func requestData() {
        //1.请求第一部分推荐数据
       
        //2.请求第二部分颜值数据
        //3.请求后面部分游戏数据
        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time = (NSDate.getCurrentTime())
        NetworkTool.requestData(URLSting: "http://capi.douyucdn.cn/api/v1/getHotCate", type: methodType.get, parmeters: ["limit" : "4","offset" : "0","time" : NSDate.getCurrentTime()]) { (result) in
            print(result)
        
          /* 测试
        NetworkTool.requestData(URLSting: "http://httpbin.org/post", type:.post) { (result) in
                     print(result)

        NetworkTool.requestData(URLSting: "http://httpbin.org/post", type:.post) { (result) in
                     print(result)
        */
        
        }
    }
}
