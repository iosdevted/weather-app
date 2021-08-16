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
    
    static func calcuateGMT(time: Int) -> String {
        let timeZone = abs(time / 3600)
        let compare = time < 0 ? "-" : "+"

        if timeZone < 10 {
            return "GMT\(compare)0\(timeZone)"
        } else {
            return "GMT\(compare)\(timeZone)"
        }
    }
    
    static func getddMMYYYYFormat(_ timestamp: String, timeZone: Int) -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        df.timeZone = TimeZone(abbreviation: "UTC")
        let date = df.date(from: timestamp)
        
        let anotherDf = DateFormatter()
        anotherDf.timeZone = TimeZone(abbreviation: calcuateGMT(time: timeZone))
        anotherDf.dateFormat = "dd/MM/YYYY"
        return anotherDf.string(from: date!)
    }
    
    static func getddMMFormat(_ timestamp: String, timeZone: Int) -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        df.timeZone = TimeZone(abbreviation: "UTC")
        let date = df.date(from: timestamp)
        
        let anotherDf = DateFormatter()
        anotherDf.timeZone = TimeZone(abbreviation: calcuateGMT(time: timeZone))
        anotherDf.dateFormat = "dd/MM"
        return anotherDf.string(from: date!)
    }
    
    static func getHHFormat(_ timestamp: String, timeZone: Int) -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        df.timeZone = TimeZone(abbreviation: "UTC")
        let date = df.date(from: timestamp)
        
        let anotherDf = DateFormatter()
        anotherDf.timeZone = TimeZone(abbreviation: calcuateGMT(time: timeZone))
        anotherDf.dateFormat = "HH'h'"
        return anotherDf.string(from: date!)
    }
    
    static func getWeekDay(_ timestamp: String, timeZone: Int) -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        df.timeZone = TimeZone(abbreviation: "UTC")
        let date = df.date(from: timestamp)
        
        let anotherDf = DateFormatter()
        anotherDf.timeZone = TimeZone(abbreviation: calcuateGMT(time: timeZone))
        anotherDf.dateFormat = "EEEE"
        return anotherDf.string(from: date!)
    }
}
