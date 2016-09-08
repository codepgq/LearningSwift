//
//  CenterViewController.swift
//  ScrollView
//
//  Created by ios on 16/9/8.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit
import AVFoundation

class CenterViewController: UIViewController , UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    var captureSession : AVCaptureSession?
    var stillImageOutPut : AVCaptureStillImageOutput?
    var preViewLayer : AVCaptureVideoPreviewLayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        preViewLayer?.frame = self.view.bounds
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        //创建对象
        captureSession = AVCaptureSession()
        //分辨率
        captureSession?.sessionPreset = AVCaptureSessionPreset1920x1080
        
        let backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        var error : NSError?
        var input : AVCaptureDeviceInput!
        
        do{
            input = try AVCaptureDeviceInput(device: backCamera)}
        catch let error1 as NSError{
            error = error1
            input = nil
        }
        
        if error == nil && captureSession?.canAddInput(input) != nil
        {
            captureSession?.addInput(input)
            
            stillImageOutPut = AVCaptureStillImageOutput()
            stillImageOutPut?.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
            
            if captureSession?.canAddOutput(stillImageOutPut) != nil
            {
                captureSession?.addOutput(stillImageOutPut)
                
                preViewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                preViewLayer?.videoGravity = AVLayerVideoGravityResizeAspect
                preViewLayer?.connection.videoOrientation = AVCaptureVideoOrientation.Portrait
                cameraView.layer.addSublayer(preViewLayer!)
                captureSession?.startRunning()
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        //点击屏幕保存图片
        showImage()
        
    }
    
    
    var didTakePhoto = Bool()
    
    func showImage(){
        if didTakePhoto == true {
            self.imageView.hidden = true
            didTakePhoto = false
        }else{
            didTakePhoto = true
            captureSession?.startRunning()
            clickScreenTakePhoto()
        }
    }
    
    
    
    func clickScreenTakePhoto(){
        if let videoConnection = stillImageOutPut?.connectionWithMediaType(AVMediaTypeVideo) {
            //方向
            videoConnection.videoOrientation = AVCaptureVideoOrientation.Portrait
            stillImageOutPut?.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: { (sampleBuffer, error) in
                
                if sampleBuffer != nil{
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                    let dataProvider = CGDataProviderCreateWithCFData(imageData)
                    let cgImageRef = CGImageCreateWithJPEGDataProvider(dataProvider, nil, true, CGColorRenderingIntent.RenderingIntentDefault)
                    let image = UIImage(CGImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.Right)
                    
                    self.imageView.image = image
                    self.imageView.hidden = false
                    
                    UIImageWriteToSavedPhotosAlbum(image, self, #selector(CenterViewController.image(_:didFinishSavingWithError:contextInfo:)),nil)
                }
            })
        }
    }
    
    func image(image: UIImage, didFinishSavingWithError: NSError?, contextInfo: AnyObject) {
        
        if didFinishSavingWithError == nil {
            showSuccessView()
            return
        }
        print("OK")
    }
    
    func showSuccessView(){
        let alert : UIAlertController? = UIAlertController(title: "提示", message: "图片保存成功咯", preferredStyle: UIAlertControllerStyle.Alert)
        
        let action: UIAlertAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Cancel) { (cancel) in
            
        }
        alert?.addAction(action)
        self.presentViewController(alert!, animated: true, completion: nil)
    }
    
}
