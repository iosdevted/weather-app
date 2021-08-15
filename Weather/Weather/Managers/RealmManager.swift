//
//  RealmManager.swift
//  Weather
//
//  Created by Ted on 2021/08/12.
//

import Foundation
import RealmSwift

class RealmManager: NSObject {
    
    static let shared = RealmManager()
    
    //MARK: - Local Weather
    
    func retrieveLocalWeather() -> WeatherResponse? {
        //https://stackoverflow.com/questions/45375468/realm-thread-safe-object-with-singleton
        let realmObject = try! Realm()
        
        guard let localWeather = realmObject.objects(LocalWeather.self).first,
              let weatherData = localWeather.weatherData
        else {
            return nil
        }
        
        return decode(data: weatherData)
    }
    
    func saveLocalWeather(_ weather: WeatherResponse) {
        deleteLocalWeather()
        
        let localWeatherModel = LocalWeather()
        localWeatherModel.weatherId = UUID().uuidString
        localWeatherModel.lastRefreshDate = Date()
        localWeatherModel.weatherData = encode(model: weather)

        add(localWeatherModel)
    }
    
    func saveLocalWeatherWithLocation(weather: WeatherResponse, location: Location) {
        deleteLocalWeather()
        
        let localWeatherModel = LocalWeather()
        localWeatherModel.weatherId = UUID().uuidString
        localWeatherModel.location = location.location
        localWeatherModel.longitude = location.longitude
        localWeatherModel.latitude = location.latitude
        localWeatherModel.lastRefreshDate = Date()
        localWeatherModel.weatherData = encode(model: weather)

        add(localWeatherModel)
    }
    
    func deleteLocalWeather() {
        let realmObject = try! Realm()
        let localWeather = realmObject.objects(LocalWeather.self)
        
        try! realmObject.write {
            realmObject.delete(localWeather)
        }
    }
    
    func checkIfLocalWeatherExists() -> Bool {
        let realmObject = try! Realm()
        
        guard let localWeather = realmObject.objects(LocalWeather.self).first,
              let _ = localWeather.weatherData
        else {
            return false
        }
        return true
    }
    
    //MARK: - Location
    
    func retrieveLocation() -> Location? {
        
        let realmObject = try! Realm()
        guard let location = realmObject.objects(LocalWeather.self).first,
              let locationData = location.location
        else {
            return nil
        }

        let longitudeData = location.longitude
        let latitudeData = location.latitude
        
        let data = Location(location: locationData, latitude: latitudeData, longitude: longitudeData)
        return data 
    }
    
    func saveLocation(_ location: Location) {
        deleteLocation()
        
        let LocationModel = LocalWeather()
        LocationModel.location = location.location
        LocationModel.latitude = location.latitude
        LocationModel.longitude = location.longitude

        add(LocationModel)
        print(LocationModel)
    }
    
    func deleteLocation() {
        let realmObject = try! Realm()
        let localWeather = realmObject.objects(LocalWeather.self)
        
        try! realmObject.write {
            realmObject.delete(localWeather)
        }
    }
    
    func checkIfLocationDataExists() -> Bool {
        let realmObject = try! Realm()

        guard let localWeather = realmObject.objects(LocalWeather.self).first,
              let _ = localWeather.location
        else {
            return false
        }
        return true
    }
    
    //MARK: - Last Refresh Date
    
    func retrieveLastRefreshDate() -> Date? {
        let realmObject = try! Realm()
        
        guard let localWeather = realmObject.objects(LocalWeather.self).first,
              let lastRefreshDate = localWeather.lastRefreshDate
        else {
            return nil
        }
        
        return lastRefreshDate
    }

    
    //MARK: - User
    
    func retrieveUserId() -> String? {
        let realmObject = try! Realm()
        
        guard let user = realmObject.objects(User.self).first else {
            return nil
        }
        
        return user.userId
    }
    
    func saveUserId(_ userId: String) {
        if !checkIfLocalUserExists() { return }
        
        let user = User()
        user.userId = userId
        
        add(user)
    }
    
    private func checkIfLocalUserExists() -> Bool {
        let realmObject = try! Realm()
        
        guard let _ = realmObject.objects(User.self).first else {
            return false
        }
        return true
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}

//MARK: - Extension

extension RealmManager {
    
    private func add(_ object : Object) {
        let realmObject = try! Realm()
        
        try! realmObject.write {
            realmObject.add(object)
        }
    }
    
    private func encode(model: WeatherResponse) -> Data? {
        do {
            let jsonData = try JSONEncoder().encode(model)
            return jsonData
        } catch {
            print(error)
        }
        return nil
    }
    
    private func decode(data: Data) -> WeatherResponse? {
        do {
            let decodedWeather = try JSONDecoder().decode(WeatherResponse.self, from: data)
            return decodedWeather
        } catch {
            print(error)
        }
        return nil
    }
}
