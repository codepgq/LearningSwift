//
//  PQLoginVideoViewController.swift
//  VideoLoginPage
//
//  Created by ios on 16/9/13.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
import AVKit

public enum PQVideoScalingMode{
    case Resize
    case ResizeAspect
    case ResizeAspectFill
}

class PQLoginVideoViewController: UIViewController {
    
    //播放器
    private let pq_moviePlayer = AVPlayerViewController()
    //声音级别
    private var pq_moviePlayerSoundLevel: Float = 1.0
    //视频路径
    var pq_contentURL :NSURL = NSURL(){
        didSet{
            setMoviePlayer(pq_contentURL)
        }
    }
    //视频大小
    var pq_videoFrame = CGRect()
    //开始时间
    var pq_startTime : CGFloat = 0.0
    //时长
    var pq_duration : CGFloat = 0.0
    //把view的背景颜色设置为默认黑色
    var pq_backgroundColor : UIColor = UIColor.blackColor(){
        didSet{
            view.backgroundColor = pq_backgroundColor
        }
    }
    //是否能听到声音
    var pq_sound : Bool = true{
        didSet{
            if pq_sound {
                pq_moviePlayerSoundLevel = 1.0
            }
            else{
                pq_moviePlayerSoundLevel = 0.0
            }
        }
    }
    //透明度
    var pq_alpha : CGFloat = CGFloat(){
        didSet{
            pq_moviePlayer.view.alpha = pq_alpha
        }
    }
    //是不是重复播放
    var pq_alwaysRepeat :Bool = true{
        didSet{
            if pq_alwaysRepeat {
                NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PQLoginVideoViewController.pqLoginVideoPlayEnd), name: AVPlayerItemDidPlayToEndTimeNotification, object: pq_moviePlayer.player?.currentItem)
            }
        }
    }
    //填充模式
    var pq_fillModel : PQVideoScalingMode = .ResizeAspectFill{
        didSet{
            switch pq_fillModel {
            case .Resize:
                pq_moviePlayer.videoGravity = AVLayerVideoGravityResize
            case .ResizeAspect:
                pq_moviePlayer.videoGravity = AVLayerVideoGravityResizeAspect
            case .ResizeAspectFill:
                pq_moviePlayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        pq_moviePlayer.view.frame = pq_videoFrame
        pq_moviePlayer.showsPlaybackControls = false
        view.insertSubview(pq_moviePlayer.view, atIndex: 0)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK - method
    private func setMoviePlayer(url : NSURL){
        let videoCutter = PQVideoCutter()
        videoCutter.cropVideoWithURL(videoURL: url, startTime: pq_startTime, duration: pq_duration) { (videoPath, error) in
            if let path = videoPath as NSURL?{
                self.pq_moviePlayer.player = AVPlayer(URL: path)
                self.pq_moviePlayer.player?.play()
                self.pq_moviePlayer.player?.volume = self.pq_moviePlayerSoundLevel
            }
        }
    }
    
    @objc private func pqLoginVideoPlayEnd(){
        pq_moviePlayer.player?.seekToTime(kCMTimeZero)
        pq_moviePlayer.player?.play()
    }
}
