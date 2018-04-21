//
//  CurrentWeather.swift
//  weather
//
//  Created by Faisal Babkoor on 4/20/18.
//  Copyright © 2018 Faisal Babkoor. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather{
//    static var instant = CurrentWeather()
//    init(){}
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    
    var cityName: String{
        if _cityName == nil{
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String{
        if _date == nil {
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .long
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today\(currentDate)"
        return _date
    }
    
    var weaherType: String{
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double{
        if _currentTemp == nil{
            _currentTemp = -0
        }
        return _currentTemp
    }
    
    func downloadinData(complitionHandler: @escaping DownloadComplete){
        Alamofire.request(CURRENT_WEATHER).responseJSON { (response) in
            let resulte = response.result
            
            if let dict = resulte.value as? Dictionary<String,Any>{
                if let name = dict["name"] as? String{
                    self._cityName = name.capitalized
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, Any>]{
                    if let main = weather[0]["main"] as? String{
                        self._weatherType = main.capitalized
                        print(self._weatherType)
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, Any>{
                    if var temp = main["temp"] as? Double{
                        temp = round(temp - 273.15)
                        self._currentTemp = temp
                        print(self._currentTemp)
                    }
                }
            }
            complitionHandler()

        }
    }
    
}
