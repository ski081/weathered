//
//  CurrentWeatherTests.swift
//  WeatheredTests
//
//  Created by Mark Struzinski on 2/23/19.
//  Copyright © 2019 BobStruzSoftware. All rights reserved.
//

import XCTest
@testable import Weathered

class CurrentWeatherTests: XCTestCase {
    let dataLoader = FileLoader()
    let decoder = JSONDecoder()
    
    func testValidParse() {
        let data = dataLoader.loadFile(named: "current-weather")
        
        do {
            let currentWeather = try decoder.decode(CurrentWeather.self, from: data)
            XCTAssertEqual(currentWeather.cityName, "Shuzenji", "City name should match")
            XCTAssertEqual(currentWeather.weatherType, .clouds, "Weather should be clouds")
            XCTAssertEqual(currentWeather.currentTemp, 282, "Temp should be 282")
        } catch {
            print("Error encountered: \(error)")
            XCTFail("Invalid parse")
        }
    }
}
