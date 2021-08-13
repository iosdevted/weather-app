//
//  WeatherResponse.swift
//  Weather
//
//  Created by Ted on 2021/08/11.
//

import UIKit

struct WeatherResponse: Codable {
    let cod: String
    let message: Double
    let cnt: UInt
    let list: [WeatherListResponse]
    let city: WeatherCityResponse
}

struct WeatherListResponse: Codable {
    let dt: Double
    let main: WeatherListMainResponse
    let weather: [WeatherListWeatherResponse]
    let wind: WeatherListWindResponse
    let visibility: Int
    let dt_txt: String
}

struct WeatherListMainResponse: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double
    let sea_level: Double
    let grnd_level: Double
    let humidity: Int
    let temp_kf: Double
}

struct WeatherListWeatherResponse: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct WeatherListWindResponse: Codable {
    let speed: Double
    let deg: Double
}

struct WeatherCityResponse: Codable {
    let id: Int
    let name: String
    let coord: WeatherCityCoordResponse
    let country: String
    let population: Int?
}

struct WeatherCityCoordResponse: Codable {
    let lat: Double
    let lon: Double
}
