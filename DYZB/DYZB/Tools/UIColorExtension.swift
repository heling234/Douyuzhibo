//
//  UIColorExtension.swift
//  DYZB
//
//  Created by 何凌 on 2020/4/28.
//  Copyright © 2020 heling. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(r:CGFloat,g:CGFloat,b:CGFloat){
        self.init(red:r/255.0,green:g/255.0,blue:b/255.0,alpha:1.0)
    }
}
