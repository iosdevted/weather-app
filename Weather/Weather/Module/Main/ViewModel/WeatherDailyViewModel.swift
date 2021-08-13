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
        
        let temporaryDailyDictionary = Dictionary(grouping: weatherViewModel, by: { $0.date })
        let keysArray = Array(temporaryDailyDictionary.keys).sorted(by: { $0 < $1 })
        var minTempArray = [String]()
        var maxTempArray = [String]()
        var conditionIDArray = [String]()
        
        temporaryDailyDictionary.forEach { key, value in
            let max = value.max { $0.tempMaxInt < $1.tempMaxInt }
            let min = value.min { $0.tempMaxInt < $1.tempMaxInt }
            guard let max = max else { return }
            guard let min = min else { return }
            
            minTempArray.append(min.tempMin)
            maxTempArray.append(max.tempMax)
            conditionIDArray.append(max.conditionImage)
        }
        
        return WeatherDailyViewModel(temp_min: minTempArray, temp_max: maxTempArray, conditionImage: conditionIDArray, day: keysArray)
    }
}

