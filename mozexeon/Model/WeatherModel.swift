//
//  WeatherModel.swift
//  mozexeon
//
//  Created by mozeX on 28.04.2021.
//

import Foundation
import UIKit

struct WeatherModel {
    let condID: Int
    let cityName: String
    let temperature: Double
    let feelsLike: Double
    
    var tempString: String {
        return String(format: "%.1f", temperature)
    }
    var feelsString: String {
        return String(format: "%.1f", feelsLike)
    }
    
    var condName: String {
        switch condID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 700...785:
            return "cloud fog"
        case 800:
            return "sun.max"
        default:
            return "cloud"
        }
    }
    
}
