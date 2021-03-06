//
//  CollectionViewGameCell.swift
//  DYZB
//
//  Created by 何凌 on 2020/5/11.
//  Copyright © 2020 heling. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionViewGameCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //定义数据模型
    var baseGame :BaseGameModel?{
        didSet{
            let iconURL = NSURL(string: baseGame?.icon_url ?? "")!
            titleLabel.text = baseGame?.tag_name
            iconImageView.kf.setImage(with: ImageResource(downloadURL: iconURL as URL),placeholder: UIImage(named: "home_more_btn"))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
