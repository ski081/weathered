//
//  CurrentWeather.swift
//  Weathered
//
//  Created by Mark Struzinski on 1/26/19.
//  Copyright © 2019 BobStruzSoftware. All rights reserved.
//

import Foundation

struct CurrentWeather: Decodable {
    let cityName: String
    let weatherType: WeatherType
    let date: String
    var currentTemp: Int
    
    enum CodingKeys: String, CodingKey {
        case cityName = "name"
        case weather
        case main
    }
    
    enum ConditionsCodingKeys: String, CodingKey {
        case temp
    }
    
    init(from decoder: Decoder) throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())

        let container = try decoder.container(keyedBy: CodingKeys.self)
        let cityName = try container.decode(String.self, forKey: .cityName)
        let weatherList = try container.decode([Weather].self, forKey: .weather)
        let mainContainer = try container.nestedContainer(keyedBy: ConditionsCodingKeys.self, forKey: .main)
        let temp = try mainContainer.decode(Double.self, forKey: .temp)
        let currentTemp = Int(temp)
        
        guard let firstWeather = weatherList.first else {
            throw DecodingError.invalidParse
        }
        
        self.cityName = cityName
        self.weatherType = firstWeather.weatherType
        
        self.date = currentDate
        self.currentTemp = currentTemp
    }
}
