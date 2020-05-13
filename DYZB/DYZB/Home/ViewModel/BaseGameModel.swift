//
//  BaseGameModel.swift
//  DYZB
//
//  Created by 何凌 on 2020/5/12.
//  Copyright © 2020 heling. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {

    //  //-定义属性
        @objc var tag_name:String = ""
        @objc var icon_url:String = ""
        @objc var small_icon_url : String = ""
        @objc var icon_name : String = "home_header_normal"
        @objc var pic_url:String = ""
    
    
    
    //-自定义构造函数
        override init() {}
    //
        init(dict:[String:Any]) {
            super.init()
            setValuesForKeys(dict)
        }
        override func setValue(_ value: Any?, forKey key: String) {}
    
}
