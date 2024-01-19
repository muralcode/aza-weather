//
//  ForecastService.swift
//  aza-weather
//
//  Created by Lerato Mokoena on 2024/01/19.
//

import Foundation

class ForecastService: ForecastServiceProtocol {
    /// Get the 5 day weather forecast for a given city.
    func getForecast(city: String, completion: @escaping (ForecastResponse?) -> ()) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=209ffe164b311f49f5b7dcdb8423c832&units=metric") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let forecastResponse = try? JSONDecoder().decode(ForecastResponse.self, from: data)
            
            if let forecastResponse = forecastResponse {
                let forecastData = forecastResponse
                completion(forecastData)
                
            } else {
                completion(nil)
            }
            
        }.resume()
    }
    
    /// Get the 5 day weather forecast using zip and country code.
    func getForecastByZipCode(zip: String, country_code: String, completion: @escaping (ForecastResponse?) -> ()) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?zip=\(zip),\(country_code)&appid=209ffe164b311f49f5b7dcdb8423c832&units=metric") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let forecastResponse = try? JSONDecoder().decode(ForecastResponse.self, from: data)
            
            if let forecastResponse = forecastResponse {
                let forecastData = forecastResponse
                completion(forecastData)
                
            } else {
                completion(nil)
            }
            
        }.resume()
    }
}
