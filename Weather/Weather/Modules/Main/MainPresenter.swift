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
}

extension MainPresenter: ViewToPresenterMainProtocol {
    
    func viewDidLoad() {
        interactor?.fetchWeatherData()
    }
    
    func viewDidAppear() {
        //request Location Authorization If needed
    }
}

extension MainPresenter: InteractorToPresenterMainProtocol {
    
    func handleResult(_ result: Result<MainWeatherModel, WeatherServiceError>) {
        switch result {
        case .success(let model):
            view?.bindToViews(with: model)
            print(model)
        case .failure(let error):
            view?.showAlert(withMessage: error.localizedDescription, animated: true)
        }
    }
}
