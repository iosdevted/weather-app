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
}

extension MainInteractor {
    
    //MARK: - Helpers
    
    private func fetchedAPI180MinutesAgo() -> Bool {
        guard let lastRefreshDate = RealmManager.shared.retrieveLastRefreshDate() else {
            return true
        }
        
        let currentDate = Date()
        //If the last refresh data is more than 180 minutes before, it return  true
        return currentDate.minutes(from: lastRefreshDate) >= 180 ? true : false
    }
    
    private func fetchWeatherAPI() {
        weatherService.fetchWeather(byCity: "Paris") { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let response):
                RealmManager.shared.saveLocalWeather(response)
                self.presenter?.handleResult(response)
            case .failure(let error):
                self.presenter?.handleError(error)
            }
        }
    }
    
    private func fetchLocalWeather() {
        guard let weather = RealmManager.shared.retrieveLocalWeather() else {
            return
        }
        self.presenter?.handleResult(weather)
    }
}

extension MainInteractor: PresenterToInteractorMainProtocol {
    
    //MARK: -> Interactor
    
    func fetchWeatherData() {
        fetchedAPI180MinutesAgo() ? fetchWeatherAPI() : fetchLocalWeather()
    }
}
