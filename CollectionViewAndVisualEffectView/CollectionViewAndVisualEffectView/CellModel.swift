//
//  CellModel.swift
//  CollectionViewAndVisualEffectView
//
//  Created by ios on 16/9/9.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit

class CellModel: NSObject {
    //定义属性
    var title : String = ""
    var descriptionStr: String = ""
    var image :UIImage!
    
    //初始化方法
    init(title:String, descriptionStr : String , image :UIImage!) {
        self.title = title
        self.descriptionStr = descriptionStr
        self.image = image
    }
    
    static func createCellModel() -> [CellModel]{
        return [
            CellModel(title: "离离原上草", descriptionStr: "离离原上草，撩妹我最屌", image: UIImage(named:"c1.jpg" )),
            CellModel(title: "一岁一枯荣", descriptionStr: "一岁一枯荣，把老子撩穷", image: UIImage(named:"c2.jpg" )),
            CellModel(title: "野火烧不尽", descriptionStr: "野火烧不尽，撩妹要尽兴", image: UIImage(named:"c3.jpg" )),
            CellModel(title: "春风吹又深", descriptionStr: "春分吹又深，切莫太认真", image: UIImage(named:"c4.jpg" )),
            CellModel(title: "若是君中意", descriptionStr: "若是君中意，往下点喜欢", image: UIImage(named:"c5.jpg" )),
            CellModel(title: "倘若无用处", descriptionStr: "倘若无用处，请把文章关", image: UIImage(named:"c6.jpg" )),
        ]
    }
}
