//
//  NewsViewController.swift
//  Chovans2
//
//  Created by chovans on 15/9/8.
//  Copyright © 2015年 chovans. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewsViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var newsToolBar: UIBarButtonItem!
    @IBOutlet weak var articleToolBar: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    
    var data:JSON = JSON([])
    var type = "新闻"
    var pageNo = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsToolBar.width = (constant.width-40) / 2
        articleToolBar.width = (constant.width-40) / 2
        tableView.delegate = self
        tableView.dataSource = self
        requestData(type)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        menuItemView.hideAnimation(self)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        (cell.viewWithTag(1) as! UILabel).text = data[indexPath.row]["title"].string
        return cell
    }
    
    @IBAction func newsAction(sender: UIBarButtonItem) {
        type = "新闻"
        requestData(type)
    }
    
    @IBAction func articleAction(sender: UIBarButtonItem) {
        type = "文章"
        requestData(type)
    }
    
    func requestData(type:String){
        
        if self.type == type {
            pageNo++
        }else{
            self.type = type
            pageNo = 1
        }
        
        let paramters = ["pageNo":pageNo,"pageSize":20]
        
        request(.GET, constant.newsUrl , parameters: paramters, encoding: .URL, headers: nil).response { (_request, _response, _data, _error) -> Void in
            if let error = _error{
                print(error)
                return
            }
            self.data = JSON(data: _data!)["data"]["news"]
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detailView = segue.destinationViewController as! NewsDetailViewController
        let cell = sender as! UITableViewCell
        let index:NSIndexPath = tableView.indexPathForCell(cell)!
        let id = data[index.row]["id"].string
        detailView.id = id!
    }
    
}
