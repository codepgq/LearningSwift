//
//  CollectionViewCell.swift
//  CollectionViewAndVisualEffectView
//
//  Created by ios on 16/9/9.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var cell :CellModel!{
        didSet{
            createUI()
        }
    }
    
    
    func createUI(){
        imageV.image = cell.image
        titleLabel.text = cell.title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageV.layer.cornerRadius = 5
        imageV.layer.masksToBounds = true
    }
    
    
}
