//
//  WeatherDailyViewModel.swift
//  Weather
//
//  Created by Ted on 2021/08/13.
//

import Foundation

// This API doesn't offer a daily weather forecast. 😫
// So I made this view model to calculate the highest and lowest temperature.
// but this is very temporary way. Better to find another API to offer a daily weather forecast.

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
    
    static func getViewModel(with weatherViewModel: [WeatherViewModel]) -> WeatherDailyViewModel {
        
        var minTempArray = [String]()
        var maxTempArray = [String]()
        var conditionIDArray = [String]()
        // weatherViewModel -> [WeatherViewModel]
        let temporaryDailyDictionary = Dictionary(grouping: weatherViewModel, by: { $0.dateWithMonth })
        // temporaryDailyDictionary -> ["17/08": [WeatherViewModel], 18/08: [WeatherViewModel] ..]
        let keysArray = Array(temporaryDailyDictionary.keys).sorted(by: { $0 < $1 })
        // keysArray -> ["17/08, 18/08, .."]
        
        temporaryDailyDictionary.forEach { key, value in
            // value => [WeatherViewModel]
            // find highest temperature using max.
            let tempMax = value.max { $0.tempMaxInt < $1.tempMaxInt }
            // find lowest temperature using min.
            let tempMin = value.min { $0.tempMinInt < $1.tempMinInt }
            guard let tempMax = tempMax, let tempMin = tempMin else { return }
            
            maxTempArray.append(tempMax.tempMax)
            minTempArray.append(tempMin.tempMin)
            conditionIDArray.append(tempMax.conditionImage)
        }
        
        return WeatherDailyViewModel(temp_min: minTempArray, temp_max: maxTempArray, conditionImage: conditionIDArray, day: keysArray)
    }
}

