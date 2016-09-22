//
//  MenuTableViewController.swift
//  ModalAnimator
//
//  Created by ios on 16/9/22.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    //创建数据源
    private lazy var menuItems = ["今日热点","科技","汽车","娱乐","搞笑","生活"]
    //默认选择
    var selectTitle = "今日热点"
    //创建一个闭包
    var dismissBlock : ((title : String) -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    //返回有多少个cell
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    //设置每个的样式
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("menuCell", forIndexPath: indexPath) as! MenuTableViewCell

        cell.textLabel?.text = menuItems[indexPath.row]
        cell.textLabel?.textColor = (menuItems[indexPath.row]  == selectTitle) ? UIColor.orangeColor() : UIColor.lightTextColor()
        return cell
    }
 
    //点击cell的时候触发
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectTitle = menuItems[indexPath.row]
        tableView.reloadData()
        
        if let bibao = dismissBlock {
            bibao(title:selectTitle)
        }
    }

}
