//
//  MainPresenter.swift
//  Weather
//
//  Created by Ted on 2021/08/11.
//  
//

import Foundation

class MainPresenter {
    
    // MARK: Properties
    var view: PresenterToViewMainProtocol?
    var interactor: PresenterToInteractorMainProtocol?
    var router: PresenterToRouterMainProtocol?
    
    private func fetchWeatherData() {
        guard let shouldFetchWeatherData = interactor?.shouldFetchAPIWeatherData() else { return }
        print("shouldFetchWeatherData: \(shouldFetchWeatherData)")
        shouldFetchWeatherData ? interactor?.fetchAPIWeatherData() : interactor?.fetchLocalWeatherData()
    }
}

extension MainPresenter: ViewToPresenterMainProtocol {
    
    func viewDidLoad() {
//        fetchWeatherData()
        interactor?.fetchAPIWeatherData()
    }
    
    func viewDidAppear() {
        //request Location Authorization If needed
    }
}

extension MainPresenter: InteractorToPresenterMainProtocol {
    
    func handleResult(_ result: [WeatherModel]) {
        view?.bindToViews(with: result)
        print(result)
    }
    
    func handleError(_ error: WeatherServiceError) {
        view?.showAlert(withMessage: error.localizedDescription, animated: true)
    }
}
