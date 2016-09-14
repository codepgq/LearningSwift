//
//  ViewController.swift
//  VideoLoginPage
//
//  Created by ios on 16/9/13.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit

class ViewController: PQLoginVideoViewController {

    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blackColor()
        setupVideoBackground()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        registerBtn.layer.cornerRadius = 5
        loginBtn.layer.cornerRadius = 5
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupVideoBackground() {
        
        let url = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("moments", ofType: "mp4")!)
        
        pq_videoFrame = view.frame
        pq_fillModel = .ResizeAspectFill
        pq_alwaysRepeat = true
        pq_sound = true
        pq_startTime = 2.0
        pq_alpha = 0.8
        
        pq_contentURL = url
        view.userInteractionEnabled = false
        
    }

}

