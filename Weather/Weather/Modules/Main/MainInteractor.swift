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
}

extension MainInteractor: PresenterToInteractorMainProtocol {
    
    func fetchWeatherData() {
        weatherService.fetchWeather(byCity: "Paris") { [weak self] result in
            self?.presenter?.handleResult(result)
        }
    }
}
