//
//  WeatherModel.swift
//  aza-weather
//
//  Created by Lerato Mokoena on 2024/01/19.
//

import Foundation

/// The weather response structure.
struct WeatherResponse: Codable {
    var name: String
    var dt: Int
    var timezone: Int
    var main: Main
    var wind: Wind
    var weather: [Weather]
    var sys: Sys
}

/// The 'main' weather object in the API response.
struct Main: Codable {
    var temp: Double?
    var humidity: Double?
    var temp_min: Double?
    var temp_max: Double?
    var pressure: Int?
    var feels_like: Double?
}

/// The 'wind' object in the API response.
struct Wind: Codable {
    var speed: Double?
}

/// The 'weather' object in the API response.
struct Weather: Codable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}

/// The 'sys' object in the API response.
struct Sys: Codable {
    var country: String?
    var sunrise: Int?
    var sunset: Int?
}
