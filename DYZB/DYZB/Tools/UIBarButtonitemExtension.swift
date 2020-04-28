//
//  UIBarButtonitemExtension.swift
//  DYZB
//
//  Created by 何凌 on 2020/4/27.
//  Copyright © 2020 heling. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    /*
    class func screateItem(imageName:String,hightImageName:String,size:CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: hightImageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.init(x: 0, y: 0), size: size)
        return UIBarButtonItem(customView: btn)
    
    }
 */
    convenience init(imageName:String,hightImageName:String,size:CGSize ){
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: hightImageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.init(x: 0, y: 0), size: size)
    
        self.init(customView:btn)
    }
}
