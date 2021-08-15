//
//  MainInteractor.swift
//  Weather
//
//  Created by Ted on 2021/08/11.
//  
//

import Foundation

class MainInteractor {
    
    //MARK: Properties
    
    var presenter: InteractorToPresenterMainProtocol?
    
    private let weatherService = WeatherService()
    private var lastRefreshDate: Date?
    private var location: Location?
}

extension MainInteractor {
    
    //MARK: - Helpers
    
    private func didFristRun() -> Bool {
        return !RealmManager.shared.checkIfLocationDataExists()
    }
    
    private func didChangeLocationInSettingModule() -> Bool {
        return !RealmManager.shared.checkIfLocalWeatherExists()
    }
    
    private func fetchLocation() -> Location? {
        let location = RealmManager.shared.retrieveLocation()
        return location
    }
    
    private func fetchedAPI180MinutesAgo() -> Bool {
        guard let lastRefreshDate = RealmManager.shared.retrieveLastRefreshDate() else {
            return true
        }
        let currentDate = Date()
        return currentDate.minutes(from: lastRefreshDate) >= 180 ? true : false
    }
    
    private func fetchWeatherAPI(byCity city: String) {
        weatherService.fetchWeather(byCity: city) { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let response):
                RealmManager.shared.saveLocalWeather(response)
                self.presenter?.handleResult(response, cityName: city)
            case .failure(let error):
                self.presenter?.handleError(error)
            }
        }
    }
    
    private func fetchWeatherAPI(byLocation location: Location) {
        self.weatherService.fetchWeather(lat: location.latitude, lon: location.longitude) { result in
            switch result {
            case .success(let response):
                RealmManager.shared.saveLocalWeatherWithLocation(weather: response, location: location)
                self.presenter?.handleResult(response, cityName: location.location)
            case .failure(let error):
                self.presenter?.handleError(error)
            }
        }
    }
    
    
    private func fetchLocalWeather() {
        guard let weather = RealmManager.shared.retrieveLocalWeather(),
              let location = RealmManager.shared.retrieveLocation()
              else {
            return
        }
        self.presenter?.handleResult(weather, cityName: location.location)
    }
}

extension MainInteractor: PresenterToInteractorMainProtocol {
    
    //MARK: -> Interactor
    
    func fetchWeatherData() {
        
        if didFristRun() {
            fetchWeatherAPI(byCity: "Paris")
            print("didFristRun")
        } else {
            location = fetchLocation()
            guard let location = location else { return }
            if didChangeLocationInSettingModule() {
                fetchWeatherAPI(byLocation: location)
            } else {
                print("weather data exists")
                fetchedAPI180MinutesAgo() ? fetchWeatherAPI(byLocation: location) : fetchLocalWeather()
            }
        }
    }
}
