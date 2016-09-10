//
//  ViewController.swift
//  Location
//
//  Created by ios on 16/9/9.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit

class ViewController: LocationViewController {

    @IBOutlet weak var address: UILabel!
    var layer : CAGradientLayer?
    
    
    @IBOutlet weak var effectView: UIView!
    
    
    @IBOutlet weak var backgroundImage: UIImageView!
    var item : Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

 
    @IBAction func getLocationCLick(sender: DIYButton) {
        startLocation { ( message) in
            print(message)
            self.address.text = message
            
            let cat = CATransition();
            cat.type = "cube"
            cat.duration = 1
            self.address.layer.addAnimation(cat, forKey: nil)
        }
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        let cat = CATransition();
        cat.type = "rippleEffect"
        cat.duration = 1
        view.layer.addAnimation(cat, forKey: nil)
        
        changeBackgroundImage()
    }
    
    func changeBackgroundImage(){
        item += 1
        if item > 6 {
            item = 1
        }
        
        backgroundImage.image = UIImage(named: "c\(item).jpg")
    }
}

