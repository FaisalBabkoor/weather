//
//  Conestant.swift
//  weather
//
//  Created by Faisal Babkoor on 4/20/18.
//  Copyright © 2018 Faisal Babkoor. All rights reserved.
//

import Foundation

let lat = Location.shared.latitude //?? 21.3891
let lon = Location.shared.latitude //?? 39.8579
let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGTITUD = "&lon="
let APP_ID = "&appid=\(KEY_ID)"
let KEY_ID = "46064674fda546a452f23ce490de5f16"


let CURRENT_WEATHER = "\(BASE_URL)\(LATITUDE)\(Location.shared.latitude!)\(LONGTITUD)\(Location.shared.longtitude!)\(APP_ID)"
let BASE_FORECAST_URL = "https://api.openweathermap.org/data/2.5/forecast/daily?"
let FORECATE_16_DAYS = "&cnt=10"

typealias DownloadComplete = () -> ()


let FORECAST_URL = "\(BASE_FORECAST_URL)\(LATITUDE)\(Location.shared.latitude!)\(LONGTITUD)\(Location.shared.longtitude!)\(FORECATE_16_DAYS)\(APP_ID)"

