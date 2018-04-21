//
//  WeatherCell.swift
//  weather
//
//  Created by Faisal Babkoor on 4/20/18.
//  Copyright © 2018 Faisal Babkoor. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var thumImage: UIImageView!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var weatherLbl: UILabel!
    @IBOutlet weak var heightTempLbl: UILabel!
    @IBOutlet weak var lowTempLbl: UILabel!
    
    func updateUI(forecaste: Forecaste){
        self.dayLbl.text = forecaste.date
        self.weatherLbl.text = forecaste.weatherType
        self.thumImage.image = UIImage(named: (forecaste.weatherType ))
        self.heightTempLbl.text = forecaste.hightTemp
        self.lowTempLbl.text = forecaste.lowTemp
    }
}
