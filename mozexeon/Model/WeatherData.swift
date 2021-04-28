//
//  WeatherData.swift
//  mozexeon
//
//  Created by mozeX on 28.04.2021.
//

import Foundation
import UIKit
import CoreLocation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}

struct Wind: Codable {
    let speed: Double
}
