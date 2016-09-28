//
//  PQCustomActivity.swift
//  TableViewCellEdit
//
//  Created by ios on 16/9/28.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit


class PQCustomActivity: UIActivity {
    private let UIActivityTypePQCustomMine = "UIActivityTypePQCustomMine"
    //类型
    override func activityType() -> String? {
        return UIActivityTypePQCustomMine
    }
    //标题
    override func activityTitle() -> String? {
        return NSLocalizedString("customActivity", comment: "")
    }
    //图片
    /*
     deivce             ios version         size (pt)
     iphone ipod        ios 6               < 43*43
     iphone ipod        ios 7               60*60
     ipad               ios 6               < 60*60
     ipad               ios 7               76*76
     retina             all                 @2x
     */
    override func activityImage() -> UIImage? {
        return UIImage(named: "icon2")
    }
    //指定可以处理的数据列席，如果可以处理返回 ture
    override func canPerformWithActivityItems(activityItems: [AnyObject]) -> Bool {
        return true
    }
    
    // 点击我们自定义的按钮，调用自定义服务处理之前的准备工作，都需要在这方法中指定，比如可以根据数据展示一个界面来获取用户的额外数据信息
    override func prepareWithActivityItems(activityItems: [AnyObject]) {
        print("想操作更多的东西，就在我这里处理")
    }
    
    //返回操作类型
    /*
        UIActivityCategoryAction    表示在最下面一栏的操作型服务,比如Copy、Print
        UIActivityCategoryShare     表示在中间一栏的分享型服务，比如一些社交软件
     */
    override class func activityCategory() -> UIActivityCategory{
        return UIActivityCategory.Share
    }
    
    //要处理的事情
    override func performActivity() {
        print("你要我干嘛")
    }
}
