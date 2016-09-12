//
//  AppDelegate.swift
//  AudioPlayer
//
//  Created by ios on 16/9/12.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit
import AVFoundation
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        
        print(#function)
        
        do{
            //1、plist文件先加入 
            /*
             <key>UIBackgroundModes</key>
             <array>
             <string>audio</string>
             </array>
             
             */
            
            //2、设置后台播放模式
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            
            /*
             AVAudioSessionCategoryAmbient
             
             –混音播放，例如雨声、汽车引擎等，可与其他音乐一起播放
             
             AVAudioSessionCategorySoloAmbient
             
             –后台播放，其他音乐将被停止
             
             AVAudioSessionCategoryPlayback
             
             –独占音乐播放
             
             AVAudioSessionCategoryRecord
             
             –录制音频
             
             AVAudioSessionCategoryPlayAndRecord
             
             –播放和录制音频
             
             AVAudioSessionCategoryAudioProcessing
             
             –使用硬件解码器处理音频，该音频会话使用期间，不能播放或录音
             
             */
            
            
            //3、激活
            try AVAudioSession.sharedInstance().setActive(true)
            
            //4、允许接受事件，这里要做相应的处理
            UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
            
        }catch{
            
        }
        
    }
    
    

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print(#function)
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        print(#function)
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print(#function)
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        print(#function)
    }


}

