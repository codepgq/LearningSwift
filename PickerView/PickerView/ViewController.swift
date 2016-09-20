//
//  ViewController.swift
//  PickerView
//
//  Created by ios on 16/9/20.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UIPickerViewDelegate,UIPickerViewDataSource{

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    
    private lazy var data : NSArray = {
       let imageArray = ["👻","👸","💩","😘","🍔","🤖","🍟","🐼","🚖","😭","🎹","😴"]
        var data1 = [String]()
        var data2 = [String]()
        var data3 = [String]()
        for var i = 0 ; i <= 100 ; i += 1
        {
            data1.append(imageArray[NSInteger(arc4random() % 10)])
            data2.append(imageArray[NSInteger(arc4random() % 10)])
            data3.append(imageArray[NSInteger(arc4random() % 10)])
//            data1.append(imageArray[0])
//            data2.append(imageArray[0])
//            data3.append(imageArray[0])
        }
        let array = [data1,data2,data3]
        return array
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startBtn.layer.cornerRadius = 5
        
        
        //设置代理
        pickerView.delegate = self
        pickerView.dataSource = self
        
      
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startBtnClick(sender: UIButton) {
        
        
        pickerView.selectRow(Int(arc4random()) % 90 + 3, inComponent: 0, animated: true)
        pickerView.selectRow(Int(arc4random()) % 90 + 3, inComponent: 1, animated: true)
        pickerView.selectRow(Int(arc4random()) % 90 + 3, inComponent: 2, animated: true)
        
        
        
        let d1 = (data[0][pickerView.selectedRowInComponent(0)]) as! String
        let d2 = (data[1][pickerView.selectedRowInComponent(1)]) as! String
        let d3 = (data[2][pickerView.selectedRowInComponent(2)]) as! String
        print(d1,d2,d3)
        
        if d1 == d2 && d1 == d3{
            messageLabel.text = "Bingo!"
        }
        else{
            messageLabel.text = "💔"
        }
        
        //按钮动画
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.35, initialSpringVelocity: 0, options: .CurveEaseOut, animations: { 
            self.startBtn.bounds = CGRect(x: self.startBtn.bounds.origin.x, y: self.startBtn.bounds.origin.y, width: self.startBtn.bounds.size.width + 20, height: self.startBtn.bounds.size.height)
            }) { (_) in
                UIView.animateWithDuration(0.15, animations: {
                    self.startBtn.bounds = CGRect(x: self.startBtn.bounds.origin.x, y: self.startBtn.bounds.origin.y, width: self.startBtn.bounds.size.width - 20, height: self.startBtn.bounds.size.height)
                })
        }
    }

    
    // returns the number of 'columns' to display.
    // 有多少列
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return data.count
    }
    
    // returns the # of rows in each component..
    // 每一列有多少个
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return data[component].count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        let ss : String = (data[component] as! NSArray)[row] as! String
        return ss
    }
    
}
