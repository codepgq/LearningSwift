//
//  ViewController.swift
//  ImageScrollEffect
//
//  Created by ios on 16/9/13.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIScrollViewDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    
     var top : CGFloat = 0
    
    var imageView : UIImageView = {
        let iv = UIImageView(image: UIImage(named: "item"))
        iv.sizeToFit()
        return iv
    }()
    
    var showImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "item"))
        iv.userInteractionEnabled = true
        return iv
    }()
    
    @objc private func showScrollView(){
        
        UIView.animateWithDuration(0.5, animations: { 
            self.showImageView.frame = self.scrollView.frame
            self.showImageView.frame.size.width = self.scrollView.contentSize.width
            }) { (completion) in
            self.scrollView.hidden = false
                self.showImageView.removeFromSuperview()
                self.top = 0
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.addSubview(imageView)
        
        scrollView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        scrollView.zoomScale = scrollView.minimumZoomScale
        
        scrollView.delegate = self
        
        setZoomScaleFor(scrollView.frame.size)
        
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.showScrollView))
        
        showImageView.addGestureRecognizer(tap)
    }
    
    private func setZoomScaleFor(srollViewSize: CGSize) {
        
        let imageSize = imageView.bounds.size
        let widthScale = srollViewSize.width / imageSize.width
        let heightScale = srollViewSize.height / imageSize.height
        let minimunScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minimunScale
        scrollView.maximumZoomScale = 3.0
        
    }
    
    private func recenterImage() {
        
        let scrollViewSize = scrollView.bounds.size
        let imageViewSize = imageView.frame.size
        let horizontalSpace = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2.0 : 0
        let verticalSpace = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.width) / 2.0 :0
        
        scrollView.contentInset = UIEdgeInsetsMake(verticalSpace, horizontalSpace, verticalSpace, horizontalSpace)
        
    }
    
    
   
    
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        
        top = scrollView.contentInset.top
        self.recenterImage()
        
    }
    
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        
        if top >= 1 {
            scrollView.hidden = true
            showImageView.layoutMargins = scrollView.contentInset
            self.view.addSubview(showImageView)
            
            UIView.animateWithDuration(0.5, animations: {
                self.showImageView.frame = CGRect(x: 10, y: 20, width: 100, height: 100)
            })
        }
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        if top > 1 {
            return nil
        }
        return self.imageView
    }
}

