//
//  ForecastTests.swift
//  WeatheredTests
//
//  Created by Mark Struzinski on 2/25/19.
//  Copyright © 2019 BobStruzSoftware. All rights reserved.
//

import XCTest
@testable import Weathered

class ForecastTests: XCTestCase {
    let dataLoader = FileLoader()
    let decoder = JSONDecoder()
    
    func testValidParse() {
        let data = dataLoader.loadFile(named: "forecast")
        
        do {
            let forecast = try decoder.decode(Forecast.self, from: data)
            XCTAssertEqual(forecast.forecastList.count, 8, "There should be 8 forecast items in the list")
        } catch {
            print("Error encountered: \(error)")
            XCTFail("Invalid parse")
        }
    }
}
