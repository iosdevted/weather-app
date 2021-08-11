//
//  UnitTemperature.swift
//  Weather
//
//  Created by Ted on 2021/08/12.
//

import Foundation

extension UnitTemperature {
    
    private struct Config {
        static let defaultCelsiusValue: String = "0°C"
    }
    
    static var current: UnitTemperature {
        let measureFormatter = MeasurementFormatter()
        let measurement = Measurement(value: 0, unit: UnitTemperature.celsius)
        let output = measureFormatter.string(from: measurement)
        return output == Config.defaultCelsiusValue ? .celsius : .fahrenheit
    }
    
}
