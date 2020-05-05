//
//  AnchorGroup.swift
//  DYZB
//
//  Created by 何凌 on 2020/5/4.
//  Copyright © 2020 heling. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    @objc var icon_url : String = ""
    //小图标地址
    @objc var small_icon_url : String = ""
    //组显示的标题
    @objc var icon_name : String = "home_header_normal"
    //组显示名称
    @objc var tag_name : String = ""
    
    //该组中对应的房间信息
    @objc var room_list :[[String:NSObject]]? {
        didSet {
        guard let room_List = room_list else {return}
            for dict in room_List {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    
   //定义模型对象数组
    //private lazy var anchors : [AnchorModel] = [AnchorModel] ()
   @objc lazy var anchors : [AnchorModel] = [AnchorModel] ()
    //构造函数
    override init() {
     
    }
    
    init(dict : [String : NSObject]) {
        // print(dict["tag_name"]!)

        super.init()
        setValuesForKeys(dict)
 
//        self.icon_url  = dict["icon_url"] as! String
//        self.small_icon_url = dict["small_icon_url"] as! String
//        self.tag_name = dict["tag_name"] as! String
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
        /*
     override func setValue(_ value: Any?, forKey key: String) {
        if key == "room_list" {
            if let dataArray = value as? [[String : NSObject]] {
                for dict in dataArray{
                    anchors.append(AnchorModel(dict: dict))
                }
            }
        }
    }
 */
}
