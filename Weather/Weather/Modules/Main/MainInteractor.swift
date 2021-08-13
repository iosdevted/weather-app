//
//  MainInteractor.swift
//  Weather
//
//  Created by Ted on 2021/08/11.
//  
//

import Foundation

class MainInteractor {

    // MARK: Properties
    var presenter: InteractorToPresenterMainProtocol?
    
    private let weatherService = WeatherService()
    private var lastRefreshDate: Date?
}

extension MainInteractor: PresenterToInteractorMainProtocol {
    
    func shouldFetchAPIWeatherData() -> Bool {
        guard let lastRefreshDate = RealmManager.shared.retrieveLastRefreshDate() else {
            return true
        }
        
        let currentDate = Date()
        //If the last refresh data is more than 180 minutes before, it return  true
        return currentDate.minutes(from: lastRefreshDate) >= 180 ? true : false
    }
    
    func fetchAPIWeatherData() {
        weatherService.fetchWeather(byCity: "Paris") { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let weather):
                RealmManager.shared.saveLocalWeather(weather)
                self.presenter?.handleResult(weather)
            case .failure(let error):
                self.presenter?.handleError(error)
            }
        }
    }
    
    func fetchLocalWeatherData() {
        guard let weather = RealmManager.shared.retrieveLocalWeather() else {
            return
        }
        self.presenter?.handleResult(weather)
    }
}
