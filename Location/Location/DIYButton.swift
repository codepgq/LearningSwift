//
//  DIYButton.swift
//  Location
//
//  Created by ios on 16/9/9.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit

class DIYButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.frame = self.bounds
        self.titleLabel?.removeFromSuperview()
        self.titleLabel?.frame = self.bounds
        self.titleLabel?.textAlignment = NSTextAlignment.Center
        self.insertSubview(self.titleLabel!, aboveSubview: self.imageView!)
    }

}
