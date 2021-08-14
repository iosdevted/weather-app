//
//  WeatherConverter.swift
//  Weather
//
//  Created by Ted on 2021/08/12.
//

import UIKit

class WeatherConverter {
    
    static func degToCompass(_ deg: Double) -> String {
        let val = floor(Double((deg / 22.5) + 0.5))
        let arr = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
        return arr[Int(val.truncatingRemainder(dividingBy: 16.0))]
    }
}
