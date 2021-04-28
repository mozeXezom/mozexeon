//
//  ViewController.swift
//  mozexeon
//
//  Created by mozeX on 26.04.2021.
//

import UIKit
import Foundation
import CoreLocation

class MozexeonViewController: UIViewController {
    
    //MARK: - Labels
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var celsiumLabel: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var collectionLabel: UILabel!
    @IBOutlet weak var condLabel: UIImageView!
    @IBOutlet weak var searchLabel: UITextField!
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        searchLabel.delegate = self
        
    }
}
    extension MozexeonViewController: UITextFieldDelegate {
        
        @IBAction func searchPressed(_ sender: UIButton) {
            searchLabel.endEditing(true)
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            searchLabel.endEditing(true)
            return true
        }
        
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            if textField.text != "" {
                return true
            } else {
                textField.placeholder = "Type something"
                return false
            }
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            if let city = searchLabel.text {
                weatherManager.fetchWeather(cityName: city)
            }
            
            searchLabel.text = ""
        }
    }

//MARK: - WeatherManagerDelegate

extension MozexeonViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.numberLabel.text = weather.tempString
            self.condLabel.image = UIImage(systemName: weather.condName)
            self.cityName.text = weather.cityName
            self.feelsLikeLabel.text = weather.feelsString
        }
    }
    func didFailError(error: Error) {
        print(error)
    }
}

//MARK: - CLLocationManagerDelegate

extension MozexeonViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeatherLocation(latitude: lat, longitude: lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
