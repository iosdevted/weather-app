//
//  MockWeatherServiceWithoutNetwork.swift
//  WeatherTests
//
//  Created by Ted on 2021/08/12.
//

import Foundation
@testable import Weather

class MockWeatherServiceWithoutNetwork: WeatherServiceType {
    func fetchWeather(lat: Double, lon: Double, completion: @escaping (Result<WeatherResponse, WeatherServiceError>) -> Void) {
        handleRequest(completion: completion)
    }
    
    func fetchWeather(byCity city: String, completion: @escaping (Result<WeatherResponse, WeatherServiceError>) -> Void) {
        handleRequest(completion: completion)
    }

    func handleRequest(completion: @escaping (Result<WeatherResponse, WeatherServiceError>) -> Void) {

        do {
            let result = try JSONDecoder().decode(WeatherResponse.self, from: StubData.shared.stubWeatherData())
            completion(.success(result))
        } catch {
            completion(.failure(.decodeError))
        }
    }
}
