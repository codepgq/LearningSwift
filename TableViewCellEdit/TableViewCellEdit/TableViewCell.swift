//
//  TableViewCell.swift
//  TableViewCellEdit
//
//  Created by ios on 16/9/28.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit

class cellModel : NSObject{
    private let image :String
    private let name : String
    
    init(image:String,name : String){
        self.image = image
        self.name = name
    }
}

class TableViewCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var bImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func updateWithItem(item : cellModel){
        bImageView.image = UIImage(named: item.image)
        messageLabel.text = item.name
    }
}
