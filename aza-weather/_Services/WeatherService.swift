//
//  WeatherService.swift
//  aza-weather
//
//  Created by Lerato Mokoena on 2024/01/19.
//

import Foundation
import SwiftUI

class WeatherService: WeatherServiceProtocol {
    /// Get the current weather forecast for a given city.
    func getWeather(city: String, byCoordinates: Bool, lat: Double, long: Double, completion: @escaping (WeatherResponse?) -> ()) {
        
        let coordsUrl = Constants.coordsUrl + "lat=\(lat)&lon=\(long)" + "&appid=\(Constants.APIKey)" + "&units=metric"
        let cityUrl = Constants.cityUrl + "q=\(city)" + "&appid=\(Constants.APIKey)" + "&units=metric"
        
        guard let url = byCoordinates ? URL(string: coordsUrl) : URL(string: cityUrl) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)

            if let weatherResponse = weatherResponse {
                let weatherData = weatherResponse
                completion(weatherData)

            } else {
                completion(nil)
            }

        }.resume()
    }
    
    /// Get the 5 day weather forecast using zip and country code.
    func getWeatherByZipCode(zip: String, country_code: String, completion: @escaping (WeatherResponse?) -> ()) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?zip=\(zip),\(country_code)&appid=209ffe164b311f49f5b7dcdb8423c832&units=metric") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
            
            if let weatherResponse = weatherResponse {
                let weatherData = weatherResponse
                completion(weatherData)
                
            } else {
                completion(nil)
            }
            
        }.resume()
    }
}
