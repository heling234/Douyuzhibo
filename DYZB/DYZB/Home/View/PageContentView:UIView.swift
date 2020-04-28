//
//  PageContentView:UIView.swift
//  DYZB
//
//  Created by 何凌 on 2020/4/28.
//  Copyright © 2020 heling. All rights reserved.
//

import UIKit

class PageContentView_UIView: UIView {
    //定议属性
    private var childVcs : [UIViewController]
    private var parentViewController : UIViewController
    //自定义构造函数
    init(frame: CGRect,childVcs:[UIViewController],parentViewController:UIViewController) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame:frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
