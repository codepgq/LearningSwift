//
//  ViewController.swift
//  ModalAnimator
//
//  Created by ios on 16/9/22.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,MenuShowAnimatorDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    private let animationDelegate : MenuShowAnimator = {
       let delegate = MenuShowAnimator()
        delegate.duration = 0.78
        return delegate
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置代理
        tableView.delegate = self
        tableView.dataSource = self
        
        //不然系统自动布局
        automaticallyAdjustsScrollViewInsets = false
        
        //设置标题颜色为 白灰色
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.lightTextColor()]
    }
    
    //动画代理
    func menuShowAnimatorDissmiss(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //重写prepareForSegue这个方法获取到线
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //获取下个页面的ViewController
        let menuController = segue.destinationViewController as! MenuTableViewController
        //用来设置下个页面的选中项
        menuController.selectTitle = self.navigationItem.title!
        //设置代理
        menuController.transitioningDelegate = animationDelegate
        //设置模式为自定义
        menuController.modalPresentationStyle = .Custom
        //设置动画的代理为当前类
        animationDelegate.delegate = self
        //使用闭包来保存一段代码，当下个页面点击cell的时候调用这个代码
        menuController.dismissBlock = {
            (title:String) -> Void
            in
            //设置标题
            self.navigationItem.title = title
            //执行dismiss动画
            self.menuShowAnimatorDissmiss()
        }
    }
    
}

// *********************   tableView  Delegate   *****************
extension ViewController{
    //返回多少组
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    //每组多少个
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    //每个的样式
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mainCell", forIndexPath: indexPath) as! MainTableViewCell
        
        cell.backImage.image = UIImage(named: String("animator\(indexPath.row % 4 + 1)"))
        return cell
    }
}
