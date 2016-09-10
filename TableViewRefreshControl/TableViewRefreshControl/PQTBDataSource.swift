//
//  PQTBDataSource.swift
//  TableViewRefreshControl
//
//  Created by ios on 16/9/10.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit
//定义了一个闭包，不过我更喜欢说成Block
typealias pq_dataSourceBlcok = (cell : AnyObject,item :AnyObject) -> ()

class PQTBDataSource: NSObject , UITableViewDataSource {
    //定义三个属性
    var cellIdentifier : String?
    var items = Array<AnyObject>()
    var feedBack :((cell : AnyObject,item :AnyObject) -> ())?
    //定义一个静态方法，创建对象并返回
    static func initWith(cellIdentifier : String,items : NSArray ,block : pq_dataSourceBlcok) -> PQTBDataSource{
        let source = PQTBDataSource()
        source.items = items as Array<AnyObject>
        source.cellIdentifier = cellIdentifier
        source.feedBack = block
        return source
    }
    
    //根据IndexPath查找对象
    func itemWithIndexPath(indexPath : NSIndexPath) -> AnyObject{
        return self.items[indexPath.row]
    }
    
    //根据数组返回有多少个cell
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    //把cell和item打包，使用闭包传出去
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : AnyObject = tableView.dequeueReusableCellWithIdentifier(cellIdentifier!, forIndexPath: indexPath)
        
        if feedBack != nil {
            feedBack!(cell :cell,item: itemWithIndexPath(indexPath))
        }
        
        return cell as! UITableViewCell
    }
    
    //提供一个借口，更新数组
    func updateDatas(items : NSArray){
        self.items = items as Array
    }
}
