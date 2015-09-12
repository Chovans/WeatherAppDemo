//
//  ToastUtil.swift
//  Chovans2
//
//  Created by chovans on 15/9/8.
//  Copyright © 2015年 chovans. All rights reserved.
//

import UIKit

class ToastUtil: UIView {
    
    let context:String = "加载中"
    let backView = UIView(frame: CGRect(x: 0, y: 0, width: constant.width, height: constant.height))
    let label = UILabel(frame: CGRect(x: (constant.width-100)/2, y: (constant.height-80)/2, width: 100, height: 80))
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        backView.backgroundColor = UIColor.blackColor()
        backView.alpha = 0.5
        addSubview(backView)
        
        
        label.text = context
        label.textColor = UIColor.whiteColor()
        label.textAlignment = NSTextAlignment.Center
        label.alpha = 0.6
        label.layer.backgroundColor = UIColor.blackColor().CGColor
        label.layer.cornerRadius = 20
        label.transform = CGAffineTransformMakeScale(0, 0)
        addSubview(label)
    }
    
    func addAnimation(){
        hidden = false
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.label.transform = CGAffineTransformMakeScale(1, 1)
            }, completion: nil)
    }
    
    func removeAnimation(){
        hidden = true
        
//        UIView.animateWithDuration(0.2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
//                self.label.transform = CGAffineTransformMakeScale(0.00001, 0.00001)
//                self.label.alpha = 0.00001
//            }, completion: {(finish:Bool) -> Void in
//                self.hidden = true
//        })
        
//        UIView.animateWithDuration(2, animations: {
//            self.label.transform = CGAffineTransformMakeScale(0.1, 0.1)
//            }, completion:{(finish:Bool) -> Void in
//            self.hidden = true
//        } )
        
    }
}
