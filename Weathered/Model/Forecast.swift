//
//  Forecast.swift
//  Weathered
//
//  Created by Mark Struzinski on 2/24/19.
//  Copyright © 2019 BobStruzSoftware. All rights reserved.
//

struct Forecast: Decodable {
    let forecastList: [ForecastItem]
    
    enum CodingKeys: String, CodingKey {
        case forecastList = "list"
    }
}
