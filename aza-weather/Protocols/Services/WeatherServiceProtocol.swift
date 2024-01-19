//
//  WeatherServiceProtocol.swift
//  aza-weather
//
//  Created by Lerato Mokoena on 2024/01/19.
//

import Foundation

protocol WeatherServiceProtocol {
    /// Get the current weather forecast for a given city.
    func getWeather(city: String,
                    byCoordinates: Bool,
                    lat: Double,
                    long: Double,
                    completion: @escaping (WeatherResponse?) -> ())
    
    /// Get the 5 day weather forecast using zip and country code.
    func getWeatherByZipCode(zip: String,
                             country_code: String,
                             completion: @escaping (WeatherResponse?) -> ())
}
