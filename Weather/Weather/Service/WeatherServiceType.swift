//
//  WeatherServiceType.swift
//  Weather
//
//  Created by Ted on 2021/08/11.
//

import Foundation

protocol WeatherServiceType {
    
    func fetchWeather(lat: Double, lon: Double, completion: @escaping (Result<MainWeatherModel, WeatherServiceError>) -> Void)
    func fetchWeather(byCity city: String, completion: @escaping (Result<MainWeatherModel, WeatherServiceError>) -> Void)
}
