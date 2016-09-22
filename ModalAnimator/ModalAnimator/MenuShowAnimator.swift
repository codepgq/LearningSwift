//
//  MenuShowAnimator.swift
//  ModalAnimator
//
//  Created by ios on 16/9/22.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit

@objc protocol MenuShowAnimatorDelegate : NSObjectProtocol {
    
    func menuShowAnimatorDissmiss()
    
}


class MenuShowAnimator: NSObject ,UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning{
    
    var duration : NSTimeInterval = 0.5
    var isPresent : Bool = true
    private var snapshot :UIView?{
        
        didSet {
            if let _delegate = delegate {
                let tapGestureRecognizer = UITapGestureRecognizer(target: _delegate, action: #selector(MenuShowAnimatorDelegate.menuShowAnimatorDissmiss))
                snapshot?.addGestureRecognizer(tapGestureRecognizer)
            }
        }
        
    }
    
    weak var delegate:MenuShowAnimatorDelegate?
    
    /**
     执行modal的时候会调用 present
 
     - parameter presented:  显示的ViewController
     - parameter presenting: 发起的ViewController
     - parameter source:
     
     - returns: 谁负责
     */
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        isPresent = true
        return self
    }
    
    /**
     执行dismiss的时候会调用 dismiss
     
     - parameter presented:  显示的ViewController
     - parameter presenting: 发起的ViewController
     - parameter source:
     
     - returns: 谁负责
     */
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        isPresent = false
        return self
    }
    
}

// MARK: - 动画
extension MenuShowAnimator{
    /**
     动画时长
     
     - parameter transitionContext: 动画所需要的所有内容
     
     - returns: 时长
     */
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval{
        return duration
    }
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    /**
     负责动画，present dismiss 都要经过这个处理
     
     - parameter transitionContext: 动画所需要的所有内容
     */
    func animateTransition(transitionContext: UIViewControllerContextTransitioning){
        
        // 1、发起View
        let fromView = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)?.view
        // 2、展示View
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
        // 3、容器
        let container = transitionContext.containerView()
        // 4、设置向下，上的transForm
        let moveDown = CGAffineTransformMakeTranslation(0, (container?.bounds.height)! - 150)
        let moveUp = CGAffineTransformMakeTranslation(0, -50)
        // 5、截屏View
        if isPresent {
            toView?.transform = moveUp
            snapshot = fromView?.snapshotViewAfterScreenUpdates(true)
            container?.addSubview(toView!)
            container?.addSubview(snapshot!)
        }
        // 开始动画
        
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
            if self.isPresent{
                self.snapshot?.transform = moveDown
                toView?.transform = CGAffineTransformIdentity
            }else{
                self.snapshot?.transform = CGAffineTransformIdentity
                fromView?.transform = moveUp
            }
            }) { (_) in
                transitionContext.completeTransition(true)
                if !self.isPresent{
                    self.snapshot?.removeFromSuperview()
                }
        }
    }
    
}