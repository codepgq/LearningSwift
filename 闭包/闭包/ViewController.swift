//
//  ViewController.swift
//  闭包
//
//  Created by ios on 16/9/10.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit

typealias imBlock = (view : UIView) -> ()

class ViewController: UIViewController {
    
    //没有参数，没有返回值
    var bibao1 : (() -> ())?
    //没有参数，有返回值
    var bibao2 : (() -> String)?
    //有参数，没返回值
    var bibao3 : ((age : Int) -> ())?
    //有参数，有返回值
    var bibao4 : ((a : Int , b : Int) -> Int)?
    
    var im = imBlock?()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //闭包的定义
        /*
         与Block类似，
         1、保存一段代码，以后执行
         2、做耗时操作，更新UI
         */
        
//        定义闭包的方式
        /*
         {
            () -> ()
            in
            code....
         }
         第一个括号代表：参数
         第二个括号代表：返回值
         in 用来表示这是一个闭包，表示in后面的就是要执行的代码
         */
        
//        写法一
        let block = {
            () -> ()
            in
            print("write Method One")
        }
        block()
        
//        写法二
        //如果在没有参数，没有返回值的情况下，in之前，包括in都可以省略不写
        let block2 = {
            print("write Method One")
        }
        block2()
    
        //没有参数没有返回值的闭包
        blockOne { 
            print("没有参数，没有返回值")
        }
        
        
        //没有参数有返回值的闭包
        blockTwo { () -> String in
            return "我是返回的参数"
        }
        
        //有参数没有返回值的闭包
        blockThree { (name) in
            print(name)
        }
        
        //有参数有返回值的闭包
        blockFour { (a, b) -> Int in
            return a + b
        }
        
        
        //实例
       let sc = createScrollView(CGRect(x: 0, y: 100, width: view.frame.width, height: 200), item: { () -> Int in
            //返回要创建的个数
            return 20
            }) { (num) -> UIView in
                //返回每一个View
                let imageView = UIImageView(frame: CGRect(x: num * 200 , y: 10, width: 180, height: 180))
                imageView.image = UIImage(named: "000.png")
                imageView.layer.cornerRadius = 90
                imageView.layer.masksToBounds = true
                
                //点击产生波纹效果
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.imageTap(_:)))
                imageView.addGestureRecognizer(tap)
                imageView.userInteractionEnabled = true
                return imageView
        }
        view.addSubview(sc)
        
    }
    
    func blockOne(block: () -> ()){
        //调用下面的遇见，才会执行闭包内的代码
        block()
    }
    
    
    func blockTwo(block:() -> String){
        print(block())
    }
    
    
    func blockThree(block :(name : String) -> ()){
        block(name: "我的名字叫小明")
    }
    
    
    func blockFour(block :(a : Int, b : Int) -> Int ){
        print(block(a: 5, b: 6))
    }
    
    
    func imageTap(tap :UITapGestureRecognizer){
        let cat = CATransition()
        cat.duration = 0.75
        cat.type = "rippleEffect"
        cat.subtype = "fromTop"
        tap.view!.layer.addAnimation(cat, forKey: nil)
    }
    
    func createScrollView (frame : CGRect,item : () -> Int , view : (num : Int) -> UIView) -> UIScrollView{
        //定义ScrollView
        let sc = UIScrollView(frame: frame)
        //设置背景颜色
        sc.backgroundColor = UIColor.purpleColor()
        //通过一个没有参数有返回值的block来得知要创建多少个View
        let count = item()
        //遍历
        for index in 0...(count - 1) {
            //通过一个有参数有并且返回值为View的block把返回值添加到ScrollView中
            sc.addSubview(view(num: index))
        }
        //通过获取ScrollView的子控件，得到他的宽度，用来计算contentSize
        let subView = sc.subviews.last
        //如果获取到子控件是空，直接返回scrollView
        if subView == nil {
            return sc
        }
        //设置contentSize
        sc.contentSize = CGSize(width: (subView?.frame.width)! + (subView?.frame.origin.x)!, height:(subView?.frame.height)!)
        //返回ScrollView
        return sc
    }

}

