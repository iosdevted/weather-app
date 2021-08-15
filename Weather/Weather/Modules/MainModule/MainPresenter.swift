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

extension MainPresenter: ViewToPresenterMainProtocol {
    
    //MARK: -> Presenter
    
    func viewWillAppear() {
        interactor?.fetchWeatherData()
    }
    
    func viewDidAppear() {
        //request Location Authorization If needed
    }
    
    func weatherButtonClicked() {
        router?.openWeatherWebsite()
    }
    
    func locationListButtonClicked() {
        router?.pushToSettingViewController(view: view)
    }
}

extension MainPresenter: InteractorToPresenterMainProtocol {
    
    //MARK: Presenter <-
    
    func handleResult(_ response: WeatherResponse, cityName: String) {

        let weatherViewModel = WeatherViewModel.getViewModels(with: response)
        let weatherDailyViewModel = WeatherDailyViewModel.getViewModel(with: weatherViewModel)
        let weatherInfoViewModel = WeatherInfoViewModel.getViewModel(with: weatherViewModel)

        view?.setupUIBinding(with: weatherViewModel, cityName: cityName)
        view?.setupUIBinding(with: weatherDailyViewModel)
        view?.setupUIBinding(with: weatherInfoViewModel)
        view?.reloadCollectionView()
    }
    
    func handleError(_ error: WeatherServiceError) {
        view?.showAlert(withMessage: error.localizedDescription, animated: true)
    }
}
