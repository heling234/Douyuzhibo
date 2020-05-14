//
//  CollectionHeaderView.swift
//  DYZB
//
//  Created by 何凌 on 2020/4/30.
//  Copyright © 2020 heling. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    //定议模型属性
    
    var group : AnchorGroup?{
        didSet{
            titleLable.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
}

//从xib中快速创建的类方法
extension CollectionHeaderView{
    class func collectionHeaderView()->CollectionHeaderView{
        return Bundle.main.loadNibNamed("CollectionHeaderView", owner: nil, options: nil)?.first as! CollectionHeaderView
    }
}

