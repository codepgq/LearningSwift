//
//  AnimationImageCollection.swift
//  CollectionViewAnimation
//
//  Created by ios on 16/9/27.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit

struct AnimationImageCollection {
    private let imagePaths = ["1","2","3","4","5"]
    var images : [AnimationCellModel]
    
    init(){
        images = imagePaths.map { AnimationCellModel(imagePath: $0) }
    }
}
