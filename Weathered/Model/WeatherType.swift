//
//  WeatherType.swift
//  Weathered
//
//  Created by Mark Struzinski on 2/24/19.
//  Copyright © 2019 BobStruzSoftware. All rights reserved.
//

enum WeatherType: String, Decodable {
    case thunderstorm = "Thunderstorm"
    case drizzle = "Drizzle"
    case rain = "Rain"
    case snow = "Snow"
    case clear = "Clear"
    case clouds = "Clouds"
    case mist = "Mist"
}
