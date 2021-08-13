//
//  WeatherDailyViewModel.swift
//  Weather
//
//  Created by Ted on 2021/08/13.
//

import Foundation

// Normally don't need this view model because API is well refined
// But Open Weather API don't afford daily weather forecast at no costs
// I needed to use 3 hours weather forecast, which is free.
// So I made this view model for daily weather forecast.

struct WeatherDailyViewModel {
    
    let day: [String]
    let temp_min: [String]
    let temp_max: [String]
    let conditionImage: [String]
    
    init(temp_min: [String], temp_max: [String], conditionImage: [String], day: [String]) {
        self.day = day
        self.temp_min = temp_min
        self.temp_max = temp_max
        self.conditionImage = conditionImage
    }
    
    static func getModelWith(weatherViewModel: [WeatherViewModel]) -> WeatherDailyViewModel {
        
        let temporaryDailyDictionary = Dictionary(grouping: weatherViewModel, by: { $0.dt_txt })
        let keysArray = Array(temporaryDailyDictionary.keys).sorted(by: { $0 < $1 })
        var minTempArray = [String]()
        var maxTempArray = [String]()
        var conditionIDArray = [String]()
        
        temporaryDailyDictionary.forEach { key, value in
            let max = value.max { $0.temp_max_int < $1.temp_max_int }
            let min = value.min { $0.temp_max_int < $1.temp_max_int }
            guard let max = max else { return }
            guard let min = min else { return }
            
            minTempArray.append(min.temp_min)
            maxTempArray.append(max.temp_max)
            conditionIDArray.append(max.conditionImage)
        }
        
        return WeatherDailyViewModel(temp_min: minTempArray, temp_max: maxTempArray, conditionImage: conditionIDArray, day: keysArray)
    }
}

