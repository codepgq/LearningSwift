//
//  LocationViewController.swift
//  Location
//
//  Created by ios on 16/9/9.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit
import CoreLocation

/*
 
 plist文件里面加上
 NSLocationAlwaysUsageDescription string 你在这里写的内容会提示在弹窗中
 NSLocationWhenInUseUsageDescription string 你在这里写的内容会提示在弹窗中
 **/

//闭包定义
typealias feedBackBlock = (message : String) -> ()

class LocationViewController: UIViewController , CLLocationManagerDelegate{
    
    var locationManager :CLLocationManager!
    var block = feedBackBlock?()
    var timer : NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func startLocation(feedBack :feedBackBlock){
        block = feedBack
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        //模拟定位获取成功
//        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(self.send), userInfo: nil, repeats: true)
    }
    
    func send(){
        timer?.invalidate()
        timer = nil
        block!(message: "来自遥远的国度,手机可获得真实位置")
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            
            self.locationManager.stopUpdatingLocation()
            
            if (error != nil) {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
            if placemarks!.count > 0 {
                let pm = placemarks![0]
                self.displayLocationInfo(pm)
            } else {
                print("Problem with the data received from geocoder")
            }
        })
    }
    
    func displayLocationInfo(placemark: CLPlacemark?) {
        if let containsPlacemark = placemark {
            if block != nil {
                self.block!(message: containsPlacemark.name!)
            }
        }
        
    }
}
