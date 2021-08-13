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
    let temp_min: String
    let temp_max: String
    let description: String
    let conditionId: Int
    
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
    
    init(dt_txt: String, hour: String, day: String, temp: String, temp_min: String, temp_max: String, description: String, conditionId: Int) {
        self.dt_txt = dt_txt
        self.hour = hour
        self.day = day
        self.temp = temp
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
        let temp_min = "\(Int(eachWeather.main.temp_min)) °C"
        let temp_max = "\(Int(eachWeather.main.temp_max)) °C"
        var description: String = ""
        var conditionId: Int = 800
        if let weather = eachWeather.weather.first {
            description = weather.description
            conditionId = weather.id
        }
        
        return WeatherModel(dt_txt: date, hour: hour, day: day, temp: temp, temp_min: temp_min, temp_max: temp_max, description: description, conditionId: conditionId)
    }
    
}
