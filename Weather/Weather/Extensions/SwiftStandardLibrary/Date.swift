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
    
    static func convertToUTCDate(from timestamp: String) -> Date? {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        df.timeZone = TimeZone(abbreviation: "UTC")
        return df.date(from: timestamp)
    }
    
    static func convertToLocalTimeString(date: Date?, timeZone: Int, dateFormat: String) -> String {
        let df = DateFormatter()
        df.timeZone = TimeZone(abbreviation: calcuateGMT(time: timeZone))
        df.dateFormat = dateFormat
        return df.string(from: date!)
    }
    
    static func getddMMYYYYFormat(timestamp: String, timeZone: Int) -> String {
        let date = convertToUTCDate(from: timestamp)
        return convertToLocalTimeString(date: date, timeZone: timeZone, dateFormat: "dd/MM/YYYY")
    }
    
    static func getddMMFormat(timestamp: String, timeZone: Int) -> String {
        let date = convertToUTCDate(from: timestamp)
        return convertToLocalTimeString(date: date, timeZone: timeZone, dateFormat: "dd/MM")
    }
    
    static func getHHFormat(timestamp: String, timeZone: Int) -> String {
        let date = convertToUTCDate(from: timestamp)
        return convertToLocalTimeString(date: date, timeZone: timeZone, dateFormat: "HH'h'")
    }
    
    static func getWeekDay(timestamp: String, timeZone: Int) -> String {
        let date = convertToUTCDate(from: timestamp)
        return convertToLocalTimeString(date: date, timeZone: timeZone, dateFormat: "EEEE")
    }
}
