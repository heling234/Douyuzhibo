//
//  NSDateExtension.swift
//  DYZB
//
//  Created by 何凌 on 2020/5/2.
//  Copyright © 2020 heling. All rights reserved.
//

import Foundation
extension NSDate{
//    class func getCurrentTime()->NSString {
//        let nowDate = NSDate()
//        let interval = nowDate.timeIntervalSince1970
//        return "\(interval)" as NSString
        
    //取消小数点的日期
        class func getCurrentTime()->NSString{
            let nowDate = NSDate()
            let interval = Int(nowDate.timeIntervalSince1970)
            return "\(interval)" as NSString
    }
}



