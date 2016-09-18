//
//  ViewController.swift
//  Day_02tableView改变字体
//
//  Created by ios on 16/9/6.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var changeBtn: UIButton!
    
    
    var data : Array? = ["Day 2 TableView", "每天学习多一点", "每天累积一点点", "暗号：天王盖地虎", "🤗 😡 💔See you next Project", "Learning Swift","纸巾艺术","参考网络学习资料"]
    
    var fontNames = ["MFJinHei_Noncommercial-Regular", "PingFangSC-Thin", "KhmerSangamMN","Baskerville-SemiBold","Cochin-BoldItalic"]
    
    var fontRowIndex = 0
    
    var add = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        for family in UIFont.familyNames() {
            for font in UIFont.fontNamesForFamilyName(family){
                print(font)
            }
        }
        
        changeBtn.layer.cornerRadius = 50
        
        tableView.rowHeight = 30
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "FontCell");
        self.view.backgroundColor = UIColor .blackColor();
        
        self.automaticallyAdjustsScrollViewInsets = false;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func change(sender: UIButton) {
        
        add += 1
        fontRowIndex = add % fontNames.count;
        tableView.reloadData();
    }
    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        
//    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("FontCell", forIndexPath: indexPath)
        
        let text = data![indexPath.row]
        
        cell.backgroundColor? = UIColor.blackColor();
        cell.textLabel?.text = text
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.font = UIFont(name:self.fontNames[fontRowIndex], size:20)
        
        return cell
        
    }

}

