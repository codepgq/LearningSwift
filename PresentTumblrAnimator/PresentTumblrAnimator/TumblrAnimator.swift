//
//  TumblrAnimator.swift
//  PresentTumblrAnimator
//
//  Created by ios on 16/9/23.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit

class TumblrAnimator: NSObject,UIViewControllerTransitioningDelegate ,UIViewControllerAnimatedTransitioning{
    //用于判断是否是present
    var isPresent : Bool = true
    
    /**
     监听present
     
     - parameter presented:  <#presented description#>
     - parameter presenting: <#presenting description#>
     - parameter source:     <#source description#>
     
     - returns: <#return value description#>
     */
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        isPresent = true
        return self
    }
    
    /**
     监听dismiss
     
     - parameter dismissed: <#dismissed description#>
     
     - returns: <#return value description#>
     */
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        isPresent = false
        return self
    }
    
    /**
     设置动画时长
     
     - parameter transitionContext: <#transitionContext description#>
     
     - returns: <#return value description#>
     */
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval{
        return 0.75
    }
    
    /**
     设置动画present/dismiss效果
     
     - parameter transitionContext: <#transitionContext description#>
     */
    func animateTransition(transitionContext: UIViewControllerContextTransitioning){
        // 1、得到VC
        let screens : (from:UIViewController, to:UIViewController) = (transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!, transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!)
        
        let menuViewController = !isPresent ? screens.from as! MenuViewController : screens.to as! MenuViewController
        let bottomViewController = !isPresent ? screens.to as UIViewController : screens.from as UIViewController
        
        
        // 2、得到View
        let toView = menuViewController.view
        let fromView = bottomViewController.view
        
        
        //判断是不是present，如果是，先把控件移到屏幕外
        if isPresent {
            closeVC(menuViewController)
        }
        
        
        // 3、获取容器
        let container = transitionContext.containerView()
        
        // 3.1、把内容添加到容器内
        container?.addSubview(fromView)
        container?.addSubview(toView!)
        
        // 4、执行动画
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
            if self.isPresent{
                self.showVC(menuViewController)
            }
            else{
                self.closeVC(menuViewController)
            }
            }) { (_) in
                transitionContext.completeTransition(true)
                UIApplication.sharedApplication().keyWindow!.insertSubview(fromView, atIndex: 0)
        }
    }
    
    //设置一开始的位置在屏幕外
    private func closeVC(controller : MenuViewController){
        controller.view.alpha = 0
        
        //left
        controller.audioBtn.transform = CGAffineTransformMakeTranslation(-300, 0)
        controller.audioLab.transform = controller.audioBtn.transform
        
        controller.photoBtn.transform = CGAffineTransformMakeTranslation(-150, 0)
        controller.photoLab.transform = controller.photoBtn.transform
        
        controller.textBtn.transform = CGAffineTransformMakeTranslation(-50, 0)
        controller.textLab.transform = controller.textBtn.transform
        
        
        //right
        controller.charBtn.transform = CGAffineTransformMakeTranslation(300, 0)
        controller.chatLab.transform = controller.charBtn.transform
        
        controller.messageBtn.transform = CGAffineTransformMakeTranslation(150, 0)
        controller.messageLab.transform = controller.messageBtn.transform
        
        controller.linkBtn.transform = CGAffineTransformMakeTranslation(50, 0)
        controller.linkLab.transform = controller.linkBtn.transform
    }
    
    //还原原始位置
    private func showVC(controller : MenuViewController){
        controller.view.alpha = 1
        
        //left
        controller.audioBtn.transform = CGAffineTransformIdentity
        controller.audioLab.transform = CGAffineTransformIdentity
        
        controller.photoBtn.transform = CGAffineTransformIdentity
        controller.photoLab.transform = CGAffineTransformIdentity
        
        controller.textBtn.transform = CGAffineTransformIdentity
        controller.textLab.transform = CGAffineTransformIdentity
        
        
        //right
        controller.charBtn.transform = CGAffineTransformIdentity
        controller.chatLab.transform = CGAffineTransformIdentity
        
        controller.messageBtn.transform = CGAffineTransformIdentity
        controller.messageLab.transform = CGAffineTransformIdentity
        
        controller.linkBtn.transform = CGAffineTransformIdentity
        controller.linkLab.transform = CGAffineTransformIdentity
    }
}
