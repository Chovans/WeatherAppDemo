//
//  BaseViewController.swift
//  Chovans2
//
//  Created by chovans on 15/9/6.
//  Copyright © 2015年 chovans. All rights reserved.
//

import UIKit



class BaseViewController: UIViewController {
    
    let menuItemView:MenuItemView = MenuItemView()

    override func viewDidLoad() {
        super.viewDidLoad()
        menuItemView.itemArray[1].addTarget(self, action: Selector("trun2Weather:"), forControlEvents: .TouchDown)
        menuItemView.itemArray[2].addTarget(self, action: Selector("turn2News:"), forControlEvents: .TouchDown)
        view.addSubview(menuItemView)
        
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("menuItemShow:"))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        view.addGestureRecognizer(rightSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("menuItemHidden:"))
        leftSwipe.direction = UISwipeGestureRecognizerDirection.Left
        view.addGestureRecognizer(leftSwipe)
        
        view.addGestureRecognizer(rightSwipe)
        
//        modalPresentationStyle = UIModalPresentationStyle.Popover
        //跳转效果，未实现自定义
        modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
    
    }
    
    func menuItemShow(sender:UISwipeGestureRecognizer){
        menuItemView.showAnimation()
    }
    
    func menuItemHidden(sender:UISwipeGestureRecognizer){
        menuItemView.hideAnimation(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func trun2Weather(sender:AnyObject){
//        self.dismissViewControllerAnimated(false, completion: nil)
        self.presentViewController((storyboard?.instantiateViewControllerWithIdentifier("WeatherScene"))!, animated: true, completion: nil)
    }
 

    func turn2News(sender:AnyObject){
//        self.dismissViewControllerAnimated(false, completion: nil)
        self.presentViewController((storyboard?.instantiateViewControllerWithIdentifier("NewsScene"))!, animated: true, completion: nil)
    }
    
    
}
