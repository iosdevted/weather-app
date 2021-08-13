//
//  WeatherModel.swift
//  Weather
//
//  Created by Ted on 2021/08/13.
//

import Foundation

struct WeatherModel: Codable {
    
    let dt_txt: String
    let hour: String
    let day: String
    let temp: String
    let temp_min_int: Int
    let temp_max_int: Int
    let temp_min: String
    let temp_max: String
    let description: String
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
            return "windy" //don't have a pic
        case 800:
            return "shine"
        default:
            return "cloudy"
        }
    }
    
    init(dt_txt: String, hour: String, day: String, temp: String, temp_min: String, temp_max: String, description: String, conditionId: Int, temp_min_int: Int, temp_max_int: Int) {
        self.dt_txt = dt_txt
        self.hour = hour
        self.day = day
        self.temp = temp
        self.temp_min_int = temp_min_int
        self.temp_max_int = temp_max_int
        self.temp_min = temp_min
        self.temp_max = temp_max
        self.description = description
        self.conditionId = conditionId
    }
    
    static func getModelsWith(weatherResponse: WeatherResponse) -> [WeatherModel] {
        return weatherResponse.list.map { getModelWith(eachWeather: $0) }
    }
    
    static func getModelWith(eachWeather: WeatherListResponse) -> WeatherModel {
        let date = Date.getddMMYYYYFormat(eachWeather.dt_txt)
        let hour = Date.getHHFormat(eachWeather.dt_txt)
        let day = Date.getWeekDay(eachWeather.dt_txt)
        let temp = "\(Int(eachWeather.main.temp)) °C"
        let temp_min_int = (Int(eachWeather.main.temp_min))
        let temp_max_int = (Int(eachWeather.main.temp_max))
        let temp_min = "\(Int(eachWeather.main.temp_min)) °C"
        let temp_max = "\(Int(eachWeather.main.temp_max)) °C"
        var description: String = ""
        var conditionId: Int = 800
        if let weather = eachWeather.weather.first {
            description = weather.description
            conditionId = weather.id
        }
        
        return WeatherModel(dt_txt: date, hour: hour, day: day, temp: temp, temp_min: temp_min, temp_max: temp_max, description: description, conditionId: conditionId, temp_min_int: temp_min_int, temp_max_int: temp_max_int)
    }
    
}
