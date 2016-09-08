//
//  ViewController.swift
//  ScrollView
//
//  Created by ios on 16/9/8.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftVC :LeftViewController = LeftViewController(nibName: "LeftViewController", bundle: nil)
        let centerVC :CenterViewController = CenterViewController(nibName: "CenterViewController", bundle: nil)
        let rightVC :RightViewController = RightViewController(nibName: "RightViewController", bundle: nil)
        
        
        self.addChildViewController(leftVC)
        self.scrollView.addSubview(leftVC.view)
        leftVC.didMoveToParentViewController(self)
        
        
        self.addChildViewController(centerVC)
        self.scrollView.addSubview(centerVC.view)
        centerVC.didMoveToParentViewController(self)
        
        self.addChildViewController(rightVC)
        self.scrollView.addSubview(rightVC.view)
        rightVC.didMoveToParentViewController(self)
        
        var centerFrame : CGRect = centerVC.view.frame
        centerFrame.origin.x = self.view.frame.width
        centerVC.view.frame = centerFrame
        
        var rightFrame : CGRect = rightVC.view.frame
        rightFrame.origin.x = self.view.frame.width * 2
        rightVC.view.frame = rightFrame
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.width * 3, height: 0)
        self.scrollView.pagingEnabled = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

