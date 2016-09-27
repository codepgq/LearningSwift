//
//  ViewController.swift
//  CollectionViewAnimation
//
//  Created by ios on 16/9/27.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit

// MARK: - category方法
extension Array {
    //判断是否在下标区间内，在就返回值 否则返回空
    func safeIndex(i: Int) -> Element? {
        return i < self.count && i >= 0 ? self[i] : nil
    }
}

//Xib
private struct Storyboard{
    static let CellIdentifier = String(AnimationCollectionViewCell)
    static let NibName = String(AnimationCollectionViewCell)
}

//动画
private struct Constans {
    static let Duration : Double = 0.5
    static let Delay : Double = 0.0
    static let SpringDamping : CGFloat = 1.0
    static let SpringVelocity : CGFloat = 1.0
}

class ViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource{
    //数据源
    private var imageCollection = AnimationImageCollection()
    
    //懒加载collectionview
    private lazy var collectionView: UICollectionView! = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: 260 )
        let coll = UICollectionView(frame: UIScreen.mainScreen().bounds, collectionViewLayout: flowLayout)
        coll.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        return coll
    }()
    
    // 加载CollectionView
    override func viewDidLoad() {
        super.viewDidLoad()
        //register 提前注册
        collectionView.registerNib(UINib(nibName: Storyboard.NibName, bundle: nil), forCellWithReuseIdentifier: Storyboard.CellIdentifier)
        
        //设置代理
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //加载View
        view.addSubview(collectionView)
    }
    
    // 设置系统状态栏样式
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

}

// MARK: - 这里是Collectionview的代理 Datasource delegate
extension ViewController{

    // 返回有多少个cell
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCollection.images.count ?? 0
    }
    
    // 设置每个cell的样式
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //这里要满足两个条件
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIdentifier, forIndexPath: indexPath) as? AnimationCollectionViewCell, viewModel = imageCollection.images.safeIndex(indexPath.row) else {
            return UICollectionViewCell()
        }
        
        cell.prepareCell(viewModel)
        
        return cell
    }
    
    // cell 被点击是调用
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        guard let cell = collectionView.cellForItemAtIndexPath(indexPath) as? AnimationCollectionViewCell else{
            print("拿不到Cell")
            return
        }
        
        //调用动画方法
        cellAnimationWith(cell, collectionView: collectionView)
    }
    
    private func cellAnimationWith(cell : AnimationCollectionViewCell,collectionView : UICollectionView){
        // 设置为选中状态
        cell.handleCellSelected()
        
        //保存闭包代码
        cell.backButtonTapped = {
            guard let indexPaths = self.collectionView.indexPathsForSelectedItems() else{
                return
            }
            collectionView.scrollEnabled  = true
            collectionView.reloadItemsAtIndexPaths(indexPaths)
        }
        // 设置动画
        let animation : () -> () = {
            //设置大小
            cell.frame = collectionView.bounds
        }
        
        //动画结束又可以滑动了
        let completion : (fnished : Bool) -> () = { _ in
            collectionView.scrollEnabled = false
        }
        //开始动画
        UIView.animateWithDuration(Constans.Duration, delay: Constans.Delay, usingSpringWithDamping: Constans.SpringDamping, initialSpringVelocity: Constans.SpringVelocity, options: [], animations: animation, completion: completion)
    }
    
}



