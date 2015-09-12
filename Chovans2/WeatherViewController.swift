//
//  WeatherViewController.swift
//  Chovans2
//
//  Created by chovans on 15/9/6.
//  Copyright © 2015年 chovans. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreLocation


class WeatherViewController: BaseViewController, CLLocationManagerDelegate,UIAlertViewDelegate{
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var templatureLabel: UILabel!
    @IBOutlet weak var highestLabel: UILabel!
    @IBOutlet weak var lowestLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    
    let locationManager:CLLocationManager = CLLocationManager()
    let weatherModel:WeatherModel = WeatherModel()
    let toastView:ToastUtil = ToastUtil()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置定位参数
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        view.addSubview(toastView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if  (MemoryData.weatherData == JSON([])) {
            startOrRefresh()
        }else{
            weatherModel.json = MemoryData.weatherData
            weatherModel.fullValue()
            self.fullValue()
        }
        
    }
    
    func startOrRefresh(){
        //页面显示时开始定位
        locationManager.startUpdatingLocation()
        //隐藏菜单
        menuItemView.hideAnimation(self)
        
        toastView.addAnimation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func showMenu(sender: UIButton) {
        menuItemView.showAnimation()
    }
    
    @IBAction func moreButton(sender: UIButton) {
        weatherModel.isLoad = false
        startOrRefresh()
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //网络请求未返回时不断刷新
        if(!weatherModel.isLoad && locations.count > 0){
            let location = locations[locations.count-1]
            weatherModel.getWeather(location.coordinate.longitude, lat: location.coordinate.latitude)
        }
        
        //网络请求返回时，停止刷新，并开始设置值
        if(weatherModel.isLoad && weatherModel.weatherType != ""){
            locationManager.stopUpdatingLocation()
            fullValue()
        }
        
    }
    
    func fullValue(){
        self.cityLabel.text = weatherModel.area
        self.timeLabel.text = weatherModel.time
        self.weatherLabel.text = weatherModel.weatherType
        self.highestLabel.text = weatherModel.highest
        self.lowestLabel.text = weatherModel.lowest
        self.templatureLabel.text = weatherModel.tempture
        
        toastView.removeAnimation()

    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        //        UIAlertView(title: "定位失败", message: "定位失败，请检查网络", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确定").show()
        NSLog(error.description)
        toastView.removeAnimation()
    }
    
}
