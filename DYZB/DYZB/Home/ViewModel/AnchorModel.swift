//
//  AnchorModel.swift
//  DYZB
//
//  Created by 何凌 on 2020/5/4.
//  Copyright © 2020 heling. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
 //房间id
   @objc var room_id : Int = 0
    //房间图片对应的URLString
   @objc var vertical_src :String = ""
    ///判断手机直播还是电脑直播
    //0电脑直播，1手机直播
    @objc var isVertical : Int = 0
    
    //房间名称
    @objc var room_name : String = ""
    
    //主播名称
    @objc var nickname : String = ""
    
    //在线人数
    @objc var online :Int = 0
    
    //所以城市
    var anchor_city :String = ""
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
        
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
//

}
