//
//  ViewController.swift
//  TableViewCellEdit
//
//  Created by ios on 16/9/28.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UITableViewDelegate {
    
    static private let cellIdentifier = "cellIdentifier"
    
    /// DataSource
    private var dataSource = TBDataSource.cellIdentifierWith(cellIdentifier, data: ViewController.cellsData, style: TBSectionStyle.Section_Single) { (cell, item) in
        let newCell = cell as! TableViewCell
        newCell.updateWithItem(item as! cellModel)
    }
    
    /// tableView
    @IBOutlet weak var tableView: UITableView!
    
    /// 展示数据源
    static private var cellsData : NSArray = [
        cellModel(image: "1", name: "老吴") ,
        cellModel(image: "2", name: "老李") ,
        cellModel(image: "3", name: "老赵") ,
        cellModel(image: "4", name: "老王") ,
        cellModel(image: "5", name: "老杨") ,
        cellModel(image: "6", name: "老鸟") ,
        cellModel(image: "7", name: "老头") ,
        cellModel(image: "8", name: "老人")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        tableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        //创建选项
        let delete = UITableViewRowAction(style: .Normal, title: "🗑\n删除") { action, index in
            print("Delete button tapped")
            //刷新页面
            self.tableView.reloadRowsAtIndexPaths([index], withRowAnimation: UITableViewRowAnimation.Fade)
        }
        delete.backgroundColor = UIColor.grayColor()
        
        //创建选项
        let share = UITableViewRowAction(style: .Normal, title: "🤗\n分享") { (action: UITableViewRowAction!, indexPath: NSIndexPath) -> Void in
            
            //创建一个分享页面
            let activityViewController = UIActivityViewController(activityItems: ["老师","老司机"], applicationActivities: [PQCustomActivity()])
            //加载分享页面
            self.presentViewController(activityViewController, animated: true, completion: nil)
            
            //刷新页面
            self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
        share.backgroundColor = UIColor.redColor()
        
        //创建选项
        let download = UITableViewRowAction(style: .Normal, title: "⬇️\n下载") { action, index in
            print("Download button tapped")
            //刷新页面
            self.tableView.reloadRowsAtIndexPaths([index], withRowAnimation: UITableViewRowAnimation.Fade)
        }
        download.backgroundColor = UIColor.blueColor()
        
        return [download, share, delete]
    }
}


/**
 *  介绍UIActivityViewController
 
 展示重点：
 官方文档：When presenting the view controller, you must do so using the appropriate means for the current device. On iPad, you must present the view controller in a popover. On iPhone and iPod touch, you must present it modally
 中文翻译（大概意思）：当展示这个ViewController的时候需要根据当前的设备类型进行判断，在iPad上面使用popover，在其他的设备上面使用present
 
 excludedActivityTypes - 忽略类型
    NSString *const UIActivityTypePostToFacebook;
    NSString *const UIActivityTypePostToTwitter;
    NSString *const UIActivityTypePostToWeibo;
    NSString *const UIActivityTypeMessage;
    NSString *const UIActivityTypeMail;
    NSString *const UIActivityTypePrint;
    NSString *const UIActivityTypeCopyToPasteboard;
    NSString *const UIActivityTypeAssignToContact;
    NSString *const UIActivityTypeSaveToCameraRoll;
    NSString *const UIActivityTypeAddToReadingList;
    NSString *const UIActivityTypePostToFlickr;
    NSString *const UIActivityTypePostToVimeo;
    NSString *const UIActivityTypePostToTencentWeibo;
    NSString *const UIActivityTypeAirDrop;
 
 
 UIActivity - 服务
 官方文档：This class must be subclassed before it can be used. The job of an activity object is to act on the data provided to it and to provide some meta information that iOS can display to the user. For more complex services, an activity object can also display a custom user interface and use it to gather additional information from the user
 中文翻译（大概意思）：UIActivity必须通过继承来使用，他主要是操作给用户展示的信息，而且还可以操作展示定制化的界面来获取给多的数据信息
    
    
 《  详情  》查看  PQCustomActivity 类
 */
