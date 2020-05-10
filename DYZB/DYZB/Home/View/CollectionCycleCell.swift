//
//  CollectionCycleCell.swift
//  DYZB
//
//  Created by 何凌 on 2020/5/8.
//  Copyright © 2020 heling. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {
    //定义模型属性
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLable: UILabel!
    
    var cycleModel : CycleModel?{
        didSet{
            titleLable.text = cycleModel?.title
            let iconURL = NSURL(string: cycleModel?.pic_url ?? "")!
            iconImageView.kf.setImage(with: ImageResource(downloadURL: iconURL as URL))
        }
    }
}
