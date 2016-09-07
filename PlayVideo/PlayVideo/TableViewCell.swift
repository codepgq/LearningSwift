//
//  TableViewCell.swift
//  PlayVideo
//
//  Created by ios on 16/9/7.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit

struct video {
    let imageNamed: String
    let title: String
    let time:String
    
}

typealias buttonClickFunc = (button:UIButton)->Void

protocol myBtnClickCellDelegate : class {
    func cellPlayBtnClick(cell : TableViewCell, button : UIButton)
}

class TableViewCell: UITableViewCell {
    
    weak var delegate : myBtnClickCellDelegate?
    
    var icon: UIImageView?
    var titleLabel : UILabel?
    var deTitleLabel: UILabel?
    var playBtn : UIButton?
    
    var myBtnClickBlock = buttonClickFunc?()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        icon?.frame = self.contentView.bounds
        playBtn?.bounds = CGRectMake(0, 0, 50, 50)
        playBtn?.frame.origin = CGPointMake((self.contentView.bounds.size.width - 50) / 2, (self.contentView.bounds.size.height - 50) / 2)
        playBtn?.setImage(UIImage.init(named: "playBtn"), forState: UIControlState.Normal)
        
        titleLabel?.frame = CGRectMake(0, self.contentView.bounds.size.width * 0.5 - 10, self.contentView.bounds.size.width, 20);
        deTitleLabel?.frame = CGRectMake(0, self.contentView.bounds.size.width * 0.5 + 20, self.contentView.bounds.size.width, 20);
     
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        playBtn = UIButton.init(type: UIButtonType.Custom)
        playBtn?.addTarget(self, action: #selector(TableViewCell.click(_:)), forControlEvents: UIControlEvents.TouchUpInside);
        
        icon = UIImageView.init()
        titleLabel = UILabel.init();
        titleLabel?.textAlignment = NSTextAlignment.Center
        titleLabel?.textColor = UIColor.whiteColor()
        deTitleLabel = UILabel.init();
        deTitleLabel?.textAlignment = NSTextAlignment.Center
        deTitleLabel?.textColor = UIColor.whiteColor()
        self.contentView.addSubview(icon!)
        self.contentView.addSubview(playBtn!)
        self.contentView.addSubview(titleLabel!)
        self.contentView.addSubview(deTitleLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // ------------- 这里只用一种方式，否则会crash -------------
    func click(button:UIButton){
        print("click me");
        
        //如果block不存在就不调用
        if (myBtnClickBlock != nil) {
            myBtnClickBlock!(button: button)
        }
        
        
  
//        delegate?.cellPlayBtnClick(self, button: button)

    }
    
    func myPlayBtnClickBlock(block:(button:UIButton)->Void){
        myBtnClickBlock = block
    }
    
    
    func initData(imageNamed : NSString , title : NSString , deTitle : NSString){
        icon?.image = UIImage.init(named: imageNamed as String)
        titleLabel?.text = String(title)
        deTitleLabel?.text = deTitle as String
    }
}