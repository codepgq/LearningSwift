//
//  PQVideoCutter.swift
//  VideoLoginPage
//
//  Created by ios on 16/9/14.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit
import AVFoundation

extension String{
    var convert : NSString  { return  (self as NSString) }
    
}

class PQVideoCutter: NSObject {
    func cropVideoWithURL(videoURL url : NSURL,startTime :CGFloat,duration : CGFloat,completion:((videoPath : NSURL? ,error : NSError?) -> Void)?){
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) { 
            let asset = AVURLAsset(URL: url, options: nil)
            let exportSession = AVAssetExportSession(asset: asset, presetName: "AVAssetExportPresetHighestQuality")
            let paths :NSArray = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, .UserDomainMask, true)
            var outputURL = paths.objectAtIndex(0) as! String
            let manager = NSFileManager.defaultManager()
            do{
                try manager.createDirectoryAtPath(outputURL, withIntermediateDirectories: true, attributes: nil)
            }catch{
                
            }
            
            
            outputURL = outputURL.convert.stringByAppendingPathComponent("output.mp4")
            do{
                try manager.removeItemAtPath(outputURL)
            }catch{
                
            }
            
            if let exportSession = exportSession as AVAssetExportSession?{
                exportSession.outputURL = NSURL(fileURLWithPath: outputURL)
                exportSession.shouldOptimizeForNetworkUse = true
                exportSession.outputFileType = AVFileTypeMPEG4
                let start = CMTimeMakeWithSeconds(Float64(startTime), 600)
                let time = CMTimeMakeWithSeconds(Float64(duration), 600)
                let range = CMTimeRangeMake(start, time)
                exportSession.timeRange = range
                exportSession.exportAsynchronouslyWithCompletionHandler({ 
                    switch exportSession.status{
                    case .Completed:
                        completion?(videoPath: exportSession.outputURL,error: nil)
                    case .Failed:
                        print("Failed - \(exportSession.error)")
                    case .Cancelled:
                        print("Cancelled - \(exportSession.error)")
                    default :
                        print("other error")
                    }
                })
            }
        }
    }
}
