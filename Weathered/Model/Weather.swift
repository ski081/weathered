//
//  Weather.swift
//  Weathered
//
//  Created by Mark Struzinski on 2/24/19.
//  Copyright © 2019 BobStruzSoftware. All rights reserved.
//

struct Weather: Decodable {
    let weatherType: WeatherType
    
    enum CodingKeys: String, CodingKey {
        case weatherType = "main"
    }
}
