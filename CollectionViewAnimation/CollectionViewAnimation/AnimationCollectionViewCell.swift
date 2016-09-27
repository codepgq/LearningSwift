
//
//  AnimationCollectionViewCell.swift
//  CollectionViewAnimation
//
//  Created by ios on 16/9/27.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit

class AnimationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var backImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    /// 定义一个闭包
    var backButtonTapped : (() -> ())?
    
    func prepareCell(viewModel : AnimationCellModel){
        // 设置背景图片
        backImage.image = UIImage(named: viewModel.imagePath)
        // 设置按钮默认隐藏
        backButton.hidden = true
        // 为按钮添加点击事件
        addTapEventHandler()
    }
    
    // 当选中cell的时候调用方法
    func handleCellSelected() -> Void {
        backButton.hidden = false
        self.superview?.bringSubviewToFront(self)
    }
    
    // 按钮的点击事件
    private func addTapEventHandler(){
        backButton.addTarget(self, action: #selector(AnimationCollectionViewCell.backButtonClick), forControlEvents: .TouchUpInside)
    }
    
    @objc private func backButtonClick(){
        
        guard let back = backButtonTapped else {
            print("闭包是空的")
            return
        }
        
        back()
        
        // if 的写法
        /*
         if let back = backButtonTapped{
         back()
         }
         else{
         print("闭包是空的")
         }
         */
    }
}
