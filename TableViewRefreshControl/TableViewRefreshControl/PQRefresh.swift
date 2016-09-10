//
//  PQRefresh.swift
//  TableViewRefreshControl
//
//  Created by ios on 16/9/10.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit

class PQRefresh: UIRefreshControl {
    
    var lastUpdateTime : String = "第一次更新"
    //定义一个闭包
    var didRefreshBlock:(() -> ())?
    
    //重写初始化方法，并设置样式，添加事件
    override init() {
        super.init()
        backgroundColor = UIColor(red:0.113, green:0.113, blue:0.145, alpha:1)
        let attributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        attributedTitle = NSAttributedString(string: lastUpdateTime,attributes: attributes)
        tintColor = UIColor.redColor()
        addTarget(self, action: #selector(self.didRefresh), forControlEvents: .ValueChanged)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //定义一个私有方法
    @objc private func didRefresh(){
        if didRefreshBlock != nil {
            didRefreshBlock!()
        }
        lastUpdateTime = "最后一次更新时间： \(getNowTime())"
        let attributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        attributedTitle = NSAttributedString(string: lastUpdateTime,attributes: attributes)
        endRefreshing()
    }
    
    //获取当前时间
    func getNowTime() -> String{
        let nowTime = NSDate()
        let dataFormater = NSDateFormatter()
        dataFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dataFormater.stringFromDate(nowTime)
    }
    
    //保存结束刷新代码，相当于保存block，在合适的时候调用
    func pqRefreshFinished(finish : () -> ()){
        didRefreshBlock = finish
    }

}
