//
//  Forecaste.swift
//  weather
//
//  Created by Faisal Babkoor on 4/20/18.
//  Copyright © 2018 Faisal Babkoor. All rights reserved.
//

import UIKit
class Forecaste{
    var _date: String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp: String!
    
    var date: String{
        if _date == nil{
            _date = ""
        }
        return _date
    }
    
    var weatherType: String{
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    var hightTemp: String{
        if _highTemp == nil {
            _highTemp = ""
        }
        return _highTemp
    }
    
    var lowTemp: String{
        if _lowTemp == nil{
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    
    
    init(weatherDict: Dictionary<String, Any>) {
        if let dt = weatherDict["dt"] as? Double{
            let unixConvertedDate = Date(timeIntervalSince1970: dt)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeek()
        }
        if let temp = weatherDict["temp"] as? Dictionary<String, Any>{
            if var max = temp["max"] as? Double{
                max = round(max - 273.15)
                self._highTemp = "\(max)"
            }
            if var min = temp["min"] as? Double{
                min = round(min - 273.15)
                self._lowTemp = "\(min)"
            }
        }
        if let weather = weatherDict["weather"] as? [Dictionary<String, Any>]{
            if let main = weather[0]["main"] as? String{
                self._weatherType = main
            }
        }
    }
    
    
   
    
    
    
    
    
    
    
    
    
    
}
extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}



