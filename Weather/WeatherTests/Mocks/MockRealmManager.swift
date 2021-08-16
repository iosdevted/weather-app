//
//  MockRealmManager.swift
//  WeatherTests
//
//  Created by Ted on 2021/08/16.
//

import RealmSwift
import Foundation
@testable import Weather

class MockRealmManager: RealmManager {
    
    var saveOnlyLocationDataCalled = 0
    var saveOnlyWeatherDataCalled = 0
    var saveAllDataCalled = 0
    var retrieveAllDataCalled = 0
    var retrieveDecodedWeatherDataCalled = 0
    var retrieveLocationDataCalled = 0
    
    override func saveAllData(weather: WeatherResponse, location: Location) {
        self.saveAllDataCalled += 1
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "weather-realmManager-tests"
        super.saveAllData(weather: weather, location: location)
    }
    
    override func saveOnlyLocationData(_ location: Location) {
        self.saveOnlyLocationDataCalled += 1
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "weather-realmManager-tests"
        super.saveOnlyLocationData(location)
    }
    
    override func saveOnlyWeatherData(_ weather: WeatherResponse) {
        self.saveOnlyWeatherDataCalled += 1
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "weather-realmManager-tests"
        super.saveOnlyWeatherData(weather)
    }
    
    override func retrieveAllData() -> LocalWeather? {
        self.retrieveAllDataCalled += 1
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "weather-realmManager-tests"
        return super.retrieveAllData()
    }
    
    override func retrieveDecodedWeatherData() -> WeatherResponse? {
        self.retrieveDecodedWeatherDataCalled += 1
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "weather-realmManager-tests"
        return self.retrieveDecodedWeatherData()
    }
    
    func retrieveLocationData() -> Location? {
        self.retrieveLocationDataCalled += 1
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "weather-realmManager-tests"
        
        let testRealm = try! Realm()
        
        guard let localWeather = testRealm.objects(LocalWeather.self).first
        else {
            return nil
        }
        
        let location = Location(name: localWeather.locationName!, latitude: localWeather.latitude, longitude: localWeather.longitude)
        
        return location
    }
    
    override func deleteAllLocalData() {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "weather-realmManager-tests"
        super.deleteAllLocalData()
    }
}
