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
    
    private func retrieveLocalData() -> LocalWeather? {
        return RealmManager.shared.retrieveAllData()
    }
    
    private func fetchWeatherData(by city: String) {
        weatherService.fetchWeather(byCity: city) { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let response):
                RealmManager.shared.saveOnlyWeatherData(response)
                self.presenter?.handleResult(response, cityName: city)
            case .failure(let error):
                self.presenter?.handleError(error)
            }
        }
    }
    
    private func fetchWeatherData(by location: Location) {
        self.weatherService.fetchWeather(lat: location.latitude, lon: location.longitude) { result in
            switch result {
            case .success(let response):
                RealmManager.shared.saveAllData(weather: response, location: location)
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
    
    func decode(data: Data) -> WeatherResponse? {
        do {
            let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
            return weatherResponse
        } catch let error {
            print(error)
        }
        return nil
    }
}

extension MainInteractor: PresenterToInteractorMainProtocol {
    
    //MARK: -> Interactor
    
    func fetchWeatherData() {
        localData = retrieveLocalData()
        
        //location을 바꾼적이 없을 경우 -> Never changed the location
        guard let locationName = localData?.locationName,
              let locationLatitude = localData?.latitude,
              let locationLongitude = localData?.longitude
        else {
            fetchWeatherData(by: "Paris")
            return
        }
        
        //지금막 location을 바꾼 경우 -> location을 바꾸는 과정에서 weather data를 지우기 때문에 없어
        let location = Location(name: locationName, latitude: locationLatitude, longitude: locationLongitude)
        guard let weatherData = localData?.weatherData,
              let weatherResponse = decode(data: weatherData)
        else {
            fetchWeatherData(by: location)
            return
        }
        
        // 그 외의 경우
        if let lastRefreshDate = localData?.lastRefreshedDate {
            fetchedAPI180MinutesAgo(from: lastRefreshDate) ?
                fetchWeatherData(by: location) :
                sendLocalData(to: presenter, with: locationName, with: weatherResponse)
        }
    }
}
