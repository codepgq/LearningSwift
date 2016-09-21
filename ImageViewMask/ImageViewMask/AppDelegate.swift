//
//  AppDelegate.swift
//  ImageViewMask
//
//  Created by ios on 16/9/21.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    //懒加载图片
    private lazy var imageView : UIImageView = {
       let iv = UIImageView(frame: UIScreen.mainScreen().bounds)
        iv.image = UIImage(named: "7501334")
        return iv
    }()
    
    //懒加载Layer
    private lazy var imageViewMask : CALayer = {
        let layer = CALayer()
        layer.contents = UIImage(named: "twitter logo mask")?.CGImage
        layer.bounds = CGRect(x: 0, y: 0, width: 100, height: 81)
        layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        layer.contentsGravity = kCAGravityResizeAspect
        return layer
    }()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //创建window
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        //设置window根视图
        window?.rootViewController = UIViewController()
        //添加图片
        window?.addSubview(imageView)
        //设置遮罩
        imageView.layer.mask = imageViewMask
        //设置遮罩居中
        imageViewMask.position = (window?.center)!
        //开始动画
        startAnimationMask()
        //设置背景颜色
        window?.backgroundColor = UIColor(red:0.117, green:0.631, blue:0.949, alpha:1)
        //设置为可见
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func startAnimationMask(){
        //关键帧动画
        //1、创建keyFrameAnimation
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
        //2、设置时长
        keyFrameAnimation.duration = 0.6
        //3、设置代理
        keyFrameAnimation.delegate = self
        //3.1设置开始时间
        keyFrameAnimation.beginTime = CACurrentMediaTime() + 0.5
        //3.2设置动画模式
        keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)]
        //4、设置帧
        let key1 = NSValue(CGRect: imageViewMask.bounds)
        let key2 = NSValue(CGRect: CGRect(x: 0, y: 0, width: 80, height: 65))
        let key3 = NSValue(CGRect: CGRect(x: 0, y: 0, width: 1600, height:  1300))
        keyFrameAnimation.values = [key1,key2,key3]
        //4.1、设置帧动画时长
        keyFrameAnimation.keyTimes = [0,0.3,1]
        //5、添加到mask上
        imageViewMask.addAnimation(keyFrameAnimation, forKey: "bounds")
    }
    
    //动画结束后，把遮罩删除
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        imageView.layer.mask = nil
    }
}

