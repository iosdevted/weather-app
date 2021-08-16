//
//  MockWeatherService.swift
//  WeatherTests
//
//  Created by Ted on 2021/08/16.
//

import XCTest
@testable import Weather

class MockWeatherService: WeatherService {
    
    var fetchWeatherByCityCalled = 0
    var fetchWeatherByLotLon = 0

    override func fetchWeather(byCity city: String, completion: @escaping (Result<WeatherResponse, WeatherServiceError>) -> Void) {
        self.fetchWeatherByCityCalled += 1
        super.fetchWeather(byCity: city, completion: completion)
    }
    
    override func fetchWeather(lat: Double, lon: Double, completion: @escaping (Result<WeatherResponse, WeatherServiceError>) -> Void) {
        self.fetchWeatherByLotLon += 1
        super.fetchWeather(lat: lat, lon: lon, completion: completion)
    }
}
