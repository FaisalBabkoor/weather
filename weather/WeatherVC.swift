//
//  ViewController.swift
//  weather
//
//  Created by Faisal Babkoor on 4/20/18.
//  Copyright © 2018 Faisal Babkoor. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var weatherDetailLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var tabelView: UITableView!
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    var forecaste: Forecaste!
    var forecastes = [Forecaste]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()

        tabelView.delegate = self
        tabelView.dataSource = self
        
        currentWeather = CurrentWeather()
        print("viewDidLoad")
    }
    override func viewDidAppear(_ animated: Bool) {
        AuthorizationSetUp()
        print(FORECAST_URL)

    }

    
    func AuthorizationSetUp(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways{
            guard let location = locationManager.location else{return}
            currentLocation = location
            Location.shared.latitude = currentLocation.coordinate.latitude
            Location.shared.longtitude = currentLocation.coordinate.longitude
            currentWeather.downloadinData {
                self.downloadForecastData(completed: {
                    self.updateUI()
                    print(self.forecastes)
                })
            }
            
           
        } else {
            locationManager.requestWhenInUseAuthorization()
            AuthorizationSetUp()
        }
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        print(FORECAST_URL)

        Alamofire.request(FORECAST_URL).responseJSON { (rsponse) in
            print(FORECAST_URL)

            let result = rsponse.result
            
            if let dict = result.value as? Dictionary<String, Any>{
                if let list = dict["list"] as? [Dictionary<String, Any>]{
                    for obj in list{
                        print(obj)
                        let forecate = Forecaste(weatherDict: obj)
                        self.forecastes.append(forecate)
                    }
                    self.forecastes.remove(at: 0)
                    self.tabelView.reloadData()
                }
            }
            completed()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? WeatherCell{
            cell.updateUI(forecaste: forecastes[indexPath.row])
            return cell
        }else{
            return UITableViewCell()
        }
    }

    func updateUI(){
        self.cityLbl.text = currentWeather.cityName
        self.tempLbl.text = "\(currentWeather.currentTemp)"
        self.dateLbl.text = currentWeather.date
        self.weatherDetailLbl.text = currentWeather.weaherType
        self.imagePreview.image = UIImage(named: (currentWeather.weaherType))
    }


}

