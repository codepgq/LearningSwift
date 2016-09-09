//
//  ScreenView.swift
//  CollectionViewAndVisualEffectView
//
//  Created by ios on 16/9/9.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit

class ScreenView: UIView {

    var image : UIImageView!
    var title : UILabel?
    var desTitle :UILabel?
    var block:(view : ScreenView) -> ();

    init(frame: CGRect, model : CellModel,tapBlock : (view : ScreenView) -> ()){
        block = tapBlock
        super.init(frame: frame)
        createUI(model)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI(model : CellModel){
        image = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height - 50))
        image.image = model.image
        title = UILabel(frame: CGRect(x: 0, y: self.frame.height - 45, width: self.frame.width, height: 20))
        title?.text = model.title
        desTitle = UILabel(frame: CGRect(x: 0, y: self.frame.height-25, width: self.frame.width, height: 20))
        desTitle?.text = model.descriptionStr
        
        self.addSubview(image)
        self.addSubview(title!)
        self.addSubview(desTitle!)
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        block(view: self)
    }
}
