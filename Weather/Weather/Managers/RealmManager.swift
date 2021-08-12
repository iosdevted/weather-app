//
//  RealmManager.swift
//  Weather
//
//  Created by Ted on 2021/08/12.
//

import Foundation
import RealmSwift

let realmObject = try! Realm()

class RealmManager: NSObject {
    
    static let shared = RealmManager()
    
    //MARK: - Local Weather
    
    func retrieveLocalWeather() -> MainWeatherModel? {
        guard let localWeather = realmObject.objects(LocalWeather.self).first,
              let weatherData = localWeather.weatherData
        else {
            return nil
        }
        
        return decode(data: weatherData)
    }
    
    func saveLocalWeather(_ weather: MainWeatherModel) {
        deleteLocalWeather()
        
        let localWeatherModel = LocalWeather()
        localWeatherModel.weatherId = UUID().uuidString
        localWeatherModel.weatherData = encode(model: weather)
        
        add(localWeatherModel)
    }
    
    func deleteLocalWeather() {
        let localWeather = realmObject.objects(LocalWeather.self)
        
        try! realmObject.write {
            realmObject.delete(localWeather)
        }
    }
    
    func checkIfLocalWeatherExists() -> Bool {
        guard let localWeather = realmObject.objects(LocalWeather.self).first,
              let _ = localWeather.weatherData
        else {
            return false
        }
        return true
    }
    
    //MARK: - User
    
    func retrieveUserId() -> String? {
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
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}

//MARK: - Extension

extension RealmManager {
    
    private func add(_ object : Object) {
        try! realmObject.write {
            realmObject.add(object)
        }
    }
    
    private func encode(model: MainWeatherModel) -> Data? {
        do {
            let jsonData = try JSONEncoder().encode(model)
            return jsonData
        } catch {
            print(error)
        }
        return nil
    }
    
    private func decode(data: Data) -> MainWeatherModel? {
        do {
            let decodedWeather = try JSONDecoder().decode(MainWeatherModel.self, from: data)
            return decodedWeather
        } catch {
            print(error)
        }
        return nil
    }
    
    private func checkIfLocalUserExists() -> Bool {
        guard let _ = realmObject.objects(User.self).first else {
            return false
        }
        return true
    }
}
