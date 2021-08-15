//
//  Double.swift
//  Weather
//
//  Created by Ted on 2021/08/11.
//

import Foundation

extension Double {
    
    func toString() -> String {
        return String(format: "%.1f", self)
    }
    
    func toInt() -> Int {
        return Int(self)
    }
}
