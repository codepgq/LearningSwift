//
//  MenuViewController.swift
//  PresentTumblrAnimator
//
//  Created by ios on 16/9/23.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var audioLab: UILabel!
    @IBOutlet weak var audioBtn: UIButton!
    
    @IBOutlet weak var charBtn: UIButton!
    @IBOutlet weak var chatLab: UILabel!
    
    @IBOutlet weak var photoBtn: UIButton!
    @IBOutlet weak var photoLab: UILabel!
    
    @IBOutlet weak var messageBtn: UIButton!
    @IBOutlet weak var messageLab: UILabel!
    
    @IBOutlet weak var textBtn: UIButton!
    @IBOutlet weak var textLab: UILabel!
    
    @IBOutlet weak var linkBtn: UIButton!
    @IBOutlet weak var linkLab: UILabel!
    
    @IBOutlet weak var visualView: UIVisualEffectView!
    
    private let animator = TumblrAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transitioningDelegate =  animator
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
