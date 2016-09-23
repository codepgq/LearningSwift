//
//  ViewController.swift
//  PresentTumblrAnimator
//
//  Created by ios on 16/9/23.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit

struct model {
    var icon = "animator1.jpg"
    var name = "default"
    var backImage = "animator1.jpg"
}

class ViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource{
    @IBOutlet weak var collectionView: UICollectionView!

    let data = [
        model(icon: "Chat", name: "小明", backImage: "animator1.jpg"),
        model(icon: "Quote", name: "老王", backImage: "animator2.jpg"),
        model(icon: "Audio", name: "隔壁大叔", backImage: "animator3.jpg"),
        model(icon: "Link", name: "邻家淑女", backImage: "animator4.jpg")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    @IBAction func unwindToMainViewController (sender: UIStoryboardSegue){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension ViewController {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 10
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collCell", forIndexPath: indexPath) as! CollectionViewCell
        let model = data[indexPath.row % 4]
        
        cell.backImage.image = UIImage(named: model.backImage)
        cell.icon.image = UIImage(named:model.icon)
        cell.nameLabel.text = model.name
        
        return cell
    }
}

