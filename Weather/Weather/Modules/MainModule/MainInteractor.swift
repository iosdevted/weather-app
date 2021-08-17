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
    private var localData: LocalWeather?
}

extension MainInteractor {
    
    //MARK: - Helpers
    
    private func fetchWeatherData(by city: String) {
        weatherService.fetchWeather(byCity: city) { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let response):
                RealmManager.shared.saveWeatherResponse(response)
                self.presenter?.handleResult(response, cityName: city)
            case .failure(let error):
                self.presenter?.handleError(error)
            }
        }
    }
    
    private func fetchWeatherData(by location: Location) {
        self.weatherService.fetchWeather(lat: location.latitude, lon: location.longitude) { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let response):
                RealmManager.shared.saveLocalWeatherData(weather: response, location: location)
                self.presenter?.handleResult(response, cityName: location.name)
            case .failure(let error):
                self.presenter?.handleError(error)
            }
        }
    }
    
    private func fetchedAPI180MinutesAgo(from lastRefreshDate: Date) -> Bool {
        let currentDate = Date()
        return currentDate.minutes(from: lastRefreshDate) >= 180 ? true : false
    }
    
    private func sendLocalData(to presenter: InteractorToPresenterMainProtocol?,
                               with locationName: String,
                               with response: WeatherResponse) {
        self.presenter?.handleResult(response, cityName: locationName)
    }
}

extension MainInteractor: PresenterToInteractorMainProtocol {
    
    //MARK: -> Interactor
    
    func fetchWeatherData() {
        localData = RealmManager.shared.retrieveLocalWeatherData()
        
        // #Case 1: When the location information is not saved
        // Because the location has never been changed
        guard let locationName = localData?.locationName,
              let locationLatitude = localData?.latitude,
              let locationLongitude = localData?.longitude
        else {
            fetchWeatherData(by: "Paris")
            return
        }
        // Save the location information so that we can use later
        let location = Location(name: locationName, latitude: locationLatitude, longitude: locationLongitude)
        
        // #Case 2: When location information is changed in settingModule,
        // In this case, location information exists but no weather information.
        guard let _ = localData?.weatherData,
              let weatherResponse = RealmManager.shared.retrieveWeatherResponse()
        else {
            fetchWeatherData(by: location)
            return
        }
        
        // #Case 3: All Local Data Exsits but if the API was fetched 3 hours ago,
        // local Realm data will be used,
        // otherwise, we fetch the API newly.
        if let lastRefreshDate = localData?.lastRefreshedDate {
            fetchedAPI180MinutesAgo(from: lastRefreshDate) ?
                fetchWeatherData(by: location) :
                sendLocalData(to: presenter, with: locationName, with: weatherResponse)
        }
    }
}
