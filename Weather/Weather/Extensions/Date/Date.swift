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
}
