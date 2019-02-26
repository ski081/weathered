//
//  Forecast.swift
//  Weathered
//
//  Created by Mark Struzinski on 1/29/19.
//  Copyright © 2019 BobStruzSoftware. All rights reserved.
//

import Foundation

struct ForecastItem: Decodable {
    let date: String
    let weatherType: WeatherType
    let highTemp: Int
    let lowTemp: Int

    enum CodingKeys: String, CodingKey {
        case weather
        case temp
        case dt
    }
    
    init(from decoder: Decoder) throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
    
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let weatherList = try container.decode([Weather].self, forKey: .weather)
        guard let firstWeather = weatherList.first else {
            throw DecodingError.invalidParse
        }
        
        let temp = try container.decode(Temperature.self, forKey: .temp)
        let highTemp = Int(temp.max)
        let lowTemp = Int(temp.min)
        let dateValue = try container.decode(Double.self, forKey: .dt)
        let unixDate = Date(timeIntervalSince1970: dateValue)
        let dateString = unixDate.dayOfTheWeek()
        
        self.weatherType = firstWeather.weatherType
        self.highTemp = highTemp
        self.lowTemp = lowTemp
        self.date = dateString
    }
}
