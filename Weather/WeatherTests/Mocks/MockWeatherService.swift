//
//  MockWeatherService.swift
//  WeatherTests
//
//  Created by Ted on 2021/08/12.
//

import Foundation
@testable import Weather

class MockWeatherService: WeatherServiceType {
    
//    func fetchWeather(lat: Double, lon: Double, completion: @escaping (Result<MainWeatherModel, WeatherServiceError>) -> Void) {
//        handleRequest(completion: completion)
//    }
//
//
//    func fetchWeather(byCity city: String, completion: @escaping (Result<MainWeatherModel, WeatherServiceError>) -> Void) {
//        handleRequest(completion: completion)
//    }
//
//    func handleRequest(completion: @escaping (Result<MainWeatherModel, WeatherServiceError>) -> Void) {
//
//        do {
//            let result = try JSONDecoder().decode(WeatherResponse.self, from: StubData.shared.stubWeatherData())
//            completion(.success(MainWeatherModel(weatherResponse: result)!))
//        } catch {
//            completion(.failure(.decodeError))
//        }
//    }
}
