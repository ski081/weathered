//
//  Constants.swift
//  Weathered
//
//  Created by Mark Struzinski on 1/24/19.
//  Copyright © 2019 BobStruzSoftware. All rights reserved.
//

import Foundation

typealias DownloadComplete = () -> Void

let apiKey = "&appid=8453c3d34c60a2d2b811423d171335b7"
let apiUnits = "&units=imperial"
let apiURLCurrentWeather = "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)\(apiUnits)\(apiKey)"
let apiURLForecast = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(latitude)&lon=\(longitude)&cnt=8\(apiUnits)\(apiKey)"
let apiHomepageURL = URL(string: "https://openweathermap.org")!
let longitude = Location.instance.longitude
let latitude = Location.instance.latitude

extension Notification.Name {
    struct Download {
        static let downloadComplete = NSNotification.Name(rawValue: "DownloadComplete")
    }
}
