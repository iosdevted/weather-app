//
//  WeatherLocationModel.swift
//  Weather
//
//  Created by Ted on 2021/08/13.
//

import Foundation

struct WeatherLocationModel: Codable {
    var cityName: String
    
    init(weatherResponse: WeatherResponse) {
        self.cityName = "\(weatherResponse.city.name)"
    }
}
