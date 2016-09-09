//
//  ViewController.swift
//  CollectionViewAndVisualEffectView
//
//  Created by ios on 16/9/9.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate{
    
    @IBOutlet weak var effectView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let data : Array = CellModel.createCellModel()
    
    var showView : ScreenView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        
        cell.cell = data[indexPath.row]
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionViewCell
        
        showView = ScreenView(frame: view.bounds, model: data[indexPath.row], tapBlock: { (view : ScreenView) -> () in
            UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 0.45, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
                self.showView!.frame = cell.frame
                self.showView!.alpha = 0
                self.showView!.layer.cornerRadius = 30
                }, completion: { (finished) in
                    self.showView!.removeFromSuperview()
            })
        })
        
        
        showView?.frame = cell.frame
        showView!.alpha = 0.1
        UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
                self.showView?.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
                self.showView!.alpha = 1
            }, completion: nil)
        
        self.view.addSubview(showView!)
        
    }
    
    
    
}

