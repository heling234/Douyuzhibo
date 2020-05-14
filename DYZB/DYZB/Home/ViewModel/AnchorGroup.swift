//
//  AnchorGroup.swift
//  DYZB
//
//  Created by 何凌 on 2020/5/4.
//  Copyright © 2020 heling. All rights reserved.
//

import UIKit

class AnchorGroup: BaseGameModel {

    //该组中对应的房间信息
    @objc var room_list :[[String:NSObject]]? {
           didSet {
           guard let room_List = room_list else {return}
               for dict in room_List {
                   anchors.append(AnchorModel(dict: dict))
               }
           }
       }
        
    //组显示图标
    @objc var small_icon_url : String = ""
    @objc var icon_name : String = "home_header_normal"
     
    //定义模型对象数组
    @objc lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    
    //组显示标题
    //var tag_name : String = "" //父类有定义
    //game对应属标
 //   @objc var icon_url : String = ""/ /父类有定义
    //小图标地址
 
    //组显示的标题



    
    /*
   override init() {}
   init(dict:[String:NSObject]){
       super.init()
        setValuesForKeys(dict)
   }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
 */
    
 }
    



  //  override func setValue(_ value: Any?, forUndefinedKey key: String) {}。//父类有定义
       
    
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
