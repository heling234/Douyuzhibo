//
//  CollectionNormalCell.swift
//  DYZB
//
//  Created by 何凌 on 2020/4/30.
//  Copyright © 2020 heling. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionNormalCell: UICollectionViewCell {
    //控件的属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onLineBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var roomNameLabel: UILabel!
    
    //定义模型属性
    var anchor : AnchorModel? {
        didSet {
                   //0模型是否有值
                    guard let anchor = anchor else {return}
                   //1.取出在线人数显示的文字
                   var onLineStr : String = ""
                   if anchor.online >= 10000 {
                       onLineStr = "\(Int(anchor.online)/10000)万在线"
                   }else{
                       onLineStr = "\(anchor.online)在线"
                   }
                   onLineBtn.setTitle(onLineStr, for: .normal)
                   //2.昵称的显示
                   nickNameLabel.text = anchor.nickname

                   //3.封面图片
                    guard  let iconURL = NSURL(string: anchor.vertical_src) else  {return}
                    iconImageView.kf.setImage(with: ImageResource(downloadURL: iconURL as URL))
                    //4.房间名称
                    roomNameLabel.text = anchor.room_name
               }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
