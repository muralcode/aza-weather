//
//  ForecastServiceProtocol.swift
//  aza-weather
//
//  Created by Lerato Mokoena on 2024/01/19.
//

import Foundation

protocol ForecastServiceProtocol {
    /// Get the 5 day weather forecast for a given city.
    func getForecast(city: String,
                     completion: @escaping (ForecastResponse?) -> ())
    
    /// Get the 5 day weather forecast using zip and country code.
    func getForecastByZipCode(zip: String,
                              country_code: String,
                              completion: @escaping (ForecastResponse?) -> ())
}
