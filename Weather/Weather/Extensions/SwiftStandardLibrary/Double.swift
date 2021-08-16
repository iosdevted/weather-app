//
//  Double.swift
//  Weather
//
//  Created by Ted on 2021/08/11.
//

import Foundation

extension Double {
    
    // kelvin to celsius
    func makeCelsius() -> String {
        let argue = self - 273.15
        return String(format: "%.0f", arguments: [argue])
    }
    
    // kelvin to fahrenheit
    func makeFahrenheit() -> String {
        let argue = (self * 9/5) - 459.67
        return String(format: "%.0f", arguments: [argue])
    }
    
    // rounding double to 2 decimal place
    func makeRound() -> Double {
        return (self * 100).rounded() / 100
    }
    
    func degToCompass() -> String {
        let val = (Double(self / 22.5)).rounded() // round off the value
        let arr = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
        return arr[Int(val.truncatingRemainder(dividingBy: 16.0))] // truncatingRemainder -> Double % Double
    }
}
