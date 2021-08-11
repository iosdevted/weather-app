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
    private var mainWeatherModel: MainWeatherModel?
}

extension MainInteractor: PresenterToInteractorMainProtocol {
    
    func fetchWeatherData() {
        weatherService.fetchWeather(byCity: "Paris") { [weak self] result in
            guard let `self` = self else { return }
            self.presenter?.handleResult(result)
            // Add the function to save to local data
            self.lastRefreshDate = Date()
        }
    }
    
    func shouldRefreshData() -> Bool {
        guard let lastRefreshDate = lastRefreshDate else { return true }
        
        let currentData = Date()
        if currentData.minutes(from: lastRefreshDate) >= 180 {
            return true
        }
        
        return false
    }
}
