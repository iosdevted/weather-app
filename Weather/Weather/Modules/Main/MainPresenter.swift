//
//  MainPresenter.swift
//  Weather
//
//  Created by Ted on 2021/08/11.
//  
//

import Foundation

class MainPresenter {
    
    // MARK: - Properties
    
    var view: PresenterToViewMainProtocol?
    var interactor: PresenterToInteractorMainProtocol?
    var router: PresenterToRouterMainProtocol?
    
    private var dateKeysArray = [String]()
    private var dailyWeatherDictionary = [String: Array<String>]()
}

extension MainPresenter {
    
    //MARK: - Helpers
    
    private func makeDailyWeatherDictionary(with dictionary: [String : [WeatherModel]]) -> [String: Array<String>] {
        var tempDictionary = [String: Array<String>]()
        
        dictionary.forEach { key, value in
            let max = value.max { $0.temp_max_int < $1.temp_max_int }
            let min = value.min { $0.temp_max_int < $1.temp_max_int }
            guard let max = max else { return }
            guard let min = min else { return }
            
            tempDictionary.updateValue([max.temp_max, min.temp_min, max.conditionImage], forKey: key)
        }
        return tempDictionary
    }
    
    private func makeKeysArray(with dictionary: [String : [WeatherModel]]) -> Array<String> {
        return Array(dictionary.keys).sorted(by: { $0 < $1 })
    }
    
    private func shouldFetchWeatherAPI() -> Bool {
        guard let shouldFetchWeatherData = interactor?.fetchedAPI180MinutesAgo() else { return false }
        return shouldFetchWeatherData
    }
}

extension MainPresenter: ViewToPresenterMainProtocol {
    
    //MARK: -> Presenter
    
    func viewDidLoad() {
        shouldFetchWeatherAPI() ? interactor?.fetchWeatherAPI() : interactor?.fetchLocalWeather()
    }
    
    func viewDidAppear() {
        //request Location Authorization If needed
    }
}

extension MainPresenter: InteractorToPresenterMainProtocol {
    
    //MARK: <- Presenter
    
    func handleResult(_ model: [WeatherModel]) {
        // Make a dictionary with keys(Date; 13/08/2021)
        let temporaryDailyDictionary = Dictionary(grouping: model, by: { $0.dt_txt })
        
        // Make a Array and a dictionary for getting minimum and maximum temperature
        
        dateKeysArray = makeKeysArray(with: temporaryDailyDictionary)
        dailyWeatherDictionary = makeDailyWeatherDictionary(with: temporaryDailyDictionary)
        
        view?.bindToViews(with: model)
        view?.bindToDailyCell(with: dailyWeatherDictionary, keysArray: dateKeysArray)
    }
    
    func handleError(_ error: WeatherServiceError) {
        view?.showAlert(withMessage: error.localizedDescription, animated: true)
    }
}
