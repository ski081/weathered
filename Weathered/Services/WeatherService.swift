//
//  WeatherService.swift
//  Weathered
//
//  Created by Mark Struzinski on 1/24/19.
//  Copyright © 2019 BobStruzSoftware. All rights reserved.
//

import Foundation
import Alamofire

class WeatherService {
    static let instance = WeatherService()
    var currentWeather: CurrentWeather?
    var forecast: [ForecastItem] = []
    
    func downloadWeatherDetails(completion: @escaping DownloadComplete) {
        let url = URL(string: apiURLCurrentWeather)!
        Alamofire.request(url).responseData { response in
            print(response.result.value ?? "")
            let decoder = JSONDecoder()
            let weather = try? decoder.decode(CurrentWeather.self,
                                         from: response.data!)
            self.currentWeather = weather
            
            completion()
        }
    }
    
    func downloadForecast(completion: @escaping DownloadComplete) {
        let url = URL(string: apiURLForecast)!
        Alamofire.request(url).responseData { response in
            let decoder = JSONDecoder()
            
            do {
                let forecast = try decoder.decode(Forecast.self, from: response.data!)
                guard !forecast.forecastList.isEmpty else {
                    return
                }
                
                let slice = forecast.forecastList.dropFirst()
                let forecastList = Array(slice)
                self.forecast = forecastList
                
                completion()
            } catch {
                print("\(error)")
            }
        }
    }
}
