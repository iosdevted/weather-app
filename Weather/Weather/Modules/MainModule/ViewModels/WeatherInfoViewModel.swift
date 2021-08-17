//
//  WeatherInfoViewModel.swift
//  Weather
//
//  Created by Ted on 2021/08/14.
//

import Foundation

struct WeatherInfoViewModel {
    
    let infos: [String]
    
    init(infos: [String]) {
        self.infos = infos
    }
    
    static func getViewModel(with weatherViewModel: [WeatherViewModel]) -> WeatherInfoViewModel {
        var infos = [String]()
        if let recentWeather = weatherViewModel.first {
            infos.append(recentWeather.feelslike)
            infos.append(recentWeather.humidity)
            infos.append(recentWeather.pressure)
            infos.append(recentWeather.windSpeed)
            infos.append(recentWeather.windDirection)
            infos.append(recentWeather.visibility)
        }
        //infos -> [[feelslike, humidity, pressure, windSpeed, windDirection, visibility], [..], [..] ..]
        return WeatherInfoViewModel(infos: infos)
    }
}
