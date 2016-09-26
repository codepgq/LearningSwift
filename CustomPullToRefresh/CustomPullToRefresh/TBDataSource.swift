//
//  TBDataSource.swift
//  CustomPullToRefresh
//
//  Created by ios on 16/9/26.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit
/**
 设置Section样式，默认 Single
 */
public enum TBSectionStyle : Int {
    
    ///Default 默认没有多个Section
    case Section_Single
    /// 有多个Section
    case Section_Has
}


class TBDataSource: NSObject,UITableViewDataSource {
    
    private var sectionStyle : TBSectionStyle = .Section_Single
    private var data : NSArray?
    private var identifier : String = "null"
    private var cellBlock : ((cell : AnyObject, item : AnyObject) -> ())?
    
    /**
     快速创建一个数据源，需要提前注册，数组和style要对应
     
     - parameter identifier: 标识
     - parameter data:       数据
     - parameter style:      类型
     - parameter cell:       回调
     
     - returns: 数据源对象(dataSource)
     */
    static func cellIdentifierWith(identifier : String , data : NSArray , style : TBSectionStyle , cell : ((cell : AnyObject, item : AnyObject) -> Void)) -> TBDataSource {
        let source = TBDataSource()
        
        source.sectionStyle = style
        source.data = data
        source.identifier = identifier
        source.cellBlock = cell
        
        return source
        
    }
    /**
     返回数据
     
     - parameter indexPath: indexPath
     
     - returns: 数据
     */
    private func itemWithIndexPath(indexPath : NSIndexPath) -> AnyObject{
        if sectionStyle == .Section_Single {
            return data![indexPath.row]
        }
        else{
            return data![indexPath.section][indexPath.row]
        }
    }
    
    /**
     返回有多少个Section
     
     - parameter tableView: tableView
     
     - returns: section
     */
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if sectionStyle == .Section_Single {
            return 1
        }
        return (data?.count)!
    }
    
    /**
     返回对应Section的rows
     
     - parameter tableView: tableView
     - parameter section:   section
     
     - returns: rows
     */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if sectionStyle == .Section_Single {
            return (data?.count)!
        }else{
            return (data?[section].count)!
        }
    }
    /**
     返回cell，并用闭包把cell封装到外面，提供样式设置
     
     - parameter tableView: tableView
     - parameter indexPath: indexPath
     
     - returns: cell
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
        if let block = cellBlock {
            block(cell: cell, item: itemWithIndexPath(indexPath))
        }
        return cell
    }
}
