//
//  ForecastTests.swift
//  WeatheredTests
//
//  Created by Mark Struzinski on 2/24/19.
//  Copyright © 2019 BobStruzSoftware. All rights reserved.
//

import XCTest
@testable import Weathered

class ForecastItemTests: XCTestCase {
    let dataLoader = FileLoader()
    let decoder = JSONDecoder()
    
    func testValidParse() {
        let data = dataLoader.loadFile(named: "forecast-item")
        
        do {
            let forecast = try decoder.decode(ForecastItem.self, from: data)
            XCTAssertEqual(forecast.weatherType, .rain, "Weather should be rain")
            XCTAssertEqual(forecast.highTemp, 285, "High Temp should be 285")
            XCTAssertEqual(forecast.lowTemp, 285, "Low Temp should be 285")
            XCTAssertEqual(forecast.date, "Saturday", "Date should be Monday")
        } catch {
            print("Error encountered: \(error)")
            XCTFail("Invalid parse")
        }
    }
}
