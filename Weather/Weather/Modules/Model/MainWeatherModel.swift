//
//  MainWeatherModel.swift
//  Weather
//
//  Created by Ted on 2021/08/11.
//

import Foundation

struct MainWeatherModel: Codable {
    
    var cityName: String
    var currentTemperature: String
    var currentWeatherIconName: String?
    var weatherDescription: String
    var humidity: String
    var pressure: String
    var windDirection: String
    var conditionId: Int
    
    var conditionImage: String {
        switch conditionId {
        case 200...299:
            return "thunder"
        case 300...399:
            return "cry"
        case 500...599:
            return "rain"
        case 600...699:
            return "snow"
        case 700...799:
            return "thunder" //should change to wind
        case 800:
            return "shine"
        default:
            return "shade"
        }
    }
    
    init?(weatherResponse: WeatherResponse) {
        guard let countryName = WeatherConverter.countryName(countryCode: weatherResponse.city.country),
              let currentWeather = weatherResponse.list.first,
              let weather = currentWeather.weather.first
        else {
            return nil
        }
        
        self.cityName = "\(weatherResponse.city.name), \(countryName)"
        self.currentTemperature = "\(Int(currentWeather.main.temp)) °C"
        self.humidity = "\(currentWeather.main.humidity)%"
        self.pressure = "\(currentWeather.main.pressure) hPa"
        self.windDirection = WeatherConverter.degToCompass(currentWeather.wind.deg)
        self.currentWeatherIconName = weather.icon
        self.weatherDescription = weather.description
        self.conditionId = weather.id
    }
}
