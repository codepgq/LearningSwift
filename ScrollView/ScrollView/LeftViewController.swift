//
//  LeftViewController.swift
//  ScrollView
//
//  Created by ios on 16/9/8.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pan: UIPinchGestureRecognizer? = UIPinchGestureRecognizer(target: self, action: #selector(LeftViewController.pinchEvent(_:)))
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(pan!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func pinchEvent(pinch : UIPinchGestureRecognizer){
        let scale : CGFloat = pinch.scale
        pinch.view?.transform = CGAffineTransformMakeScale(scale, scale)
        
        if pinch.state == UIGestureRecognizerState.Ended {
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.35, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
                    pinch.view?.transform = CGAffineTransformIdentity
                }, completion: { (a) in
                    print("animation finish")
            })
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
