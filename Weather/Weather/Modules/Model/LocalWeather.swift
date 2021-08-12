//
//  LocalWeather.swift
//  Weather
//
//  Created by Ted on 2021/08/12.
//

import Foundation
import RealmSwift

class LocalWeather: Object {
    @objc dynamic var weatherId: String?
    @objc dynamic var lastRefreshDate: Date?
    @objc dynamic var weatherData: Data? = nil
    
    override class func primaryKey() -> String? {
        return "weatherId"
    }
}
