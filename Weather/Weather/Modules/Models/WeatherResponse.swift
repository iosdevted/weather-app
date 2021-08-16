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
    let dtTxt: String
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, wind, visibility
        case dtTxt = "dt_txt"
    }
}

struct WeatherListMainResponse: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Double
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
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
    let timezone: Int
    let population: Int?
}

struct WeatherCityCoordResponse: Codable {
    let lat: Double
    let lon: Double
}
