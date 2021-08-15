//
//  Date.swift
//  Weather
//
//  Created by Ted on 2021/08/11.
//

import UIKit

extension Date {
    
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    
    static func getddMMYYYYFormat(_ timestamp: String) -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = df.date(from: timestamp) else { return "404" }
        df.dateFormat = "dd/MM/YYYY"
        
        return df.string(from: date)
    }
    
    static func getddMMFormat(_ timestamp: String) -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = df.date(from: timestamp) else { return "404" }
        df.dateFormat = "dd/MM"
        
        return df.string(from: date)
    }
    
    static func getHHFormat(_ timestamp: String) -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = df.date(from: timestamp) else { return "404" }
        df.dateFormat = "HH'h'"
        
        return df.string(from: date)
    }
    
    static func getWeekDay(_ timestamp: String) -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = df.date(from: timestamp) else { return "404" }
        df.dateFormat = "EEEE"
        
        return df.string(from: date)
    }
}
