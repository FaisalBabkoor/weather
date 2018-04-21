//
//  Location.swift
//  weather
//
//  Created by Faisal Babkoor on 4/21/18.
//  Copyright © 2018 Faisal Babkoor. All rights reserved.
//

import CoreLocation

class Location{
    static var shared = Location()
    
     init() {}
    
    var latitude: Double!
    var longtitude: Double!
}
