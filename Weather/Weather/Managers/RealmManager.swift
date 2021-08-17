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
    
    //MARK: - Weather
    
    // Retrieve ALL Data
    func retrieveLocalWeatherData() -> LocalWeather? {
        let realmObject = try! Realm()
        
        guard let localWeather = realmObject.objects(LocalWeather.self).first
        else {
            return nil
        }
        
        return localWeather
    }
    
    // Retrieve ONLY Weather Response
    func retrieveWeatherResponse() -> WeatherResponse? {
        let realmObject = try! Realm()
        
        guard let localWeather = realmObject.objects(LocalWeather.self).first,
              let weatherData = localWeather.weatherData
        else {
            return nil
        }
        
        return decode(data: weatherData)
    }
    
    // Delete ALL Data
    func deleteLocalWeatherData() {
        let realmObject = try! Realm()
        let localWeather = realmObject.objects(LocalWeather.self)
        
        try! realmObject.write {
            realmObject.delete(localWeather)
        }
    }
    
    // Save ALL Data
    func saveLocalWeatherData(weather: WeatherResponse, location: Location) {
        deleteLocalWeatherData()
        
        let localWeatherModel = LocalWeather()
        localWeatherModel.weatherId = UUID().uuidString
        localWeatherModel.locationName = location.name
        localWeatherModel.longitude = location.longitude
        localWeatherModel.latitude = location.latitude
        localWeatherModel.lastRefreshedDate = Date()
        localWeatherModel.weatherData = encode(model: weather)

        add(localWeatherModel)
    }
    
    // Save ONLY Weather Response
    func saveWeatherResponse(_ weather: WeatherResponse) {
        deleteLocalWeatherData()
        
        let localWeatherModel = LocalWeather()
        localWeatherModel.weatherId = UUID().uuidString
        localWeatherModel.lastRefreshedDate = Date()
        localWeatherModel.weatherData = encode(model: weather)

        add(localWeatherModel)
    }
    
    // Save Only Location Data
    func saveLocationData(_ location: Location) {
        deleteLocalWeatherData()
        
        let LocationModel = LocalWeather()
        LocationModel.locationName = location.name
        LocationModel.latitude = location.latitude
        LocationModel.longitude = location.longitude

        add(LocationModel)
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
            print(RealmManagerError.encodeError)
        }
        return nil
    }
    
    private func decode(data: Data) -> WeatherResponse? {
        do {
            let decodedWeather = try JSONDecoder().decode(WeatherResponse.self, from: data)
            return decodedWeather
        } catch {
            print(RealmManagerError.decodeError)
        }
        return nil
    }
}
