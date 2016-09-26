//
//  ViewController.swift
//  CustomPullToRefresh
//
//  Created by ios on 16/9/26.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    /// 数据源
    private lazy var dataSource : TBDataSource = {
       let source = TBDataSource.cellIdentifierWith("iconCell", data: [["😂", "🤗", "😳", "😌", "😊"],["😂", "🤗", "😳", "😌", "😊"],["😂", "🤗", "😳", "😌", "😊"]], style: TBSectionStyle.Section_Has, cell: { (cell: AnyObject, item: AnyObject) -> () in
            let newCell = cell as! UITableViewCell
            let newItem = item as! String
            newCell.textLabel!.text = newItem
            newCell.textLabel?.font = UIFont(name: "Apple Color Emoji", size: 40)
            newCell.textLabel?.textAlignment = NSTextAlignment.Center
       })
        return source
    }()
    
    private lazy var refreshControl : CustomRefreshView = CustomRefreshView.addViewsForNib("RefreshContents")
    
    private var isAnimating : Bool = false
    
    var timer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.rowHeight = 60
        
        tableView.addSubview(refreshControl)
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if refreshControl.refreshing {
            if !isAnimating {
                doSomething()
                refreshControl.startAnimation()
            }
        }
    }
    
    /**
     开启定时器
     */
    private func doSomething() {
        timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(ViewController.endedOfWork), userInfo: nil, repeats: true)
    }
    /**
     定时器结束，关闭动画
     */
    @objc private func endedOfWork() {
        refreshControl.endRefreshing()
        timer.invalidate()
        timer = nil
    }
}

