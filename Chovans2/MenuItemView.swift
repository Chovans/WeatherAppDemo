//
//  MenuItemView.swift
//  Chovans2
//
//  Created by chovans on 15/9/6.
//  Copyright © 2015年 chovans. All rights reserved.
//

import UIKit

class MenuItemView: UIView {
    
    let menuItem = [
        (0,"X","menu.cancle","storyBoardId"),
        (1,"天气","menu.weather","storyBoardId"),
        (2,"新闻","menu.news","storyBoardId"),
        (3,"天气","menu.weather","storyBoardId"),
        (4,"新闻","menu.news","storyBoardId"),
        (5,"天气","menu.weather","storyBoardId"),
        (6,"新闻","menu.news","storyBoardId")]
    
    var itemArray = [UIButton]()
    
    //最大宽度和高度
    let maxSize = constant.width / 5
    
    //菜单背景色
    let menuBackgroundColor:UIColor = UIColor.purpleColor()
    //菜单中间色
    let menuLineColor:UIColor = UIColor.whiteColor()
    //菜单文字颜色
    let menuTextColor:UIColor = UIColor.whiteColor()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        //根据屏幕大小自适应菜单大小
        super.init(frame: CGRect(x: 0, y: 20, width: maxSize, height: maxSize * CGFloat(menuItem.count)))
        //加载菜单
        loadMenu()
//        hideAnimation(self)
    }
    
    func loadMenu(){
        for (idx,_,img,_) in menuItem{
            if(img != ""){
                let button = UIButton(frame: CGRect(x: 0, y: CGFloat(idx) * maxSize + CGFloat(idx), width: maxSize, height: maxSize))
                button.setImage(UIImage(named: img), forState: .Normal)
                button.backgroundColor = menuBackgroundColor
                addSubview(button)
                itemArray += [button]
            }
        }
        
        itemArray[0].addTarget(self, action: Selector("hideAnimation:"), forControlEvents: .TouchDown)
    }

    
    func showAnimation(){
        //取消隐藏
        hidden = false
        showAndHide(0, alpha: 1)
    }
    
    func hideAnimation(sender:AnyObject){
        showAndHide(-self.maxSize, alpha: 0)
    }
    
    func showAndHide(direction:CGFloat,alpha:CGFloat){
        for var idx = itemArray.count-1 ; idx >= 0 ; --idx{
            let thisView = itemArray[idx]

            UIView.animateWithDuration(0.5, delay: NSTimeInterval(Double(idx.description)! * 0.1) , options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                thisView.transform = CGAffineTransformMakeTranslation(direction,0)
                thisView.alpha = alpha
                
                }, completion:{finesh -> Void in
                    //需要隐藏，防止view移出的view遮挡住下层
                    if(direction < 0){
                        self.hidden = true
                    }
            })
        }

    }
    

}
