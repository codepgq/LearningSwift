//
//  ViewController.swift
//  AudioPlayer
//
//  Created by ios on 16/9/12.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    
    private var player :AVAudioPlayer?
    private var timer : NSTimer?
    private var time : NSTimeInterval? = 1
    private var gradientLayer : CAGradientLayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            //得到路径
            let path : String? = NSBundle.mainBundle().pathForResource("Ecstasy.mp3", ofType: nil)
            
            //加载路径
            player = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: path!))
            //循环次数
//            player!.numberOfLoops = 100
            
            self.view.backgroundColor = UIColor.blueColor()
            
            //设置渐变层
            gradientLayer = CAGradientLayer()
            //graditent color
            gradientLayer!.frame = view.bounds
            let color1 = UIColor(white: 0.5, alpha: 0.2).CGColor as CGColorRef
            let color2 = UIColor(red: 1.0, green: 0, blue: 0, alpha: 0.4).CGColor as CGColorRef
            let color3 = UIColor(red: 0, green: 1, blue: 0, alpha: 0.3).CGColor as CGColorRef
            let color4 = UIColor(red: 0, green: 0, blue: 1, alpha: 0.3).CGColor as CGColorRef
            let color5 = UIColor(white: 0.4, alpha: 0.2).CGColor as CGColorRef
            
            gradientLayer!.colors = [color1, color2, color3, color4, color5]
            gradientLayer!.locations = [0.10, 0.30, 0.50, 0.70, 0.90]
            gradientLayer!.startPoint = CGPointMake(0, 0)
            gradientLayer!.endPoint = CGPointMake(1, 1)
            self.view.layer.addSublayer(gradientLayer!)
            
            
            
            
        }
        catch{//捕获异常
            //输出异常
            print(error)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playMusic(sender: UIButton) {
        
        sender.selected = !sender.selected
        if sender.selected {
            //判断准备好播放了没
            if player?.prepareToPlay() == true {
                //准备好了，就播放
                player?.play()
                //使用定时器动态改变gradientLayer渐变层
                timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(ViewController.setBackgroundLayer), userInfo: nil, repeats: true)
                timer?.fireDate = NSDate.distantPast()
            }
        }
        else{
            player?.pause()
            timer?.fireDate = NSDate.distantFuture()
        }
        
        
        
    }
    
    
    /*这里如果使用
     私有方法：
        那么在Timer中的Selector中应该写：#selector(ViewController.setBackgroundLayer) 并且在private中前面加上 @objc
         timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(ViewController.setBackgroundLayer), userInfo: nil, repeats: true)
         @objc private func setBackgroundLayer(){ ...code... }
     共有方法：
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(ViewController.setBackgroundLayer), userInfo: nil, repeats: true)
        func setBackgroundLayer(){ ... code... }
     
     */
    func setBackgroundLayer(){
        
        let redValue = CGFloat(drand48())
        let blueValue =  CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        
        self.view.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        
        //更新时间
        time = time! + 0.1
        if time > 1.0 {
            //更新label
            timeLabel.text = resultTime((player?.currentTime)!, duration: (Double((player?.duration)! / 10.0)))
            //重置time
            time = 0
        }
    }
    
    private func resultTime(currentTime : NSTimeInterval , duration : NSTimeInterval) -> String{
        
        return String.init(format: "%02.0f:%02.0f", currentTime / 60.0 ,currentTime % 60.0) + "/" + String.init(format: "%02.0f:%02.0f", duration / 60.0 ,duration % 60.0)
    }
}

