//
//  WeatherServiceTests.swift
//  WeatherTests
//
//  Created by Ted on 2021/08/12.
//

import XCTest
@testable import Weather

class WeatherServiceTests: XCTestCase {
    
    var mockWeatherService: MockWeatherService?

    override func setUpWithError() throws {
        self.mockWeatherService = MockWeatherService()
    }

    override func tearDownWithError() throws {
        self.mockWeatherService = nil
    }

    func testFetchWeather_WhenJSONFileProvided_ShouldReturnTrue() throws {
        
        mockWeatherService?.fetchWeather(byCity: "", completion: { result in
            switch result {
            case .success(let data):
                XCTAssert(data.cityName == "Paris, France", "Expect created cityName is Paris, France")
                XCTAssert(data.currentTemperature == "21 °C", "Expect created currentTemperature is 21 °C")
                XCTAssert(data.weatherDescription == "clear sky", "Expect created weatherDescription is clear sky")
                XCTAssert(data.humidity == "71%", "Expect created humidity is 71%")
                XCTAssert(data.pressure == "1019.0 hPa", "Expect created pressure is 1019.0 hPa")
                XCTAssert(data.windDirection == "NE", "Expect created windDirection is NE")
                XCTAssert(data.conditionId == 800, "Expect created conditionId is 800")
                
            case .failure:
                break
            }
        })
    }
}
