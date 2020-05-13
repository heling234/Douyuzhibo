//
//  UIColor_Extension.swift
//  DYZB
//
//  Created by 何凌 on 2020/5/12.
//  Copyright © 2020 heling. All rights reserved.
//

import UIKit
extension UIColor{
    func Init(r:CGFloat,g:CGFloat,b:CGFloat){
        //type(of: self).init(red: r / 255.0,green: g / 255.0,blue: b / 255.0, alpha:1.0)
    }
    class func randomColor() -> UIColor {
      return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
}
