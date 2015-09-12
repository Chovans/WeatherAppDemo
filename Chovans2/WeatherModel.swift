//
//  Weather.swift
//  Chovans2
//
//  Created by chovans on 15/9/7.
//  Copyright © 2015年 chovans. All rights reserved.
//
import UIKit
import Foundation
import Alamofire
import SwiftyJSON


class WeatherModel{
    var json:JSON = []
    
    init(){
        //初始化时间
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        time = dateFormatter.stringFromDate(NSDate())
    }
    
    var area = NSUserDefaults.standardUserDefaults().valueForKey("defauleArea") as? String
    var time = "00:00"
    var weatherType = ""
    var highest = ""
    var lowest = ""
    var tempture = ""
    var isLoad = false
    
    func getWeather(lon:Double,lat:Double){
        
        if isLoad{
            return
        }
        
        isLoad = true
        
        let params = [
            "lon":lon,
            "lat":lat,
            "format":2,
            "dtype":"json",
            "key":weatherPropeties.key
        ]
        
        request(.GET, weatherPropeties.url, parameters: params as? [String : AnyObject], encoding: .URL, headers: nil).response { (_request, _response, _data, _error) -> Void in
            if let error = _error{
                print(error)
                return
            }
            self.json = JSON(data: _data!)
            self.fullValue()
            
        }
        
    }
    
    func fullValue(){
        if json["resultcode"].intValue != 200{
            weatherType = ""
            highest = "0°"
            lowest = "0°"
            tempture = "0°"
        }else if json["resultcode"].intValue == 200{
            
            MemoryData.weatherData = json
            
            area = json["result"]["today"]["city"].stringValue
            weatherType = json["result"]["today"]["weather"].stringValue
            let temperture = json["result"]["today"]["temperature"].stringValue
            tempture = temperture.componentsSeparatedByString("~")[0]
            highest = temperture.componentsSeparatedByString("~")[0]
            lowest = temperture.componentsSeparatedByString("~")[1]
        }
    }
}