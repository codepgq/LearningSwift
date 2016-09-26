//
//  CustomRefreshView.swift
//  CustomPullToRefresh
//
//  Created by ios on 16/9/26.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit
/// 自定义刷新控件
class CustomRefreshView: UIRefreshControl {

    private var xibViews : Array<UIView> = []
    private var isAnimating : Bool = false
    private var currentColorIndex = 0
    private var currentLabelIndex = 0
    static func addViewsForNib( name : String) -> CustomRefreshView{
        let content = NSBundle.mainBundle().loadNibNamed(name, owner: self, options: nil).first as! UIView
        
        let cus = CustomRefreshView()
        cus.addSubview(content)
        
        for i in 0..<content.subviews.count {
            cus.xibViews.append(content.subviews[i])
            cus.xibViews[i].layer.cornerRadius = (cus.xibViews[i].bounds.width + cus.xibViews[i].bounds.height) * 0.25
            cus.xibViews[i].clipsToBounds = true
        }
        
        return cus
    }
    
    /**
     向外面提供一个开始动画的方法
     */
    func startAnimation(){
        animateRefreshStep1()
    }
    
    ///动画设置 外面不需要知道，所以都设置成为私有方法
    private func animateRefreshStep1() {
        
        isAnimating = true
        
        UIView.animateWithDuration(0.1, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            
            self.xibViews[self.currentLabelIndex].transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
            self.xibViews[self.currentLabelIndex].backgroundColor = self.getNextColor()
            
            }, completion: { (finished) -> Void in
                
                UIView.animateWithDuration(0.05, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                    self.xibViews[self.currentLabelIndex].transform = CGAffineTransformIdentity
                    
                    }, completion: { (finished) -> Void in
                        self.currentLabelIndex += 1
                        
                        if self.currentLabelIndex < self.xibViews.count {
                            self.animateRefreshStep1()
                        }
                        else {
                            self.animateRefreshStep2()
                        }
                })
        })
    }
    
    ///动画设置 外面不需要知道，所以都设置成为私有方法
    private func animateRefreshStep2() {
        UIView.animateWithDuration(0.40, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            
            self.xibViews[0].transform = CGAffineTransformMakeScale(1.5, 1.5)
            self.xibViews[1].transform = CGAffineTransformMakeScale(1.5, 1.5)
            self.xibViews[2].transform = CGAffineTransformMakeScale(1.5, 1.5)
            self.xibViews[3].transform = CGAffineTransformMakeScale(1.5, 1.5)
            self.xibViews[4].transform = CGAffineTransformMakeScale(1.5, 1.5)
            self.xibViews[5].transform = CGAffineTransformMakeScale(1.5, 1.5)
            self.xibViews[6].transform = CGAffineTransformMakeScale(1.5, 1.5)
            self.xibViews[7].transform = CGAffineTransformMakeScale(1.5, 1.5)
            
            }, completion: { (finished) -> Void in
                
                UIView.animateWithDuration(0.25, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                    self.xibViews[0].transform = CGAffineTransformIdentity
                    self.xibViews[1].transform = CGAffineTransformIdentity
                    self.xibViews[2].transform = CGAffineTransformIdentity
                    self.xibViews[3].transform = CGAffineTransformIdentity
                    self.xibViews[4].transform = CGAffineTransformIdentity
                    self.xibViews[5].transform = CGAffineTransformIdentity
                    self.xibViews[6].transform = CGAffineTransformIdentity
                    self.xibViews[7].transform = CGAffineTransformIdentity
                    
                    }, completion: { (finished) -> Void in
                        if self.refreshing {
                            self.currentLabelIndex = 0
                            self.animateRefreshStep1()
                        }
                        else {
                            self.isAnimating = false
                            self.currentLabelIndex = 0
                            for i in 0 ..< self.xibViews.count {
                                self.xibViews[i].transform = CGAffineTransformIdentity
                                self.xibViews[i].backgroundColor = UIColor.clearColor()
                            }
                        }
                })
        })
    }
    ///动画设置 外面不需要知道，所以都设置成为私有方法
    private func getNextColor() -> UIColor {
        var colorsArray: Array<UIColor> = [UIColor.magentaColor(), UIColor.brownColor(), UIColor.yellowColor(), UIColor.redColor(), UIColor.greenColor(), UIColor.blueColor(), UIColor.orangeColor()]
        
        if currentColorIndex == colorsArray.count {
            currentColorIndex = 0
        }
        
        let returnColor = colorsArray[currentColorIndex]
        currentColorIndex += 1
        
        return returnColor
    }
}
