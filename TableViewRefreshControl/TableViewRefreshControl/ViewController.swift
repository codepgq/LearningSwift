//
//  ViewController.swift
//  TableViewRefreshControl
//
//  Created by ios on 16/9/10.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate{

    //tableview
    var tableViewController = PQRefreshVC(style: .Plain)
    //刷新控件
    var refreshControl : PQRefresh = PQRefresh()
    
    //cell identifier
    let cellIdentifier = "myCellIdentifier"
    
    //data
    var data :Array = ["🤗🤗🤗🤗🤗", "😅😅😅😅😅", "😆😆😆😆😆"]
    let newFavoriteEmoji = ["我是新增的","🏃🏃🏃🏃🏃", "💩💩💩💩💩", "👸👸👸👸👸"]
    
    var pqDataSouce :PQTBDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myTableView = tableViewController.tableView
        myTableView.backgroundColor = UIColor(red:0.092, green:0.096, blue:0.116, alpha:1)
        
        pqDataSouce = PQTBDataSource.initWith(cellIdentifier, items: data, block: { (cell, item ) in
            
            let myCell = cell as! UITableViewCell
            let myItem = item as! String
            
            myCell.textLabel!.text = myItem
            myCell.textLabel!.textAlignment = NSTextAlignment.Center
            myCell.textLabel!.font = UIFont.systemFontOfSize(50)
            myCell.backgroundColor = UIColor.clearColor()
            myCell.selectionStyle = UITableViewCellSelectionStyle.None
        })
        
        myTableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        myTableView.dataSource = pqDataSouce
        myTableView.delegate = self
        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        myTableView.rowHeight = UITableViewAutomaticDimension
        myTableView.estimatedRowHeight = 60.0
        
        view.addSubview(myTableView)
        weak var weakSelf = self
        tableViewController.pqTableViewRefreshFinished { (tableView) in
            weakSelf!.data += weakSelf!.newFavoriteEmoji
            weakSelf!.pqDataSouce?.updateDatas(weakSelf!.data)
            myTableView.reloadData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

