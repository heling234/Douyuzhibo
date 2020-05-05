//
//  NetworkTools.swift
//  DYZB
//
//  Created by 何凌 on 2020/5/2.
//  Copyright © 2020 heling. All rights reserved.
//

import UIKit
import Alamofire

enum methodType{
    case get
    case post
}

class NetworkTool {
    class func requestData(URLSting:String,type:methodType,parmeters:[String:NSString]? = nil, finishedCallback : @escaping (_ result: AnyObject)->()) {
        
    //1.获取类型
        //let method = type == .get ? MethodType.get :MethodType.post
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
    //2.发送网络请求
        AF.request(URLSting,method: method,parameters: parmeters).responseJSON { (response) in
       
            //3.获取数据
            guard response.value != nil else {
                print(response.error!)
                return
            }
            //4.将结果回调出去
            finishedCallback(response.value as AnyObject)
        }
    }
}


