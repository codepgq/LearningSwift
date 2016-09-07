//
//  ViewController.swift
//  PlayVideo
//
//  Created by ios on 16/9/7.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate ,myBtnClickCellDelegate {
    
    var tableView = UITableView()
    
    
    var playViewController = AVPlayerViewController()
    var playerView = AVPlayer()
    
    var data : Array = [video(imageNamed: "videoScreenshot01", title: "Introduce 3DS Mario", time: "Youtube - 06:32"),
                        video(imageNamed: "videoScreenshot02", title: "Emoji Among Us", time: "Vimeo - 3:34"),
                        video(imageNamed: "videoScreenshot03", title: "Seals Documentary", time: "Vine - 00:06"),
                        video(imageNamed: "videoScreenshot04", title: "Adventure Time", time: "Youtube - 02:39"),
                        video(imageNamed: "videoScreenshot05", title: "Facebook HQ", time: "Facebook - 10:20"),
                        video(imageNamed: "videoScreenshot06", title: "Lijiang Lugu Lake", time: "Allen - 20:30")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView.init(frame: self.view.bounds, style: UITableViewStyle.Plain)
        tableView.delegate = self;
        tableView.dataSource = self;
        
        self.view.addSubview(tableView);
        
        tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: "Cell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TableViewCell
        cell.delegate = self
        let model = self.data[indexPath.row];
        
        cell.initData(model.imageNamed, title: model.title, deTitle: model.time)
       
        cell.myPlayBtnClickBlock { (button) in
            print("我是VC")
            self.playVideo()
        }
        
        return cell;
    }
    
    func playVideo(){
                
        let path = NSBundle.mainBundle().pathForResource("emoji zone", ofType: "mp4")
        
        self.playerView = AVPlayer(URL: NSURL(fileURLWithPath: path!))
        
        self.playViewController.player = self.playerView
        
        self.presentViewController(self.playViewController, animated: true) {
            self.playViewController.player?.play()
        }
    }
    
    func cellPlayBtnClick(cell: TableViewCell, button: UIButton) {
        print("进入代理了！！！")
        playVideo()
    }
}

