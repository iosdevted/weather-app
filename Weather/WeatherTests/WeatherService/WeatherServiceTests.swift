//
//  WeatherServiceTests.swift
//  WeatherTests
//
//  Created by Ted on 2021/08/12.
//

import XCTest
@testable import Weather

class WeatherServiceTests: XCTestCase {
    
    var mockWeatherServiceWithoutNetwork: MockWeatherServiceWithoutNetwork?
    var mockWeatherService: MockWeatherService?

    override func setUpWithError() throws {
        self.mockWeatherServiceWithoutNetwork = MockWeatherServiceWithoutNetwork()
        self.mockWeatherService = MockWeatherService()
    }

    override func tearDownWithError() throws {
        self.mockWeatherServiceWithoutNetwork = nil
        self.mockWeatherService = nil
    }

    func testFetchWeather_WhenJSONFileProvided_ShouldReturnTrue() throws {
        
        mockWeatherServiceWithoutNetwork?.fetchWeather(byCity: "", completion: { result in
            switch result {
            case .success(let data):
                XCTAssert(data.cod == "200", "Expect created cod is 200")
                XCTAssert(data.message == 0, "Expect created message is 0")
                XCTAssert(data.cnt == 40, "Expect created cnt is 40")
                XCTAssert(data.city.id == 2988507, "Expect created city id is 2988507")
                XCTAssert(data.city.name == "Paris", "Expect created city name is Paris")
                XCTAssert(data.city.coord.lat == 48.8534, "Expect created latitude is 48.8534")
                XCTAssert(data.list.first?.dt == 1628694000, "Expect created dt is 1628694000")
                
                guard let main = data.list.first?.main else { return }
                XCTAssert(main.feelsLike == 26.09, "Expect created feelsLike is 26.09")
                XCTAssert(main.temp == 26.09, "Expect created temp is 26.09")
                XCTAssert(main.pressure == 1019, "Expect created pressure is 1019")
                XCTAssert(main.tempMin == 26.09, "Expect created pressure is 26.09")
                XCTAssert(main.tempMax == 27.42, "Expect created pressure is 27.42")
                
                guard let weather = data.list.first?.weather else { return }
                
                XCTAssert(weather.first?.id == 801, "Expect created weather id is 801")
                XCTAssert(weather.first?.main == "Clouds", "Expect created weather main is Clouds")
                XCTAssert(weather.first?.description == "few clouds", "Expect created weather description is few clouds")
                
                guard let wind = data.list.first?.wind else { return }
                
                XCTAssert(wind.speed == 0.58, "Expect created wind speed is 0.58")
                XCTAssert(wind.deg == 336, "Expect created wind degree is 336")
                
            case .failure:
                break
            }
        })
    }
    
    func testFetchWeatherByLocation_WhenLocationProvided_ShouldReturnTrue() throws {
        let weatherExpectation: XCTestExpectation = self.expectation(description: "weatherExpectation")
        
        mockWeatherService?.fetchWeather(lat: 32.832942, lon: -0.293174, completion: { result in
            switch result {
            case .success:
                weatherExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        })
        XCTAssert(mockWeatherService?.fetchWeatherByLotLon == 1, "Expect fetchWeatherByLotLon is 1")
        self.waitForExpectations(timeout: 20.0, handler: nil)
    }
    
    func testFetchWeatherByCityName_WhenCityNameProvided_ShouldReturnTrue() throws {
        let weatherExpectation: XCTestExpectation = self.expectation(description: "weatherExpectation")
        
        mockWeatherService?.fetchWeather(byCity: "Paris", completion: { result in
            switch result {
            case .success:
                weatherExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        })
        XCTAssert(mockWeatherService?.fetchWeatherByCityCalled == 1, "Expect fetchWeatherByCityCalled is 1")
        self.waitForExpectations(timeout: 20.0, handler: nil)
    }
}
