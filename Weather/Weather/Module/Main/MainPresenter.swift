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
}

extension MainPresenter {
    
    //MARK: - Helpers
    
    private func shouldFetchWeatherAPI() -> Bool {
        guard let shouldFetchWeatherData = interactor?.fetchedAPI180MinutesAgo() else { return false }
        return shouldFetchWeatherData
    }
}

extension MainPresenter: ViewToPresenterMainProtocol {
    
    //MARK: -> Presenter
    
    func viewDidLoad() {
        shouldFetchWeatherAPI() ? interactor?.fetchWeatherAPI() : interactor?.fetchLocalWeather()
//        interactor?.fetchWeatherAPI()
    }
    
    func viewDidAppear() {
        //request Location Authorization If needed
    }
}

extension MainPresenter: InteractorToPresenterMainProtocol {
    
    //MARK: <- Presenter
    
    func handleResult(_ response: WeatherResponse) {

        let weatherViewModel = WeatherViewModel.getModelsWith(weatherResponse: response)
        let weatherDailyViewModel = WeatherDailyViewModel.getModelWith(weatherViewModel: weatherViewModel)
        let weatherInfoViewModel = WeatherInfoViewModel.getModelWith(weatherViewModel: weatherViewModel)
        
        view?.bindToViews(with: weatherViewModel)
        view?.bindToViews(with: weatherDailyViewModel)
        view?.bindToViews(with: weatherInfoViewModel)
        view?.reloadCollectionView()
    }
    
    func handleError(_ error: WeatherServiceError) {
        view?.showAlert(withMessage: error.localizedDescription, animated: true)
    }
}
