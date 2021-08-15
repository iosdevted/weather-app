//
//  LocationManager.swift
//  Weather
//
//  Created by Ted on 2021/08/15.
//

import Foundation

class LocationManager {
    
    static let shared = LocationManager()
    
    private var location: [Location] = [] {
        didSet{
            print("location update :",self.location)
        }
    }
    
    func addLocation(_ location: Location) {
        self.location.append(location)
    }
    
    func getLocation() -> [Location] {
        return self.location
    }
    
    func setLocation(_ location: [Location]) {
        self.location = location
    }
}
