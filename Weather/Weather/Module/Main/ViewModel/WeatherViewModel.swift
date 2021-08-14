//
//  WeatherModel.swift
//  Weather
//
//  Created by Ted on 2021/08/13.
//

import Foundation

struct WeatherViewModel {
    
    let cityName: String
    let date: String
    let hour: String
    let day: String
    let temp: String
    let tempOriginal: String
    let tempMinInt: Int
    let tempMaxInt: Int
    let tempMin: String
    let tempMax: String
    let description: String
    let feelslike: String
    let humidity: String
    let pressure: String
    let windSpeed: String
    let windDirection: String
    let visibility: String
    let conditionId: Int
    
    var conditionImage: String {
        switch conditionId {
        case 200...299:
            return "thunderstorms"
        case 300...399:
            return "drizzling"
        case 500...599:
            return "raining"
        case 600...699:
            return "snowing"
        case 700...799:
            return "windy"
        case 800:
            return "shine"
        default:
            return "cloudy"
        }
    }
    
    init(cityName: String, dt_txt: String, hour: String, day: String, temp: String, tempOriginal: String, temp_min: String, temp_max: String, description: String, conditionId: Int, temp_min_int: Int, temp_max_int: Int, feelslike: String, humidity: String, pressure: String, windSpeed: String, windDirection: String, visibility: String) {
        self.cityName = cityName
        self.date = dt_txt
        self.hour = hour
        self.day = day
        self.temp = temp
        self.tempOriginal = tempOriginal
        self.tempMinInt = temp_min_int
        self.tempMaxInt = temp_max_int
        self.tempMin = temp_min
        self.tempMax = temp_max
        self.description = description
        self.conditionId = conditionId
        self.feelslike = feelslike
        self.humidity = humidity
        self.pressure = pressure
        self.windSpeed = windSpeed
        self.windDirection = windDirection
        self.visibility = visibility
    }
    
    static func getModelsWith(weatherResponse: WeatherResponse) -> [WeatherViewModel] {
        return weatherResponse.list.map { getModelWith(eachWeather: $0, weatherResponse: weatherResponse) }
    }
    
    static func getModelWith(eachWeather: WeatherListResponse, weatherResponse: WeatherResponse) -> WeatherViewModel {
        
        let cityName = "\(weatherResponse.city.name)"
        let date = Date.getddMMYYYYFormat(eachWeather.dt_txt)
        let hour = Date.getHHFormat(eachWeather.dt_txt)
        let day = Date.getWeekDay(eachWeather.dt_txt)
        let tempOriginal = "\(Int(eachWeather.main.temp))"
        let temp = "\(Int(eachWeather.main.temp))°C"
        let temp_min_int = (Int(eachWeather.main.temp_min))
        let temp_max_int = (Int(eachWeather.main.temp_max))
        let temp_min = "\(Int(eachWeather.main.temp_min))°C"
        let temp_max = "\(Int(eachWeather.main.temp_max))°C"
        var description: String = ""
        let feelslike = "\(Int(eachWeather.main.feels_like))°C"
        let humidity = "\(eachWeather.main.humidity)%"
        let pressure = "\(Int(eachWeather.main.pressure))hPa"
        let windSpeed = "\(Int(eachWeather.wind.speed * 3.6))km/h"
        let windDirection = WeatherConverter.degToCompass(eachWeather.wind.deg)
        let visibility = "\(eachWeather.visibility / 1000)km"
        var conditionId: Int = 800
        
        if let weather = eachWeather.weather.first {
            description = weather.description
            conditionId = weather.id
        }
        
//        if let countryName = WeatherConverter.countryName(countryCode: weatherResponse.city.country) {
//            cityName = "\(weatherResponse.city.name), \(countryName)"
//        }
        
        return WeatherViewModel(cityName: cityName, dt_txt: date, hour: hour, day: day, temp: temp, tempOriginal: tempOriginal, temp_min: temp_min, temp_max: temp_max, description: description, conditionId: conditionId, temp_min_int: temp_min_int, temp_max_int: temp_max_int, feelslike: feelslike, humidity: humidity, pressure: pressure, windSpeed: windSpeed, windDirection: windDirection, visibility: visibility)
    }
}
