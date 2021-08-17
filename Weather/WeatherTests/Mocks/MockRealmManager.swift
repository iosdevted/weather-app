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
    
    override func saveLocalWeatherData(weather: WeatherResponse, location: Location) {
        self.saveAllDataCalled += 1
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "weather-realmManager-tests"
        super.saveLocalWeatherData(weather: weather, location: location)
    }
    
    override func saveLocationData(_ location: Location) {
        self.saveOnlyLocationDataCalled += 1
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "weather-realmManager-tests"
        super.saveLocationData(location)
    }
    
    override func saveWeatherResponse(_ weather: WeatherResponse) {
        self.saveOnlyWeatherDataCalled += 1
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "weather-realmManager-tests"
        super.saveWeatherResponse(weather)
    }
    
    override func retrieveLocalWeatherData() -> LocalWeather? {
        self.retrieveAllDataCalled += 1
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "weather-realmManager-tests"
        return super.retrieveLocalWeatherData()
    }
    
    override func retrieveWeatherResponse() -> WeatherResponse? {
        self.retrieveDecodedWeatherDataCalled += 1
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "weather-realmManager-tests"
        return self.retrieveWeatherResponse()
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
    
    override func deleteLocalWeatherData() {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "weather-realmManager-tests"
        super.deleteLocalWeatherData()
    }
}
