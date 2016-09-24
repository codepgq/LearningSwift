//
//  ViewController.swift
//  ListenKeyboard
//
//  Created by ios on 16/9/24.
//  Copyright © 2016年 ios. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var toolBarConstraints: NSLayoutConstraint!
    
    @IBOutlet weak var toobar: UIToolbar!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textCount: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        UIKeyboardWillHideNotification          将要隐藏
        UIKeyboardWillShowNotification          将要显示
        UIKeyboardDidChangeFrameNotification    已经修改frame
        UIKeyboardWillChangeFrameNotification   将要修改frame
        UIKeyboardDidHideNotification           已经隐藏
        UIKeyboardDidShowNotification           已经显示
         */
        
        /*
         UIKeyboardFrameBeginUserInfoKey        Rect
         UIKeyboardFrameEndUserInfoKey          Rect
         UIKeyboardAnimationDurationUserInfoKey 动画时长
         UIKeyboardAnimationCurveUserInfoKey    动画Options
         UIKeyboardIsLocalUserInfoKey           NSNumber of BOOL
         */
        
        /**
         监听键盘将要出现通知
         */
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification , object: nil)
        /**
         监听键盘将要隐藏通知
         */
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification , object: nil)
        
        /**
         设置textView的背景颜色
         
         - parameter white: 白色 0表示黑色 1表示白色
         - parameter alpha: 透明度
         */
        textView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        /**
         代理
         */
        textView.delegate = self
    }
    
    /**
     点击取消
     
     - parameter sender: 取消
     */
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    /**
     点击其他的地方取消键盘编辑
     
     - parameter touches:
     - parameter event:
     */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }

    /**
     键盘将要显示
     
     - parameter note: 通知
     */
    @objc private func keyboardWillShow(note:NSNotification){
        //获取信息
        let userInfo = note.userInfo
        //得到rect
        let endRect = (userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        //得到动画时长
        let duration = (userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        //开始动画
        UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions(rawValue: UInt((userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).integerValue << 16)), animations: { 
            self.toolBarConstraints.constant = endRect.height
            self.toobar.layoutIfNeeded()
            }, completion: nil)
    }
    /**
     键盘将要隐藏
     
     - parameter note: 通知
     */
    @objc private func keyboardWillHide(note:NSNotification){
        let userInfo = note.userInfo
        let duration = (userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        UIView.animateWithDuration(duration, delay: 0, options: [], animations: {
            self.toolBarConstraints.constant = 0
            self.toobar.layoutIfNeeded()
            }, completion: nil)
    }
}

//***********************     textView代理      *****************
extension ViewController{
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool{
        let text = textView.text as NSString
        if text.length >= 140 {
            textView.text = text.substringToIndex(140)
        }
        textCount.title = "\(140 - text.length)"
        //如果这里返回false，textView就不能编辑啦！
        return true
    }
}

